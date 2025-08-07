module Map = Base.Map.Poly
module Set = Base.Set.Poly

(* TODO: the perfect implementation should differentiate between atoms in *)
(* different theories. But it requires a lot more complex parsing due to *)
(* the state that should be stored. So let's stick with simpler stuff now. *)
type atom =
  | Var of string
  | Pow2 of string
[@@deriving variants]

let eq_atom : atom -> atom -> bool = Stdlib.( = )
let internalc = ref 0

let internal () =
  let r = var (String.concat "" [ " %"; !internalc |> Int.to_string ]) in
  internalc := !internalc + 1;
  r
;;

let pp_atom fmt = function
  | Var var -> Format.fprintf fmt "%s" var
  | Pow2 var -> Format.fprintf fmt "pow2(%s)" var
;;

type rel =
  | Leq
  | Eq
[@@deriving variants]

let pp_rel fmt = function
  | Leq -> Format.fprintf fmt "<="
  | Eq -> Format.fprintf fmt "="
;;

type t =
  | True
  | Reg of Regex.t * atom list
  | Rel of rel * (atom, int) Map.t * int
  (* Logical operations. *)
  | Lnot of t
  | Land of t list
  | Lor of t list
  | Exists of atom list * t (*| Pred of string * 'atom Eia.t list*)
[@@deriving variants]

let exists vars = function
  | True -> True
  | ph -> Exists (vars, ph)
;;

let false_ = lnot true_
let neg term = Map.map ~f:( ~- ) term
let eq = rel eq
let leq = rel leq
let lt t c = leq t (pred c)
let geq t c = leq (neg t) (-c)
let gt t c = leq (neg t) (pred ~-c)

(* Structural equivalence of the IR formulas. *)
let rec equal ir ir' =
  match ir, ir' with
  | True, True -> true
  | Reg (reg, atoms), Reg (reg', atoms') -> List.equal ( = ) atoms atoms' && reg = reg'
  | Rel (rel, term, c), Rel (rel', term', c') ->
    rel = rel' && c = c' && Map.equal Int.equal term term'
  | Lnot ir, Lnot ir' -> equal ir ir'
  | Land irs, Land irs' | Lor irs, Lor irs' ->
    List.length irs = List.length irs' && List.for_all2 equal irs irs'
  | Exists (atoms, ir), Exists (atoms', ir') ->
    List.equal ( = ) atoms atoms' && equal ir ir'
  | _, _ -> false
;;

module X = struct
  type nonrec t = t

  let rec equal ir ir' =
    match ir, ir' with
    | True, True -> true
    | Reg (reg, atoms), Reg (reg', atoms') -> List.equal ( = ) atoms atoms' && reg = reg'
    | Rel (rel, term, c), Rel (rel', term', c') ->
      rel = rel' && c = c' && Map.equal Int.equal term term'
    | Lnot ir, Lnot ir' -> equal ir ir'
    | Land irs, Land irs' | Lor irs, Lor irs' -> List.for_all2 equal irs irs'
    | Exists (atoms, ir), Exists (atoms', ir') ->
      Set.equal (Set.of_list atoms) (Set.of_list atoms') && equal ir ir'
    | _, _ -> false
  ;;

  let rec hash ir =
    let hashl hash l = List.fold_left (fun acc el -> acc + hash el) 0 l in
    match ir with
    | True as ir -> Hashtbl.hash ir
    | Lnot ir -> hash ir * 2
    | Land irs | Lor irs -> hashl hash irs
    | Exists (atoms, ir) -> hashl Hashtbl.hash atoms + hash ir
    | Rel (rel, term, c) ->
      Hashtbl.hash c + Hashtbl.hash rel + (Map.data term |> List.fold_left ( + ) 0)
    | Reg (regex, atoms) -> Hashtbl.hash regex + hashl Hashtbl.hash atoms
  ;;
end

let rec pp fmt = function
  | True -> Format.fprintf fmt "true"
  | Rel (rel, term, c) ->
    Format.fprintf
      fmt
      "(%a %a %d)"
      (Format.pp_print_list
         ~pp_sep:(fun fmt () -> Format.fprintf fmt " + ")
         (fun fmt (a, b) -> Format.fprintf fmt "%d%a" b pp_atom a))
      (Map.to_alist term)
      pp_rel
      rel
      c
  | Reg (regex, atoms) ->
    Format.fprintf
      fmt
      "(%a %a)"
      Regex.pp
      regex
      (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt " + ") pp_atom)
      atoms
  | Lnot ir -> Format.fprintf fmt "~%a" pp ir
  | Land irs ->
    Format.fprintf
      fmt
      "(%a)"
      (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt " & ") pp)
      irs
  | Lor irs ->
    Format.fprintf
      fmt
      "(%a)"
      (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt " | ") pp)
      irs
  | Exists (atoms, ir) ->
    Format.fprintf
      fmt
      "(exists (%a) %a)"
      (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt ", ") pp_atom)
      atoms
      pp
      ir
;;

let rec map2 f fleaf ir =
  match ir with
  | True -> fleaf ir
  | Rel (_, _, _) -> fleaf ir
  | Reg (_, _) -> fleaf ir
  | Lnot ir' -> f (lnot (map2 f fleaf ir'))
  | Land irs -> f (land_ (List.map (map2 f fleaf) irs))
  | Lor irs -> f (lor_ (List.map (map2 f fleaf) irs))
  | Exists (atoms, ir') -> f (exists atoms (map2 f fleaf ir'))
;;

let map f ir = map2 f f ir

let rec fold f acc ir =
  match ir with
  | True -> f acc ir
  | Rel _ -> f acc ir
  | Reg (_, _) -> f acc ir
  | Lnot ir' -> f (fold f acc ir') ir
  | Land irs -> f (List.fold_left (fold f) acc irs) ir
  | Lor irs -> f (List.fold_left (fold f) acc irs) ir
  | Exists (_, ir') -> f (fold f acc ir') ir
;;

let is_used_atom (v : string) inside =
  let exception Found in
  try
    fold
      (fun () -> function
         | Rel (_, mapa, _) when Map.mem mapa (Var v) -> raise Found
         | _ -> ())
      ()
      inside;
    false
  with
  | Found -> true
;;

let for_all f ir = fold (fun acc ir -> f ir |> ( && ) acc) true ir
let for_some f ir = fold (fun acc ir -> f ir |> ( || ) acc) false ir

[@@@ocaml.warnerror "-26"]

(** An attempt to implement pretty-printer via conversion to Smtml *)
let pp_smtlib ppf (ir : t) =
  let open Smtml in
  let of_atom = function
    | Var s -> Expr.symbol (Symbol.make Ty.Ty_int s)
    | Pow2 s ->
      Expr.binop
        Ty.Ty_int
        Ty.Binop.Pow
        (Expr.value (Value.Int 2))
        (Expr.symbol (Symbol.make Ty.Ty_int s))
  in
  let rec expr_of_ir : t -> Smtml.Expr.t = function
    | True ->
      Expr.symbol (Symbol.make Ty.Ty_bool "TRUE")
      (* Expr.relop
        Ty.Ty_int
        Ty.Relop.Eq
        (Expr.value (Value.Int 42))
        (Expr.value (Value.Int 42)) *)
    | Land [ x ] -> expr_of_ir x
    | Land (x :: xs) -> Expr.Bool.and_ (expr_of_ir x) (expr_of_ir (Land xs))
    | Rel (op, args, rhs) ->
      let op =
        match op with
        | Leq -> Ty.Relop.Le
        | Eq -> Ty.Relop.Eq
      in
      let open Smtml.Expr in
      let polynom =
        let linear = Map.to_sequence ~order:`Increasing_key args in
        match Base.Sequence.hd linear with
        | None -> failwith "bad empty polynome"
        | Some h ->
          let ( + ) = Expr.binop Ty.Ty_int Ty.Binop.Add in
          let ( * ) = Expr.binop Ty.Ty_int Ty.Binop.Mul in
          let combine (key, data) =
            if data = 1 then of_atom key else value (Value.Int data) * of_atom key
          in
          Base.Sequence.fold
            (Base.Sequence.tl_eagerly_exn linear)
            ~init:(combine h)
            ~f:(fun acc item -> acc + combine item)
      in
      relop Smtml.Ty.Ty_int op polynom (value (Smtml.Value.Int rhs))
    | Exists (atoms, rhs) -> Smtml.Expr.exists (List.map of_atom atoms) (expr_of_ir rhs)
    | rez ->
      Format.eprintf "\n@[%a@]\n\n%!" pp rez;
      Printf.eprintf "%s %d\n" __FILE__ __LINE__;
      exit 1
  in
  let smtml_ir =
    match ir with
    | Land (x :: xs) ->
      Smtml.Ast.Assert (Expr.Bool.and_ (expr_of_ir x) (expr_of_ir (Land xs)))
    | Exists (atoms, xs) ->
      Smtml.Ast.Assert (Smtml.Expr.exists (List.map of_atom atoms) (expr_of_ir xs))
    | _ ->
      Printf.eprintf "%s %d\n" __FILE__ __LINE__;
      exit 1
  in
  let open Smtml.Ast in
  pp ppf smtml_ir
;;

(** A manually implemented printer to SMTLIB2-like format *)
let pp_smtlib2 ppf ir =
  let open Format in
  let rec helper ppf = function
    | True -> fprintf ppf "T"
    | Exists (atoms, rhs) ->
      fprintf
        ppf
        "@[(exists (%a)@ %a@]@ "
        (Format.pp_print_list ~pp_sep:Format.pp_print_space pp_atom)
        atoms
        helper
        rhs
    | Land [ x ] ->
      (* TODO: should be eliminated in simplifier *)
      helper ppf x
    | Land xs ->
      fprintf ppf "@[<v 2>@[(and@]@ ";
      List.iter (helper ppf) xs;
      fprintf ppf "@]"
    | Rel (op, poly, rhs) ->
      let pp_map ppf mapa =
        let one =
          fun ~key ~data ->
          match data with
          | 1 -> fprintf ppf "%a@ " pp_atom key
          | _ when data > 0 -> fprintf ppf "(* %d %a)@ " data pp_atom key
          | _ -> fprintf ppf "(* (- %d) %a)@ " (-data) pp_atom key
        in
        if Map.length mapa = 1
        then (
          let v, coeff = Map.min_elt_exn mapa in
          one ~key:v ~data:coeff)
        else (
          fprintf ppf "@[(+ ";
          Map.iteri mapa ~f:one;
          fprintf ppf ")@]@ ")
      in
      fprintf
        ppf
        "@[(%s %a %d)@]@ "
        (match op with
         | Leq -> "<="
         | Eq -> "=")
        pp_map
        poly
        rhs
    | _ ->
      Printf.eprintf "%s %d\n" __FILE__ __LINE__;
      exit 1
  in
  match ir with
  | Land xs ->
    fprintf ppf "@[<v>";
    List.iter (fprintf ppf "@[(assert %a)@]@," helper) xs;
    fprintf ppf "@]"
  | ir -> fprintf ppf "(assert %a)" helper ir
;;

type from =
  | Top
  | Bot

(** [Bound (Top, x, y)] means for variable [v] holds [v <= x/y]
    [Bound (Bot, x, y)] means for variable [v] holds [v >= x/y] *)
type bound = from * int * int

let pp_bound ppf = function
  | Top, x, y -> Format.fprintf ppf "<= %d/%d" x y
  | Bot, x, y -> Format.fprintf ppf ">= %d/%d" x y
;;

type verdict =
  | Skip
  | Stop
  | Pos
  | Neg (* varible is in linear combination with [negative] coeff *)
  | Bound of bound

let log ppf =
  match Sys.getenv "CHRO_DEBUG" with
  | exception Not_found -> Format.ifprintf Format.std_formatter ppf
  | _ -> Format.kasprintf (Format.printf "%s\n%!") ppf
;;

(** Habermehl's 2024 monotonicity simplification  *)
let simpl_monotonicty ir =
  log "ir = @[%a@]" pp ir;
  let is_bounded qvar ir =
    match ir with
    | Rel (Leq, map, rhs) when Map.length map = 1 ->
      let var, coeff = Map.min_elt_exn map in
      if var = Var qvar
      then Bound (if coeff > 0 then Top, rhs, coeff else Bot, rhs, coeff)
      else Skip
    | Rel (Leq, map, _) ->
      (match Map.find map (Var qvar) with
       | None -> Skip
       | Some c when c > 0 -> Pos
       | _ -> Neg)
    | _ when is_used_atom qvar ir -> Stop
    | _ -> Skip
  in
  match ir with
  | Exists (atoms, rhs) ->
    let vars, other_atoms =
      List.fold_left
        (fun (vars, other) atom ->
           match atom with
           | Var v -> v :: vars, other
           | o -> vars, o :: other)
        ([], [])
        atoms
    in
    if vars <> [] then log "Vars: %s" ([%show: string list] vars);
    if other_atoms <> [] then log "Other: %s" ([%show: atom list] other_atoms);
    let rewrite_rel v new_value ir =
      let ans =
        match ir with
        | Rel (r, mapa, rhs) ->
          let coeff = Map.find_exn mapa (Var v) in
          Rel (r, Map.remove mapa (Var v), rhs - (coeff * new_value))
        | ir -> ir
      in
      log "%a ~~> %a using %s=%d" pp ir pp ans v new_value;
      ans
    in
    let rec loop ~progress ivars ovars conjs ~sk =
      let _ : string list = ovars in
      match ivars with
      | [] -> sk progress ovars conjs
      | v :: ivars ->
        let exception Stop in
        (* log "Check %s" v; *)
          (try
             let verdict =
               List.fold_left
                 (fun (bounds, pos, neg, skipped) c ->
                    match is_bounded v c with
                    | Bound x -> x :: bounds, pos, neg, skipped
                    | Pos -> bounds, c :: pos, neg, skipped
                    | Neg -> bounds, pos, c :: neg, skipped
                    | Skip -> bounds, pos, neg, c :: skipped
                    | Stop -> raise Stop)
                 ([], [], [], [])
                 conjs
             in
             let verdict =
               let bounds, pos, negs, rest = verdict in
               let min, max =
                 List.fold_left
                   (fun acc b ->
                      match acc, b with
                      | (low, None), (Top, b, a) -> low, Some (b / a)
                      | (None, high), (Bot, b, a) -> Some (b / a), high
                      | (low, Some m), (Top, b, a) -> low, Some (min m (b / a))
                      | (Some m, high), (Bot, b, a) -> Some (max m (b / a)), high)
                   (None, None)
                   bounds
               in
               min, max, pos, negs, rest
             in
             match verdict with
             | None, None, _, _, _ ->
               log "Var %s is not monotonic\n%!" v;
               loop ~progress ivars (v :: ovars) conjs ~sk
             | None, Some _, _ :: _, _, other | Some _, None, _, _ :: _, other ->
               (* Can't simplify  *)
               log "Can't simplify %s: bad polarity" v;
               loop ~progress ivars (v :: ovars) conjs ~sk
             | None, Some high, [], negs, other ->
               log "Simplifying %s..." v;
               let negs = List.map (rewrite_rel v high) negs in
               loop ~progress:true ivars ovars (negs @ other) ~sk
             | Some low, None, pos, [], other ->
               log "Simplifying %s..." v;
               let pos = List.map (rewrite_rel v low) pos in
               loop ~progress:true ivars ovars (pos @ other) ~sk
             | Some low, Some high, pos, negs, other ->
               log "Simplifying %s..." v;
               let pos = List.map (rewrite_rel v low) pos in
               let negs = List.map (rewrite_rel v high) negs in
               loop ~progress:true ivars ovars (pos @ negs @ other) ~sk
           with
           | Stop ->
             log "Var %s can't be interesting: used somewhere" v;
             loop ~progress ivars (v :: ovars) conjs ~sk)
    in
    let rhs =
      match rhs with
      | Land xs -> xs
      | x -> [ x ]
    in
    let rec fixpoint stage vars other_vars rhs =
      loop ~progress:false vars [] rhs ~sk:(fun progress ovars rhs ->
        match progress, ovars with
        | false, _ | _, [] -> Exists (List.map var ovars @ other_atoms, Land rhs)
        | true, ovars ->
          log
            "After stage %d there %d variables: %s"
            stage
            (List.length ovars)
            (String.concat " " ovars);
          fixpoint (stage + 1) ovars [] rhs)
    in
    fixpoint 0 vars [] rhs
  | _ -> ir
;;
