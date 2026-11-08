open Ast
module E = Ast.Eia

exception Unsupported of string

let fail fmt = Format.kasprintf (fun s -> raise (Unsupported s)) fmt

type sexp =
  | A of string
  | L of sexp list

let rec pp ppf = function
  | A a -> Format.pp_print_string ppf a
  | L l ->
    Format.fprintf ppf "(%a)" (Format.pp_print_list ~pp_sep:Format.pp_print_space pp) l
;;

let parse s =
  let n = String.length s in
  let i = ref 0 in
  let rec ws () =
    if !i < n
    then (
      match s.[!i] with
      | ' ' | '\t' | '\n' | '\r' ->
        incr i;
        ws ()
      | ';' ->
        while !i < n && s.[!i] <> '\n' do
          incr i
        done;
        ws ()
      | _ -> ())
  in
  let until p =
    let j = !i in
    while !i < n && not (p s.[!i]) do
      incr i
    done;
    String.sub s j (!i - j)
  in
  let rec one () =
    ws ();
    if !i >= n then fail "unexpected end of input";
    match s.[!i] with
    | '(' ->
      incr i;
      let rec items acc =
        ws ();
        if !i < n && s.[!i] = ')'
        then (
          incr i;
          L (List.rev acc))
        else items (one () :: acc)
      in
      items []
    | '|' | '"' ->
      let q = s.[!i] in
      incr i;
      let a = until (( = ) q) in
      incr i;
      A a
    | _ -> A (until (String.contains " \t\n\r();|\""))
  in
  let rec all acc =
    ws ();
    if !i >= n then List.rev acc else all (one () :: acc)
  in
  all []
;;

type sort =
  | Bool
  | Int
  | BV of int
  | Arr of sort

type value =
  | F of Ast.t
  | T of Z.t E.term * sort
  | Ar of string * sort

type state =
  { mutable sorts : string list
  ; mutable env : (string * value) list
  ; mutable reads : (string * (Z.t E.term * Z.t E.term) list) list
  ; mutable side : Ast.t list
  }

let counter = ref 0
let p2 = Z.shift_left Z.one
let c = E.const
let ( === ) a b = eia (E.eq a b I)
let ( <== ) a b = eia (E.leq a b)
let ( <<< ) a b = eia (E.lt a b)
let ( +++ ) a b = E.add [ a; b ]
let ( *** ) z t = E.mul [ c z; t ]
let neg t = Z.minus_one *** t
let assume st f = st.side <- f :: st.side

let var () =
  incr counter;
  E.atom (int_var (Printf.sprintf "%%ib%d" !counter))
;;

let fresh st lo hi =
  let v = var () in
  assume st (land_ [ c lo <== v; v <== c hi ]);
  v
;;

let fresh_bv st w = fresh st Z.zero (Z.pred (p2 w))

let define st t =
  match t with
  | E.Atom _ | E.Const _ -> t
  | _ ->
    let v = var () in
    assume st (v === t);
    v
;;

let wrap st w t lo hi =
  let r = fresh_bv st w in
  assume st (r === t +++ neg (p2 w *** fresh st lo hi));
  r
;;

let rec sort st = function
  | A "Bool" -> Bool
  | A "Int" -> Int
  | L [ A "_"; A "BitVec"; A w ] -> BV (int_of_string w)
  | L [ A "Array"; _; e ] -> Arr (sort st e)
  | A s when List.mem s st.sorts -> Int
  | s -> fail "unsupported sort %a" pp s
;;

let num a = a <> "" && String.for_all (fun ch -> ch >= '0' && ch <= '9') a

let lit a =
  match String.sub a 0 2 with
  | "#b" ->
    Some (Z.of_string_base 2 (String.sub a 2 (String.length a - 2)), String.length a - 2)
  | "#x" ->
    Some
      ( Z.of_string_base 16 (String.sub a 2 (String.length a - 2))
      , 4 * (String.length a - 2) )
  | _ -> None
  | exception _ -> None
;;

let rec tr st env e =
  let go = tr st env in
  let f e =
    match go e with
    | F f -> f
    | _ -> fail "expected formula: %a" pp e
  in
  let t e =
    match go e with
    | T (t, s) -> t, s
    | _ -> fail "expected term: %a" pp e
  in
  let bv e =
    match t e with
    | t, BV w -> t, w
    | _ -> fail "expected bit-vector: %a" pp e
  in
  let bvs = List.map (fun x -> fst (bv x)) in
  let scmp strict a b w =
    let h = c (p2 (w - 1)) in
    let cmp = if strict then a <<< b else a <== b in
    lor_
      [ land_ [ a <<< h; b <<< h; cmp ]
      ; land_ [ h <== a; h <== b; cmp ]
      ; land_ [ h <== a; b <<< h ]
      ]
  in
  let const = E.is_constant_term in
  match e with
  | A "true" -> F true_
  | A "false" -> F (lnot true_)
  | A a when num a -> T (c (Z.of_string a), Int)
  | A a when lit a <> None ->
    let z, w = Option.get (lit a) in
    T (c z, BV w)
  | L [ A "_"; A bv; A w ] when String.starts_with ~prefix:"bv" bv ->
    T (c (Z.of_string (String.sub bv 2 (String.length bv - 2))), BV (int_of_string w))
  | A a ->
    (match List.assoc_opt a env with
     | Some v -> v
     | None ->
       (try List.assoc a st.env with
        | Not_found -> fail "unknown symbol %s" a))
  | L [ A "let"; L bs; body ] ->
    let bind acc = function
      | L [ A x; e ] ->
        ( x
        , match go e with
          | T (t, s) -> T (define st t, s)
          | v -> v )
        :: acc
      | b -> fail "malformed binding %a" pp b
    in
    tr st (List.fold_left bind env bs) body
  | L (A "!" :: e :: _) -> go e
  | L [ A "not"; a ] -> F (lnot (f a))
  | L (A "and" :: xs) -> F (land_ (List.map f xs))
  | L (A "or" :: xs) -> F (lor_ (List.map f xs))
  | L [ A "=>"; a; b ] -> F (lor_ [ lnot (f a); f b ])
  | L [ A "xor"; a; b ] ->
    let a, b = f a, f b in
    F (lor_ [ land_ [ a; lnot b ]; land_ [ lnot a; b ] ])
  | L [ A "ite"; i; a; b ] ->
    let i = f i in
    (match go a, go b with
     | F a, F b -> F (lor_ [ land_ [ i; a ]; land_ [ lnot i; b ] ])
     | T (a, s), T (b, _) ->
       let r = var () in
       assume st (lor_ [ land_ [ i; r === a ]; land_ [ lnot i; r === b ] ]);
       T (r, s)
     | _ -> fail "ite over arrays")
  | L [ A (("=" | "distinct") as op); a; b ] ->
    let r =
      match go a, go b with
      | T (a, _), T (b, _) -> a === b
      | F a, F b -> lor_ [ land_ [ a; b ]; land_ [ lnot a; lnot b ] ]
      | _ -> fail "array equality"
    in
    F (if op = "=" then r else lnot r)
  | L (A "=" :: x :: xs) -> F (land_ (List.map (fun y -> f (L [ A "="; x; y ])) xs))
  | L [ A "select"; a; i ] ->
    let n, s =
      match go a with
      | Ar (n, s) -> n, s
      | _ -> fail "select on non-array %a" pp a
    in
    let i = define st (fst (t i)) in
    let rs = Option.value ~default:[] (List.assoc_opt n st.reads) in
    (match List.assoc_opt i rs with
     | Some v -> T (v, s)
     | None ->
       let v =
         match s with
         | BV w -> fresh_bv st w
         | _ -> var ()
       in
       List.iter (fun (j, u) -> assume st (lor_ [ lnot (i === j); v === u ])) rs;
       st.reads <- (n, (i, v) :: rs) :: List.remove_assoc n st.reads;
       T (v, s))
  | L
      [ A
          (("bvule" | "bvult" | "bvuge" | "bvugt" | "bvsle" | "bvslt" | "bvsge" | "bvsgt")
           as op)
      ; a
      ; b
      ] ->
    let (a, w), (b, _) = bv a, bv b in
    let a, b = if op.[3] = 'g' then b, a else a, b in
    F
      (match op.[2], op.[4] with
       | 'u', 'e' -> a <== b
       | 'u', _ -> a <<< b
       | _, 'e' -> scmp false a b w
       | _ -> scmp true a b w)
  | L [ L [ A "_"; A "zero_extend"; A k ]; a ] ->
    let a, w = bv a in
    T (a, BV (w + int_of_string k))
  | L [ L [ A "_"; A "sign_extend"; A k ]; a ] ->
    let a, w = bv a in
    let k = int_of_string k in
    let r = fresh_bv st (w + k) in
    let h = c (p2 (w - 1)) in
    assume
      st
      (lor_
         [ land_ [ a <<< h; r === a ]
         ; land_ [ h <== a; r === a +++ c (Z.sub (p2 (w + k)) (p2 w)) ]
         ]);
    T (r, BV (w + k))
  | L [ L [ A "_"; A "extract"; A i; A j ]; a ] ->
    let a, w = bv a in
    let i, j = int_of_string i, int_of_string j in
    let r = fresh_bv st (i - j + 1) in
    assume
      st
      (a === E.add [ p2 (i + 1) *** fresh_bv st (w - i - 1); p2 j *** r; fresh_bv st j ]);
    T (r, BV (i - j + 1))
  | L (A "concat" :: x :: xs) ->
    let t, w =
      List.fold_left
        (fun (acc, w) y ->
           let y, wy = bv y in
           (p2 wy *** acc) +++ y, w + wy)
        (bv x)
        xs
    in
    T (t, BV w)
  | L (A "bvadd" :: x :: xs) ->
    let x, w = bv x in
    T (List.fold_left (fun acc y -> wrap st w (acc +++ y) Z.zero Z.one) x (bvs xs), BV w)
  | L [ A "bvsub"; a; b ] ->
    let (a, w), (b, _) = bv a, bv b in
    T (wrap st w (a +++ neg b) Z.minus_one Z.zero, BV w)
  | L [ A "bvneg"; a ] ->
    let a, w = bv a in
    T (wrap st w (neg a) Z.minus_one Z.zero, BV w)
  | L [ A "bvnot"; a ] ->
    let a, w = bv a in
    T (c (Z.pred (p2 w)) +++ neg a, BV w)
  | L (A "bvmul" :: x :: xs) ->
    let x, w = bv x in
    let mul acc y =
      match const acc, const y with
      | Some k, _ -> wrap st w (k *** y) Z.zero (Z.max Z.zero (Z.pred k))
      | _, Some k -> wrap st w (k *** acc) Z.zero (Z.max Z.zero (Z.pred k))
      | _ -> wrap st w (E.mul [ acc; y ]) Z.zero (Z.pred (p2 w))
    in
    T (List.fold_left mul x (bvs xs), BV w)
  | L [ A (("bvudiv" | "bvurem") as op); a; b ] ->
    let (a, w), (b, _) = bv a, bv b in
    (match const b with
     | Some d when Z.equal d Z.zero ->
       T ((if op = "bvudiv" then c (Z.pred (p2 w)) else a), BV w)
     | Some d ->
       let q, r = fresh_bv st w, fresh st Z.zero (Z.pred d) in
       assume st (a === (d *** q) +++ r);
       T ((if op = "bvudiv" then q else r), BV w)
     | None -> fail "%s by non-constant" op)
  | L [ A (("bvshl" | "bvlshr") as op); a; b ] ->
    let (a, w), (b, _) = bv a, bv b in
    (match const b with
     | Some k when Z.geq k (Z.of_int w) -> T (c Z.zero, BV w)
     | Some k when op = "bvshl" ->
       let k = Z.to_int k in
       T (wrap st w (p2 k *** a) Z.zero (Z.pred (p2 k)), BV w)
     | Some k ->
       let k = Z.to_int k in
       let q = fresh_bv st (w - k) in
       assume st (a === (p2 k *** q) +++ fresh_bv st k);
       T (q, BV w)
     | None -> fail "%s by non-constant" op)
  | L (A (("bvand" | "bvor" | "bvxor") as op) :: x :: xs) ->
    let x, w = bv x in
    let g =
      match op with
      | "bvand" -> E.bwand
      | "bvor" -> E.bwor
      | _ -> E.bwxor
    in
    T (List.fold_left g x (bvs xs), BV w)
  | L (A (("+" | "*") as op) :: xs) ->
    T ((if op = "+" then E.add else E.mul) (List.map (fun x -> fst (t x)) xs), Int)
  | L [ A "-"; a ] -> T (neg (fst (t a)), Int)
  | L [ A "-"; a; b ] -> T (fst (t a) +++ neg (fst (t b)), Int)
  | L [ A (("<=" | "<" | ">=" | ">") as op); a; b ] ->
    let a, b = fst (t a), fst (t b) in
    F
      (match op with
       | "<=" -> a <== b
       | "<" -> a <<< b
       | ">=" -> b <== a
       | _ -> b <<< a)
  | _ -> fail "unsupported expression %a" pp e
;;

let sym ty s = Smtml.Symbol.make_const ty s

let commands src =
  let st = ref { sorts = []; env = []; reads = []; side = [] } in
  let stack = ref [] in
  let decl x s =
    !st.env
    <- ( x
       , match s with
         | Bool -> F (pred x)
         | Arr e -> Ar (x, e)
         | Int | BV _ -> T (E.atom (int_var x), s) )
       :: !st.env;
    match s with
    | Arr _ -> []
    | Bool ->
      [ Smtml.Ast.Declare_const
          { id = sym Smtml.Ty.Ty_bool x; sort = sym Smtml.Ty.Ty_bool "Bool" }
      ]
    | _ ->
      (match s with
       | BV w ->
         assume
           !st
           (land_
              [ c Z.zero <== E.atom (int_var x)
              ; E.atom (int_var x) <== c (Z.pred (p2 w))
              ])
       | _ -> ());
      [ Smtml.Ast.Declare_const
          { id = sym Smtml.Ty.Ty_int x; sort = sym Smtml.Ty.Ty_int "Int" }
      ]
  in
  let assert_ ast =
    let ast = land_ (ast :: !st.side) in
    !st.side <- [];
    Fe.blast ast
  in
  List.concat_map
    (function
      | L [ A "declare-sort"; A s; A "0" ] ->
        !st.sorts <- s :: !st.sorts;
        []
      | L [ A "declare-const"; A x; s ] | L [ A "declare-fun"; A x; L []; s ] ->
        decl x (sort !st s)
      | L [ A "define-fun"; A x; L []; _; e ] ->
        !st.env <- (x, tr !st [] e) :: !st.env;
        []
      | L [ A "assert"; e ] ->
        (match tr !st [] e with
         | F f -> [ assert_ f ]
         | _ -> fail "assert of a non-formula")
      | L [ A "push"; A n ] ->
        stack := { !st with side = !st.side } :: !stack;
        [ Smtml.Ast.Push (int_of_string n) ]
      | L [ A "pop"; A n ] ->
        st := List.hd !stack;
        stack := List.tl !stack;
        [ Smtml.Ast.Pop (int_of_string n) ]
      | L [ A "check-sat" ] ->
        (if !st.side = [] then [] else [ assert_ true_ ]) @ [ Smtml.Ast.Check_sat [] ]
      | L [ A "get-model" ] -> [ Smtml.Ast.Get_model ]
      | L [ A "set-info"; A ":status"; A v ] ->
        [ Smtml.Ast.Set_info
            (Smtml.Expr.app
               (sym Smtml.Ty.Ty_none ":status")
               [ Smtml.Expr.symbol (sym Smtml.Ty.Ty_none v) ])
        ]
      | L
          (A
             ( "set-info"
             | "set-option"
             | "set-logic"
             | "exit"
             | "get-value"
             | "get-info"
             | "echo" )
          :: _) -> []
      | cmd -> fail "unsupported command %a" pp cmd)
    (parse src)
;;

let applies src =
  List.exists
    (fun k ->
       let n, m = String.length src, String.length k in
       let rec go i = i + m <= n && (String.sub src i m = k || go (i + 1)) in
       go 0)
    [ "BitVec"; "declare-sort" ]
;;
