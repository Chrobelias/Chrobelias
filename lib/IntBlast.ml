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
  ; mutable reads : (string * (Z.t E.term list * Z.t E.term) list) list
  ; mutable side : Ast.t list
  ; mutable funs : (string * sort) list
  ; mutable norms : ((Z.t E.term * int) * Z.t E.term) list
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

let bounds = Hashtbl.create 64

let vals = Hashtbl.create 64
let bits = Hashtbl.create 64

let bound v lo hi =
  match v with
  | E.Atom (Var (n, _)) -> Hashtbl.replace bounds n (lo, hi)
  | _ -> ()
;;

let rec itv : Z.t E.term -> (Z.t * Z.t) option = function
  | E.Const z -> Some (z, z)
  | E.Atom (Var (n, _)) -> Hashtbl.find_opt bounds n
  | E.Add ts ->
    List.fold_left
      (fun acc t ->
         match acc, itv t with
         | Some (a, b), Some (x, y) -> Some (Z.add a x, Z.add b y)
         | _ -> None)
      (Some (Z.zero, Z.zero))
      ts
  | E.Mul ts ->
    List.fold_left
      (fun acc t ->
         match acc, itv t with
         | Some (a, b), Some (x, y) ->
           let cs = [ Z.mul a x; Z.mul a y; Z.mul b x; Z.mul b y ] in
           Some
             (List.fold_left Z.min (List.hd cs) cs, List.fold_left Z.max (List.hd cs) cs)
         | _ -> None)
      (Some (Z.one, Z.one))
      ts
  | _ -> None
;;

let fresh st lo hi =
  let v = var () in
  bound v lo hi;
  assume st (land_ [ c lo <== v; v <== c hi ]);
  v
;;

let fresh_bv st w = fresh st Z.zero (Z.pred (p2 w))

let define st t =
  match t with
  | E.Atom _ | E.Const _ -> t
  | _ ->
    let v = var () in
    Option.iter (fun (lo, hi) -> bound v lo hi) (itv t);
    assume st (v === t);
    v
;;

let norm st w t =
  match List.assoc_opt (t, w) st.norms with
  | Some r -> r
  | None ->
    let m = p2 w in
    let r =
      match itv t with
      | Some (l, h) when Z.equal (Z.fdiv l m) (Z.fdiv h m) ->
        define st (t +++ c (Z.neg (Z.mul (Z.fdiv l m) m)))
      | i ->
        let r = fresh_bv st w in
        let q =
          match i with
          | Some (l, h) -> fresh st (Z.fdiv l m) (Z.fdiv h m)
          | None -> var ()
        in
        assume st (r === t +++ neg (m *** q));
        r
    in
    st.norms <- ((t, w), r) :: st.norms;
    r
;;

let extract st a w i j =
  let r = fresh_bv st (i - j + 1) in
  assume
    st
    (a === E.add [ p2 (i + 1) *** fresh_bv st (w - i - 1); p2 j *** r; fresh_bv st j ]);
  r
;;

let mask st a w m =
  let rec go j acc =
    if j >= w
    then acc
    else if not (Z.testbit m j)
    then go (j + 1) acc
    else (
      let i = ref j in
      while !i + 1 < w && Z.testbit m (!i + 1) do
        incr i
      done;
      go (!i + 1) ((p2 j *** extract st a w !i j) :: acc))
  in
  E.add (c Z.zero :: go 0 [])
;;

let barrel st shl a w b =
  let hi = Option.fold ~none:(p2 w) ~some:snd (itv b) in
  let n = Z.numbits (Z.min hi (Z.of_int (w - 1))) in
  let bs = List.init n (fun _ -> fresh st Z.zero Z.one) in
  let sum = E.add (c Z.zero :: List.mapi (fun i x -> p2 i *** x) bs) in
  let layer (s, i) x =
    let k = 1 lsl i in
    let s' = fresh_bv st w in
    let t = fresh st Z.zero (Z.pred (p2 k)) in
    let u, v = if shl then s', (p2 k *** s) +++ neg (p2 w *** t) else s, (p2 k *** s') +++ t in
    assume st (lor_ [ land_ [ x === c Z.zero; s' === s ]; land_ [ x === c Z.one; u === v ] ]);
    s', i + 1
  in
  let s, _ = List.fold_left layer (a, 0) bs in
  if Z.lt hi (p2 n)
  then (
    assume st (b === sum);
    s)
  else (
    let h = fresh st Z.zero (Z.fdiv hi (p2 n)) in
    let r = fresh_bv st w in
    assume
      st
      (land_
         [ b === sum +++ (p2 n *** h)
         ; lor_ [ land_ [ h === c Z.zero; r === s ]; land_ [ c Z.one <== h; r === c Z.zero ] ]
         ]);
    r)
;;

let signed st w x =
  let s = fresh st (Z.neg (p2 (w - 1))) (Z.pred (p2 (w - 1))) in
  assume st (s === x +++ neg (p2 w *** fresh st Z.zero Z.one));
  s
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
  let read n s is =
    let is =
      List.map
        (fun i ->
          match go i with
          | T (i, BV w) -> norm st w i
          | T (i, _) -> define st i
          | _ -> fail "non-term index %a" pp i)
        is
    in
    let rs = Option.value ~default:[] (List.assoc_opt n st.reads) in
    match List.assoc_opt is rs with
    | Some v -> T (v, s)
    | None ->
      let v =
        match s with
        | BV w -> fresh_bv st w
        | _ -> var ()
      in
      List.iter
        (fun (js, u) ->
          assume st (lor_ ((v === u) :: List.map2 (fun i j -> lnot (i === j)) is js)))
        rs;
      st.reads <- (n, (is, v) :: rs) :: List.remove_assoc n st.reads;
      T (v, s)
  in
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
  let raw e =
    match t e with
    | t, BV w -> t, w
    | _ -> fail "expected bit-vector: %a" pp e
  in
  let bv e =
    let t, w = raw e in
    norm st w t, w
  in
  let bvs = List.map (fun x -> fst (bv x)) in
  let raws = List.map (fun x -> fst (raw x)) in
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
       (match itv a, itv b with
        | Some (l1, h1), Some (l2, h2) -> bound r (Z.min l1 l2) (Z.max h1 h2)
        | _ -> ());
       (match a, b, r with
        | E.Const x, E.Const y, E.Atom (Var (n, _)) -> Hashtbl.replace vals n [ x; y ]
        | _ -> ());
       assume st (lor_ [ land_ [ i; r === a ]; land_ [ lnot i; r === b ] ]);
       T (r, s)
     | _ -> fail "ite over arrays")
  | L [ A (("=" | "distinct") as op); a; b ] ->
    let r =
      match go a, go b with
      | T (a, BV w), T (b, _) -> norm st w a === norm st w b
      | T (a, _), T (b, _) -> a === b
      | F a, F b -> lor_ [ land_ [ a; b ]; land_ [ lnot a; lnot b ] ]
      | _ -> fail "array equality"
    in
    F (if op = "=" then r else lnot r)
  | L (A "=" :: x :: xs) -> F (land_ (List.map (fun y -> f (L [ A "="; x; y ])) xs))
  | L [ A "select"; a; i ] ->
    (match go a with
     | Ar (n, s) -> read n s [ i ]
     | _ -> fail "select on non-array %a" pp a)
  | L (A n :: is) when List.mem_assoc n st.funs ->
    (match List.assoc n st.funs with
     | Bool ->
       (match read n (BV 1) is with
        | T (v, _) -> F (v === c Z.one)
        | v -> v)
     | s -> read n s is)
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
    T (extract st a w i j, BV (i - j + 1))
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
    let x, w = raw x in
    T (List.fold_left ( +++ ) x (raws xs), BV w)
  | L [ A "bvsub"; a; b ] ->
    let (a, w), (b, _) = raw a, raw b in
    T (a +++ neg b, BV w)
  | L [ A "bvneg"; a ] ->
    let a, w = raw a in
    T (neg a, BV w)
  | L [ A "bvnot"; a ] ->
    let a, w = raw a in
    T (c (Z.pred (p2 w)) +++ neg a, BV w)
  | L (A "bvmul" :: x :: xs) ->
    let x, w = raw x in
    let mul acc y =
      match const acc, const y with
      | Some k, _ -> k *** y
      | _, Some k -> k *** acc
      | _ -> E.mul [ norm st w acc; norm st w y ]
    in
    T (List.fold_left mul x (raws xs), BV w)
  | L [ A (("bvsmul_noovfl" | "bvsmul_noudfl") as op); a; b ] ->
    let (a, w), (b, _) = bv a, bv b in
    let p = E.mul [ signed st w a; signed st w b ] in
    F
      (if op = "bvsmul_noovfl"
       then p <== c (Z.pred (p2 (w - 1)))
       else c (Z.neg (p2 (w - 1))) <== p)
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
     | Some k when op = "bvshl" -> T (p2 (Z.to_int k) *** a, BV w)
     | Some k ->
       let k = Z.to_int k in
       let q = fresh_bv st (w - k) in
       assume st (a === (p2 k *** q) +++ fresh_bv st k);
       T (q, BV w)
     | None
       when match itv b with
            | Some (lo, hi) -> Z.leq (Z.sub hi lo) (Z.of_int 64)
            | None -> false ->
       let lo, hi = Option.get (itv b) in
       let r = fresh_bv st w in
       let x =
         if op = "bvshl"
         then fresh st Z.zero (Z.pred (p2 (Z.to_int (Z.min hi (Z.of_int w)))))
         else var ()
       in
       let case k =
         if Z.geq k (Z.of_int w)
         then r === c Z.zero
         else (
           let k = Z.to_int k in
           if op = "bvshl"
           then r === (p2 k *** a) +++ neg (p2 w *** x)
           else land_ [ c Z.zero <== x; x <<< c (p2 k); a === (p2 k *** r) +++ x ])
       in
       let ks = List.init (Z.to_int (Z.sub hi lo) + 1) (fun i -> Z.add lo (Z.of_int i)) in
       assume st (lor_ (List.map (fun k -> land_ [ b === c k; case k ]) ks));
       T (r, BV w)
     | None -> T (barrel st (op = "bvshl") a w b, BV w))
  | L [ A (("bvsdiv" | "bvsrem" | "bvsmod") as op); a; b ] ->
    let (a, w), (b, _) = bv a, bv b in
    (match const b with
     | Some d when Z.gt d Z.zero && Z.lt d (p2 (w - 1)) ->
       let n, q, r, res =
         fresh_bv st w, fresh_bv st w, fresh st Z.zero (Z.pred d), fresh_bv st w
       in
       let m, zero = c (p2 w), c Z.zero in
       let pos = a <<< c (p2 (w - 1)) in
       let v = if op = "bvsdiv" then q else r in
       let neg_res =
         if op = "bvsmod"
         then
           lor_
             [ land_ [ r === zero; res === zero ]
             ; land_ [ zero <<< r; res === c d +++ neg r ]
             ]
         else lor_ [ res +++ v === zero; res +++ v === m ]
       in
       assume st (lor_ [ land_ [ pos; n === a ]; land_ [ lnot pos; n === m +++ neg a ] ]);
       assume st (n === (d *** q) +++ r);
       assume st (lor_ [ land_ [ pos; res === v ]; land_ [ lnot pos; neg_res ] ]);
       T (res, BV w)
     | _ ->
       let z = c Z.zero in
       let sa, sb = signed st w a, signed st w b in
       let pa, pb = z <== sa, z <== sb in
       let ab x =
         let n = fresh st Z.zero (p2 (w - 1)) in
         assume st (lor_ [ land_ [ z <== x; n === x ]; land_ [ x <<< z; n === neg x ] ]);
         n
       in
       let na, nb = ab sa, ab sb in
       let q, r = fresh_bv st w, fresh_bv st w in
       assume st (na === E.mul [ nb; q ] +++ r);
       assume st (lor_ [ land_ [ nb === z; q === c (Z.pred (p2 w)) ]; r <<< nb ]);
       let same = lor_ [ land_ [ pa; pb ]; land_ [ lnot pa; lnot pb ] ] in
       let cases =
         match op with
         | "bvsdiv" -> [ same, q; lnot same, neg q ]
         | "bvsrem" -> [ pa, r; lnot pa, neg r ]
         | _ ->
           let nz = z <<< r in
           [ r === z, z
           ; land_ [ nz; same; pa ], r
           ; land_ [ nz; same; lnot pa ], neg r
           ; land_ [ nz; lnot same; pa ], r +++ sb
           ; land_ [ nz; lnot same; lnot pa ], sb +++ neg r
           ]
       in
       let v = var () in
       assume st (lor_ (List.map (fun (g, x) -> land_ [ g; v === x ]) cases));
       T (norm st w v, BV w))
  | L (A (("bvand" | "bvor" | "bvxor") as op) :: x :: xs) ->
    let x, w = bv x in
    let cst a m =
      let x = mask st a w m in
      match op with
      | "bvand" -> x
      | "bvor" -> a +++ c m +++ neg x
      | _ -> a +++ c m +++ (Z.of_int (-2) *** x)
    in
    let vs = function
      | E.Atom (Var (n, _)) -> Hashtbl.find_opt vals n
      | _ -> None
    in
    let split a ms b =
      let r = fresh_bv st w in
      assume st (lor_ (List.map (fun m -> land_ [ a === c m; r === cst b m ]) ms));
      r
    in
    let g a b =
      match const a, const b, vs a, vs b with
      | Some m, _, _, _ -> cst b m
      | _, Some m, _, _ -> cst a m
      | _, _, Some ms, _ -> split a ms b
      | _, _, _, Some ms -> split b ms a
      | _ ->
        let n t = Z.numbits (Option.fold ~none:(Z.pred (p2 w)) ~some:snd (itv t)) in
        let k = if op = "bvand" then min (n a) (n b) else max (n a) (n b) in
        if max (n a) (n b) > 64
        then (
          match op with
          | "bvand" -> E.bwand a b
          | "bvor" -> E.bwor a b
          | _ -> E.bwxor a b)
        else (
          let dec t =
            let bs =
              match Hashtbl.find_opt bits t with
              | Some bs -> bs
              | None ->
                let bs = List.init (n t) (fun _ -> fresh st Z.zero Z.one) in
                assume st (t === E.add (c Z.zero :: List.mapi (fun i x -> p2 i *** x) bs));
                Hashtbl.replace bits t bs;
                bs
            in
            List.init k (fun i -> Option.value (List.nth_opt bs i) ~default:(c Z.zero))
          in
          let one x y =
            let r = fresh st Z.zero Z.one in
            let s = x +++ y in
            assume
              st
              (land_
                 (match op with
                  | "bvand" -> [ r <== x; r <== y; s <== (c Z.one +++ r) ]
                  | "bvor" -> [ x <== r; y <== r; r <== s ]
                  | _ ->
                    [ r <== s
                    ; s <== (c (Z.of_int 2) +++ neg r)
                    ; x +++ neg y <== r
                    ; y +++ neg x <== r
                    ]));
            r
          in
          let rs = List.map2 one (dec a) (dec b) in
          E.add (c Z.zero :: List.mapi (fun i x -> p2 i *** x) rs))
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
  let st = ref { sorts = []; env = []; reads = []; side = []; funs = []; norms = [] } in
  let stack = ref [] in
  let decl x s =
    let v = E.atom (int_var x) in
    !st.env
    <- ( x
       , match s with
         | Bool -> F (pred x)
         | Arr e -> Ar (x, e)
         | Int | BV _ -> T (v, s) )
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
         bound v Z.zero (Z.pred (p2 w));
         assume !st (land_ [ c Z.zero <== v; v <== c (Z.pred (p2 w)) ])
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
      | L [ A "declare-fun"; A x; L _; s ] ->
        !st.funs <- (x, sort !st s) :: !st.funs;
        []
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

let dump cmds =
  let declared = Hashtbl.create 16 in
  let p fmt = Format.printf (fmt ^^ "@.") in
  List.iter
    (function
      | Smtml.Ast.Declare_const { id; sort } ->
        Hashtbl.replace declared (Smtml.Symbol.to_string id) ();
        p
          "(declare-fun %a () %a)"
          pp_symbol
          (Smtml.Symbol.to_string id)
          Smtml.Symbol.pp
          sort
      | Smtml.Ast.Assert e ->
        let ast = Fe.to_ast Base.Map.Poly.empty e in
        Base.Set.iter (collect_free_vars ast) ~f:(fun v ->
          if not (Hashtbl.mem declared v)
          then (
            Hashtbl.replace declared v ();
            p "(declare-fun %a () Int)" pp_symbol v));
        p "@[<v 2>(assert@,%a)@]" pp_smtlib2 ast
      | Smtml.Ast.Check_sat _ -> p "(check-sat)"
      | Smtml.Ast.Get_model -> p "(get-model)"
      | Smtml.Ast.Push n -> p "(push %d)" n
      | Smtml.Ast.Pop n -> p "(pop %d)" n
      | _ -> ())
    cmds
;;
