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

let internal_name () =
  let r = String.concat "" [ " %"; !internalc |> Int.to_string ] in
  internalc := !internalc + 1;
  r
;;

let internal () = var (internal_name ())

let internal_pow () =
  let name = String.concat "" [ "%"; !internalc |> Int.to_string ] in
  let r = pow2 name in
  let log_r = var name in
  internalc := !internalc + 1;
  r, log_r
;;

let pp_atom fmt = function
  | Var var -> Format.fprintf fmt "%s" var
  | Pow2 var -> Format.fprintf fmt "pow2(%s)" var
;;

type rel = SimplII.relop =
  | Leq
  | Eq
[@@deriving variants]

let pp_rel fmt = function
  | Leq -> Format.fprintf fmt "<="
  | Eq -> Format.fprintf fmt "="
;;

type polynom = (atom, Z.t) Map.t

let pp_polynom ppf m = Format.fprintf ppf "<polynom>"

type t =
  | True
  | Reg of bool list Regex.t * atom list
  | SReg of atom * char list Regex.t
  | SLen of atom * atom
  | Stoi of atom * atom
  | Rel of rel * polynom * Z.t
  (* Logical operations. *)
  | Lnot of t
  | Land of t list
  | Lor of t list
  | Exists of atom list * t (*| Pred of string * 'atom Eia.t list*)
[@@deriving variants]

let rec pp fmt = function
  | True -> Format.fprintf fmt "true"
  | SReg (atom, re) ->
    Format.fprintf
      fmt
      "(str.in.re %a %a)"
      pp_atom
      atom
      (Regex.pp (fun ppf bv ->
         Format.fprintf ppf "%a" (Format.pp_print_list Format.pp_print_char) bv))
      re (* TODO: print regex *)
  | SLen (atom, atom') ->
    Format.fprintf fmt "(= %a (str.len %a))" pp_atom atom pp_atom atom'
  | Stoi (atom, atom') ->
    Format.fprintf fmt "(= %a (str.to.int %a))" pp_atom atom pp_atom atom'
  | Rel (rel, term, c) ->
    Format.fprintf
      fmt
      "(%a %a %a)"
      (Format.pp_print_list
         ~pp_sep:(fun fmt () -> Format.fprintf fmt " + ")
         (fun fmt (a, b) -> Format.fprintf fmt "%a%a" Z.pp_print b pp_atom a))
      (Map.to_alist term)
      pp_rel
      rel
      Z.pp_print
      c
  | Reg (regex, atoms) ->
    Format.fprintf
      fmt
      "(%a %a)"
      (Regex.pp (fun ppf bv ->
         Format.fprintf
           ppf
           "%a"
           (Format.pp_print_list (fun ppf b ->
              Format.fprintf ppf (if b then "1" else "0")))
           bv))
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

(** A manually implemented printer to SMTLIB2-like format *)
let pp_smtlib2 ppf ir =
  let open Format in
  (* https://microsoft.github.io/z3guide/docs/theories/Regular%20Expressions *)
  let ( -- ) i j =
    let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
    aux j []
  in
  let z_of_list_msb p =
    let length = List.length p in
    let bv_init deg f =
      List.fold_left
        (fun acc v -> if f v then Z.logor acc (Z.shift_left Z.one v) else acc)
        Z.zero
        (0 -- (deg - 1))
    in
    bv_init length (fun i -> List.nth p i) |> Z.to_int
  in
  let pp_sym ppf bv = Format.fprintf ppf "%d" (z_of_list_msb bv) in
  let rec helper ppf = function
    | True -> fprintf ppf "T"
    | Exists (atoms, rhs) ->
      fprintf
        ppf
        "@[(exists (%a)@ %a)@]@ "
        (Format.pp_print_list ~pp_sep:Format.pp_print_space pp_atom)
        atoms
        helper
        rhs
      (* fprintf ppf "@[<v 2>";
      fprintf
        ppf
        "@[(exists (%a)@ @]@ @[%a@])@]@ "
        (Format.pp_print_list ~pp_sep:pp_print_space pp_atom)
        atoms
        helper
        rhs;
      (* Format.eprintf "\nexists = @[%a@]\n\n%!" pp_old e; *)
      fprintf ppf ")@]" *)
    | (SLen _ | Stoi _ | SReg _) as ir -> Format.fprintf ppf "%a" pp ir
    | Land [ x ] ->
      (* TODO: should be eliminated in simplifier *)
      helper ppf x
    | Land xs ->
      fprintf ppf "@[<v 2>@[(and@]@ ";
      List.iter (helper ppf) xs;
      fprintf ppf "@]"
    | Lor xs ->
      fprintf ppf "@[<v 2>@[(or@]@ ";
      List.iter (helper ppf) xs;
      fprintf ppf "@]"
    | Rel (op, poly, rhs) ->
      let pp_map ppf mapa =
        let one =
          fun ~key ~data ->
          match data with
          | data when data = Z.one -> fprintf ppf "%a@ " pp_atom key
          | data when data > Z.zero ->
            fprintf ppf "(* %a %a)@ " Z.pp_print data pp_atom key
          | _ -> fprintf ppf "(* (- %a) %a)@ " Z.pp_print (Z.( ~- ) data) pp_atom key
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
        "@[(%s %a %a)@]@ "
        (match op with
         | Leq -> "<="
         | Eq -> "=")
        pp_map
        poly
        Z.pp_print
        rhs
    | Lnot ph -> fprintf ppf "@[(not %a)@]" helper ph
    | Reg (r, atoms) ->
      fprintf ppf "@[(%a" (Regex.pp pp_sym) r;
      (* List.iter (fprintf ppf " %a" pp_atom) atoms; *)
      fprintf ppf ")@]"
  in
  match ir with
  | Land xs ->
    fprintf ppf "@[<v>";
    List.iter (fprintf ppf "@[(assert %a)@]@," helper) xs;
    fprintf ppf "@]"
  | ir -> fprintf ppf "(assert %a)" helper ir
;;

let exists vars = function
  | True -> True
  | ph -> Exists (vars, ph)
;;

let false_ = lnot true_

let of_bool = function
  | true -> True
  | false -> false_
;;

let neg term = Map.map ~f:Z.( ~- ) term

let is_zero_lhs (map : (atom, Z.t) Map.t) =
  match Map.length map with
  | 0 -> true
  | 1 -> Z.(snd (Map.min_elt_exn map) = zero)
  | _ -> false
;;

let eq = rel eq
let leq m rhs = if is_zero_lhs m then of_bool Z.(zero <= rhs) else rel Leq m rhs
let lt t c = leq t Z.(pred c)
let geq t c = leq (neg t) Z.(-c)
let gt t c = leq (neg t) Z.(pred ~-c)

(* Structural equivalence of the IR formulas. *)
let rec equal ir ir' =
  match ir, ir' with
  | True, True -> true
  | Reg (reg, atoms), Reg (reg', atoms') -> List.equal ( = ) atoms atoms' && reg = reg'
  | Rel (rel, term, c), Rel (rel', term', c') ->
    rel = rel' && c = c' && Map.equal ( = ) term term'
  | Lnot ir, Lnot ir' -> equal ir ir'
  | Land irs, Land irs' | Lor irs, Lor irs' ->
    List.length irs = List.length irs' && List.for_all2 equal irs irs'
  | Exists (atoms, ir), Exists (atoms', ir') ->
    List.equal ( = ) atoms atoms' && equal ir ir'
  | SReg (atom, regex), SReg (atom', regex') -> atom = atom' && regex = regex'
  | SLen (atom, atom'), SLen (atom'', atom''') | Stoi (atom, atom'), Stoi (atom'', atom''')
    -> atom = atom'' && atom' = atom'''
  | _, _ -> false
;;

let rec map2 f fleaf ir =
  match ir with
  | True -> fleaf ir
  | Rel (_, _, _) -> fleaf ir
  | Reg (_, _) -> fleaf ir
  | SReg (_, _) -> fleaf ir
  | SLen (_, _) -> fleaf ir
  | Stoi (_, _) -> fleaf ir
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
  | SReg (_, _) -> f acc ir
  | SLen (_, _) -> f acc ir
  | Stoi (_, _) -> f acc ir
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

type from =
  | Top
  | Bot

(** [Bound (Top, x, y)] means for variable [v] holds [v <= x/y]
    [Bound (Bot, x, y)] means for variable [v] holds [v >= x/y] *)
type bound = from * Z.t * Z.t

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
  let is_bounded qvar ir =
    match ir with
    | Rel (Leq, map, rhs) when Map.length map = 1 ->
      let var, coeff = Map.min_elt_exn map in
      if var = Var qvar
      then Bound (if coeff > Z.zero then Top, rhs, coeff else Bot, rhs, coeff)
      else Skip
    | Rel (Leq, map, _) ->
      (match Map.find map (Var qvar) with
       | None -> Skip
       | Some c when Z.(c > zero) -> Pos
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
          Rel (r, Map.remove mapa (Var v), Z.(rhs - (coeff * new_value)))
        | ir -> ir
      in
      log "%a ~~> %a using %s=%a" pp ir pp ans v Z.pp_print new_value;
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
                      | (low, None), (Top, b, a) -> low, Some Z.(b / a)
                      | (None, high), (Bot, b, a) -> Some Z.(b / a), high
                      | (low, Some m), (Top, b, a) -> low, Some (min m Z.(b / a))
                      | (Some m, high), (Bot, b, a) -> Some (max m Z.(b / a)), high)
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
          fixpoint (Int.add stage 1) ovars [] rhs)
    in
    fixpoint 0 vars [] rhs
  | _ -> ir
;;
