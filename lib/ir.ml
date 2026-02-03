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
  let r = String.concat "" [ "%"; !internalc |> Int.to_string ] in
  internalc := !internalc + 1;
  r
;;

let name = function
  | Var name -> name
  | Pow2 name -> Format.asprintf "%a" Z.pp_print (Config.base ()) ^ name
;;

let internal () = var (internal_name ())

let internal_pow () =
  let name = internal_name () in
  let r = pow2 name in
  let log_r = var name in
  r, log_r
;;

let pp_atom fmt = function
  | Var var -> Format.fprintf fmt "%s" var
  | Pow2 var -> Format.fprintf fmt "pow2(%s)" var
;;

type rel =
  | Leq
  | Eq
  | Neq
[@@deriving variants]

let pp_rel fmt = function
  | Leq -> Format.fprintf fmt "<="
  | Eq -> Format.fprintf fmt "="
  | Neq -> Format.fprintf fmt "distinct"
;;

type polynom = (atom, Z.t) Map.t

let pp_polynom ppf poly =
  let fprintf = Format.fprintf in
  let pp_map ppf mapa =
    let one =
      fun ~key ~data ->
      match data with
      | data when data = Z.one -> fprintf ppf "%a@ " pp_atom key
      | data when data > Z.zero -> fprintf ppf "(* %a %a)@ " Z.pp_print data pp_atom key
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
  fprintf ppf "@[(%a)@]@ " pp_map poly
;;

module NfaS = Nfa.Lsb (Nfa.Str)

type t =
  | True
  | Reg of bool list Regex.t * atom list
  | SReg of atom * char list Regex.t
  | SRegRaw of atom * NfaS.t
  | SPrefixOf of atom * atom
  | SSuffixOf of atom * atom
  | SContains of atom * atom
  | SLen of atom * atom
  | Stoi of atom * atom
  | Itos of atom * atom
  | Rel of rel * polynom * Z.t
  (* Logical operations. *)
  | Lnot of t
  | Land of t list
  | Lor of t list
  | Exists of atom list * t (*| Pred of string * 'atom Eia.t list*)
  | Unsupp of string

let true_ = True
let reg a b = Reg (a, b)
let sreg a b = SReg (a, b)
let sregraw a b = SRegRaw (a, b)
let sprefixof a b = SPrefixOf (a, b)
let ssuffixof a b = SSuffixOf (a, b)
let scontains a b = SContains (a, b)
let slen a b = SLen (a, b)
let stoi a b = Stoi (a, b)
let itos a b = Itos (a, b)
let rel a b c = Rel (a, b, c)

let land_ = function
  | [] -> true_
  | [ ast ] -> ast
  | asts when List.exists (( = ) (Lnot True)) asts -> Lnot True
  | asts ->
    let asts =
      List.concat_map
        (function
          | Land asts' -> asts'
          | ast -> [ ast ])
        asts
    in
    Land asts
;;

let lor_ = function
  | [] -> true_
  | [ ast ] -> ast
  | asts when List.exists (( = ) True) asts -> True
  | asts ->
    let asts =
      List.map
        (function
          | Lor asts' -> asts'
          | ast -> [ ast ])
        asts
      |> List.concat
    in
    Lor asts
;;

let rec lnot = function
  | Lnot ast -> ast
  | Land asts -> lor_ (List.map lnot asts)
  | Lor asts -> land_ (List.map lnot asts)
  | ast -> Lnot ast
;;

let rec pp fmt = function
  | True -> Format.fprintf fmt "true"
  | SPrefixOf (atom, atom') ->
    Format.fprintf fmt "(str.prefixof %a %a)" pp_atom atom pp_atom atom'
  | SSuffixOf (atom, atom') ->
    Format.fprintf fmt "(str.suffixof %a %a)" pp_atom atom pp_atom atom'
  | SContains (atom, atom') ->
    Format.fprintf fmt "(str.contains %a %a)" pp_atom atom pp_atom atom'
  | SReg (atom, re) ->
    Format.fprintf
      fmt
      "(str.in.re %a %a)"
      pp_atom
      atom
      (Regex.pp (fun ppf bv ->
         Format.fprintf ppf "%a" (Format.pp_print_list Format.pp_print_char) bv))
      re (* TODO: print regex *)
  | SRegRaw (atom, re) -> Format.fprintf fmt "(str.in.re.raw %a)" pp_atom atom
  | SLen (atom, atom') ->
    Format.fprintf fmt "@[(chrob.len %a %a)@]" pp_atom atom pp_atom atom'
  | Stoi (atom, atom') ->
    Format.fprintf fmt "@[(= %a (chrob.to.int %a))@]" pp_atom atom pp_atom atom'
  | Itos (atom, atom') ->
    Format.fprintf fmt "@[(= %a (chrob.from.int %a))@]" pp_atom atom pp_atom atom'
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
  | Unsupp s -> Format.fprintf fmt "(unsupported %s)" s
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
    | ( SLen _ | Stoi _ | SReg _ | SRegRaw _
      | SPrefixOf (_, _)
      | SContains (_, _)
      | SSuffixOf (_, _)
      | Itos (_, _) ) as ir -> Format.fprintf ppf "%a" pp ir
    | Land [ x ] ->
      (* TODO: should be eliminated in simplifier *)
      helper ppf x
    | Land xs ->
      fprintf ppf "@[<v 2>@[(and@]@ ";
      List.iter (fprintf ppf "@[%a@]@ " helper) xs;
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
         | Neq -> "distinct"
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
    | Unsupp s -> fprintf ppf "@[(%s)@]" s
  in
  match ir with
  | Land xs ->
    fprintf ppf "@[<v>";
    List.iter (fprintf ppf "@[(assert %a)@]@," helper) xs;
    fprintf ppf "@]"
  | ir -> fprintf ppf "(assert %a)" helper ir
;;

type model = (atom, [ `Int of Z.t | `Str of string ]) Map.t

let pp_model_smtlib2 ppf m =
  let open Format in
  fprintf ppf "@[<hv 1>@[(@]";
  let i = ref 0 in
  (* Mutability only for pretty-printing *)
  Map.iteri m ~f:(fun ~key ~data ->
    if !i <> 0 then fprintf ppf "@ " else incr i;
    match key, data with
    | Var v, `Int z -> fprintf ppf "@[(define-fun %s () (_ Int) %a)@]" v Z.pp_print z
    | Var v, `Str s -> fprintf ppf "@[(define-fun %s () (_ String) \"%s\")@]" v s
    | Pow2 _, _ -> failwith "Unsupported. Exponenetials in the model");
  fprintf ppf ")@]"
;;

let model_to_str m = Format.asprintf "%a" pp_model_smtlib2 m

let exists vars = function
  | True -> True
  | ph ->
    assert (None = Base.List.find_a_dup ~compare:Stdlib.compare vars);
    Exists (vars, ph)
;;

let false_ = lnot true_

let of_bool = function
  | true -> True
  | false -> false_
;;

let neg term = Map.map ~f:Z.( ~- ) term
let _equal term1 term2 = Base.Map.equal Z.equal term1 term2

let is_zero_lhs (map : (atom, Z.t) Map.t) =
  match Map.length map with
  | 0 -> true
  | 1 -> Z.(snd (Map.min_elt_exn map) = zero)
  | _ -> false
;;

let eq = rel eq
let leq m rhs = if is_zero_lhs m then of_bool Z.(zero <= rhs) else rel leq m rhs
let neq m rhs = rel neq m rhs
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
  | SRegRaw (atom, regex), SRegRaw (atom', regex') -> atom = atom' && regex = regex'
  | SPrefixOf (atom, atom'), SPrefixOf (atom'', atom''')
  | SContains (atom, atom'), SContains (atom'', atom''')
  | SSuffixOf (atom, atom'), SSuffixOf (atom'', atom''')
  | SLen (atom, atom'), SLen (atom'', atom''')
  | Stoi (atom, atom'), Stoi (atom'', atom''')
  | Itos (atom, atom'), Itos (atom'', atom''') -> atom = atom'' && atom' = atom'''
  | _, _ -> false
;;

let rec map2 f fleaf ir =
  match ir with
  | True -> fleaf ir
  | Rel (_, _, _) -> fleaf ir
  | Reg (_, _) -> fleaf ir
  | SReg (_, _) -> fleaf ir
  | SRegRaw (_, _) -> fleaf ir
  | SLen (_, _) -> fleaf ir
  | Stoi (_, _) -> fleaf ir
  | Itos (_, _) -> fleaf ir
  | SPrefixOf (_, _) | SSuffixOf (_, _) | SContains (_, _) -> fleaf ir
  | Lnot ir' -> f (lnot (map2 f fleaf ir'))
  | Land irs -> f (land_ (List.map (map2 f fleaf) irs))
  | Lor irs -> f (lor_ (List.map (map2 f fleaf) irs))
  | Exists (atoms, ir') -> f (exists atoms (map2 f fleaf ir'))
  | Unsupp _ -> f ir
;;

let map f ir = map2 f f ir

let rec fold f acc ir =
  match ir with
  | True -> f acc ir
  | Rel _ -> f acc ir
  | Reg (_, _) -> f acc ir
  | SReg (_, _) -> f acc ir
  | SRegRaw (_, _) -> f acc ir
  | SLen (_, _) -> f acc ir
  | Stoi (_, _) -> f acc ir
  | Itos (_, _) -> f acc ir
  | SPrefixOf (_, _) | SContains (_, _) | SSuffixOf (_, _) -> f acc ir
  | Lnot ir' -> f (fold f acc ir') ir
  | Land irs -> f (List.fold_left (fold f) acc irs) ir
  | Lor irs -> f (List.fold_left (fold f) acc irs) ir
  | Exists (_, ir') -> f (fold f acc ir') ir
  | Unsupp _ -> f acc ir
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

let as_var = function
  | Pow2 v -> var v
  | Var v -> var v
;;

let get_exp = function
  | Pow2 v -> var v
  | Var _ -> failwith "Expected exponent, found var"
;;

let is_exp = function
  | Pow2 _ -> true
  | Var _ -> false
;;

let collect_vars ir =
  fold
    (fun acc -> function
       (*| Exists (atoms, _) -> Set.union acc (Set.of_list atoms)*)
       | Reg (_, atoms) -> Set.union acc (atoms |> List.map as_var |> Set.of_list)
       | SReg (atom, _) -> Set.add acc atom
       | SRegRaw (atom, _) -> Set.add acc atom
       | SLen (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Stoi (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Itos (atom, atom') -> Set.add (Set.add acc atom) atom'
       | SPrefixOf (atom, atom') -> Set.add (Set.add acc atom) atom'
       | SContains (atom, atom') -> Set.add (Set.add acc atom) atom'
       | SSuffixOf (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Rel (_, term, _) ->
         Set.union
           acc
           (Map.keys term
            |> List.concat_map (function
              | Var _ as ir -> [ ir ]
              | Pow2 a as ir -> [ ir; var a ])
            |> Set.of_list)
       | _ -> acc)
    Set.empty
    ir
  |> Set.to_list
  |> List.mapi (fun i var -> var, i)
  |> Map.of_alist_exn
;;

let collect_atoms ir =
  fold
    (fun acc -> function
       (*| Exists (atoms, _) -> Set.union acc (Set.of_list atoms)*)
       | Reg (_, atoms) -> Set.union acc (atoms |> Set.of_list)
       | SReg (atom, _) -> Set.add acc atom
       | SRegRaw (atom, _) -> Set.add acc atom
       | SLen (atom, atom')
       | Stoi (atom, atom')
       | SPrefixOf (atom, atom')
       | SContains (atom, atom')
       | SSuffixOf (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Rel (_, term, _) ->
         Set.union
           acc
           (Map.keys term
            |> List.concat_map (function
              | Var _ as ir -> [ ir ]
              | Pow2 _ as ir -> [ ir ])
            |> Set.of_list)
       | _ -> acc)
    Set.empty
    ir
;;

let collect_free_atoms ir =
  fold
    (fun acc -> function
       | Exists (atoms, _) -> Set.diff acc (Set.of_list atoms)
       | Reg (_, atoms) -> Set.union acc (atoms |> Set.of_list)
       | SReg (atom, _) -> Set.add acc atom
       | SRegRaw (atom, _) -> Set.add acc atom
       | SLen (atom, atom')
       | Stoi (atom, atom')
       | SPrefixOf (atom, atom')
       | SContains (atom, atom')
       | SSuffixOf (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Rel (_, term, _) ->
         Set.union
           acc
           (Map.keys term
            |> List.concat_map (function
              | Var _ as ir -> [ ir ]
              | Pow2 _ as ir -> [ ir ])
            |> Set.of_list)
       | _ -> acc)
    Set.empty
    ir
;;

let collect_free (ir : t) =
  fold
    (fun acc -> function
       | Rel (_, term, _) ->
         term |> Map.keys |> List.map as_var |> Set.of_list |> Set.union acc
       | SReg (atom, _) -> Set.add acc atom
       | SRegRaw (atom, _) -> Set.add acc atom
       | SLen (atom, atom')
       | Stoi (atom, atom')
       | Itos (atom, atom')
       | SPrefixOf (atom, atom')
       | SContains (atom, atom')
       | SSuffixOf (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Reg (_, atoms) -> Set.union acc (atoms |> Set.of_list)
       | Exists (xs, ir) -> Set.diff acc (Set.of_list xs)
       | _ -> acc)
    Set.empty
    ir
;;

let antiprenex =
  fun ir ->
  map
    (function
      | Exists ([], ir) -> ir
      | Exists (atoms, Exists (atoms', ir)) ->
        exists (Base.List.dedup_and_sort ~compare (atoms @ atoms')) ir
      | Exists ((a :: b :: tl as atoms), Land irs) as orig_ir ->
        let atoms =
          (*List.filter
              (fun atom ->
                 not
                   (for_some
                      (function
                        | SReg (atom', _)
                        | SLen (atom', _)
                        | Stoi (atom', _)
                        | SEq (atom', _)
                          when atom = atom' -> true
                        | _ -> false)
                      ir))*)
          atoms
        in
        let atoms_set = Set.of_list atoms in
        if atoms_set |> Set.is_empty
        then orig_ir
        else (
          let irs_using_var =
            List.mapi
              begin fun i ir ->
                let free_vars = collect_free ir in
                let used_vars = Set.inter atoms_set free_vars in
                i, used_vars
              end
              irs
          in
          let var_is_used_in =
            List.map
              begin fun atom ->
                ( atom
                , List.filter_map
                    (fun (i, s) -> if Set.mem s atom then Some i else None)
                    irs_using_var )
              end
              atoms
            |> Map.of_alist_exn
          in
          let atom_to_move, used_in =
            var_is_used_in
            |> Map.to_alist
            |> List.sort (fun (_, used_in) (_, used_in') ->
              List.length used_in - List.length used_in')
            |> List.hd
          in
          if List.length irs = List.length used_in
          then orig_ir
          else (
            let atoms = List.filter (fun atom -> atom <> atom_to_move) atoms in
            let irs_used, irs_free =
              irs
              |> List.mapi (fun i ir -> i, ir)
              |> List.partition (fun (i, ir) -> List.mem i used_in)
            in
            let irs_used = List.map snd irs_used in
            let irs_free = List.map snd irs_free in
            let ir = land_ (exists [ atom_to_move ] (land_ irs_used) :: irs_free) in
            if atoms <> [] then exists atoms ir else ir))
      | Exists (atoms, Lor irs) -> lor_ (List.map (exists atoms) irs)
      | ir -> ir)
    ir
;;

(* let simpl1 ir = 
  let simp_equalities = function 
  | Rel (Eq, term, c) when Map.for_all ~f:(fun v -> Z.(equal v zero)) term && c = Z.zero *)
let simpl ir =
  ir
  |> map (function
    | Rel (Eq, term, c) when Map.for_all ~f:(fun v -> Z.(equal v zero)) term && c = Z.zero
      -> true_
    | Rel (Leq, term, c) when Map.length term = 0 && Z.(c >= zero) -> true_
    | Rel (Leq, term, c) when Map.length term = 0 && Z.(c < zero) -> false_
    | Rel (Eq, term, c) when Map.length term = 1 ->
      let _, coeff = Map.min_elt_exn term in
      (match Z.(coeff = zero) with
       | true -> if Z.(c <> zero) then false_ else true_
       | false -> if Z.(c mod coeff <> zero) then false_ else Rel (Eq, term, c))
    | Rel (Eq, term, c) ->
      let gcd_ = List.fold_left Z.gcd Z.zero (Map.data term) in
      if Z.(c mod gcd_ = zero)
      then (
        let term' = Map.map ~f:(fun coeff -> Z.(coeff / gcd_)) term in
        Rel (Eq, term', Z.(c / gcd_)))
      else false_
    | ir -> ir)
  |> map (function
    | Lor [] -> false_
    | Land [] -> true_
    | Land [ ir ] -> ir
    | Lor [ ir ] -> ir
    | Land irs
      when List.exists
             (function
               | Lnot True -> true
               | _ -> false)
             irs -> Lnot True
    | Land irs ->
      land_
        (List.filter_map
           (function
             | True -> None
             | ir' -> Some ir')
           irs)
    | Lor irs
      when List.exists
             (function
               | True -> true
               | _ -> false)
             irs -> True
    | Lor irs ->
      lor_
        (List.filter_map
           (function
             | Lnot True -> None
             | ir' -> Some ir')
           irs)
    | ir -> ir)
  |> map (function
    | Land lst ->
      Land
        (lst
         |> List.concat_map (function
           | Land lst -> lst
           | ir -> [ ir ]))
    | Lor lst ->
      Lor
        (lst
         |> List.concat_map (function
           | Lor lst -> lst
           | ir -> [ ir ]))
    | ir -> ir)
;;

let simpl_ineq ir =
  let simpl_ineq ir =
    let merge lowb uppb =
      let merge_bounds f = function
        | Some x, Some y -> Some (f x y)
        | None, Some y -> Some y
        | Some x, None -> Some x
        | None, None -> None
      in
      let (lowb1, uppb1), (lowb2, uppb2) = lowb, uppb in
      merge_bounds max (lowb1, lowb2), merge_bounds min (uppb1, uppb2)
    in
    let bounds =
      fold
        (fun list -> function
           | Rel (Eq, term, c) when Map.length term = 1 ->
             let var, coeff = Map.min_elt_exn term in
             let value = Z.(c / coeff) in
             (var, (Some value, Some value)) :: list
           | Rel (Leq, term, c) when Map.length term = 1 ->
             let var, coeff = Map.min_elt_exn term in
             let value = Z.(c / coeff) in
             if Z.(coeff > zero)
             then (var, (None, Some value)) :: list
             else (var, (Some value, None)) :: list
           | _ -> list)
        []
        ir
    in
    let bounds_map =
      bounds
      |> Map.of_alist_multi
      |> Map.map ~f:(fun data -> List.fold_left merge (None, None) data)
    in
    let ir_without_eq_n_leq =
      map
        (function
          | Rel (Eq, term, c) when Map.length term = 1 -> true_
          | Rel (Leq, term, c) when Map.length term = 1 -> true_
          | ir -> ir)
        ir
    in
    let irs =
      Map.fold
        ~init:[]
        ~f:(fun ~key:var ~data:(lowb, uppb) irs ->
          match lowb, uppb with
          | Some x, Some y ->
            if x < y
            then
              leq (Map.singleton var Z.minus_one) Z.(-x)
              :: leq (Map.singleton var Z.one) y
              :: irs
            else if x = y
            then eq (Map.singleton var Z.one) y :: irs
            else false_ :: irs
          | Some x, None -> leq (Map.singleton var Z.minus_one) Z.(-x) :: irs
          | None, Some y -> leq (Map.singleton var Z.one) y :: irs
          | None, None -> irs)
        bounds_map
    in
    let complex_bounds_map =
      let complex_bounds =
        fold
          (fun list -> function
             | Rel (Leq, term, value) -> (term, value) :: list
             | _ -> list)
          []
          ir_without_eq_n_leq
      in
      complex_bounds
      |> Map.of_alist_multi
      |> Map.map ~f:(function
        | hd :: tl -> List.fold_left Z.min hd tl
        | [] -> assert false)
    in
    let ir_without_leq =
      map
        (function
          | Rel (Leq, term, c) -> true_
          | ir -> ir)
        ir_without_eq_n_leq
    in
    let irs' =
      let decide term c =
        match Map.find complex_bounds_map (neg term) with
        | None -> leq term c
        | Some c' ->
          if Z.(c = -c') then if Z.(c >= zero) then eq term c else true_ else leq term c
      in
      Map.fold
        ~init:[]
        ~f:(fun ~key ~data irs -> decide key data :: irs)
        complex_bounds_map
    in
    let ir = land_ (List.concat [ irs'; ir_without_leq :: irs ]) |> simpl in
    ir
  in
  map
    (function
      | Exists (v, ir) -> exists v (simpl_ineq ir)
      | Lnot ir' -> lnot (simpl_ineq ir')
      | ir -> ir)
    ir
  |> simpl_ineq
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

let shrink_strings ir =
  (* Format.eprintf "%s: @[%a@]\n%!" __FUNCTION__ pp ir; *)
  let module SS = Stdlib.Map.Make (String) in
  let string_vars =
    fold
      (fun acc -> function
         | SLen (Var vlen, Var vs) -> SS.add vs (Var vlen) acc
         | _ -> acc)
      SS.empty
      ir
  in
  SS.fold
    (fun _key term acc -> Rel (Leq, Map.singleton term (Z.of_int 1), Z.of_int 10) :: acc)
    string_vars
    []
  |> land_
;;
