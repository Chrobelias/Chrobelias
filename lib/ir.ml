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
  | Pow2 name -> Format.asprintf "%a" Z.pp_print (Z.of_int !Config.base) ^ name
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
  (* [Div m] is the congruence [poly = c (mod m)]. It is kept as a relation of
     its own rather than lowered to [exists q. poly - m*q = c] because
     [NfaCollection.mod_eq] builds a small automaton for it directly, whereas
     the lowering would add an unbounded track plus a projection. *)
  | Div of Z.t
[@@deriving variants]

let pp_rel fmt = function
  | Leq -> Format.fprintf fmt "<="
  | Eq -> Format.fprintf fmt "="
  | Neq -> Format.fprintf fmt "distinct"
  | Div m -> Format.fprintf fmt "=(mod %a)" Z.pp_print m
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

type t =
  | True
  | Reg of bool list Regex.t * atom list
  | SReg of atom * char list Regex.t
  | SRegRaw of atom * Nfa.String.t
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
         | Eq -> "="
         | Div m -> Format.asprintf "=(mod %a)" Z.pp_print m)
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

let collect_model_vars ir =
  ir
  |> collect_vars
  |> Map.filter_keys ~f:(fun x -> not (Base.String.is_prefix (name x) ~prefix:"%"))
  |> Map.filter_keys ~f:(fun x -> not (Base.String.is_prefix (name x) ~prefix:"2"))
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
  if Config.config.antiprenex_mode = `Disable
  then ir
  else
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
            let irs_using_var : (int * atom Set.t) list =
              List.mapi
                begin fun i ir ->
                  let free_vars = collect_free ir in
                  let used_vars = Set.inter atoms_set free_vars in
                  i, used_vars
                end
                irs
            in
            let var_is_used_in : (atom, int list) Map.t =
              List.map
                begin fun atom ->
                  ( atom
                  , List.filter_map
                      (fun (i, s) ->
                         if
                           Set.mem s atom
                           || (Config.config.antiprenex_mode = `Push_re
                               && List.nth irs i
                                  |> function
                                  | SRegRaw _ -> true
                                  | _ -> false)
                         then Some i
                         else None)
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

(* [exists q. m*q + poly = c] is the congruence [poly = c (mod |m|)]: it is
   solvable in an integer [q] exactly when [|m|] divides [c - poly]. In LSB
   mode variables range over the naturals (after [Ast.to_nat]), so [q >= 0]
   additionally bounds the reach of [m*q]: the equation then also forces
   [poly <= c] when [m > 0] (resp. [poly >= c] when [m < 0]).

   The rewrite runs after [antiprenex] has shrunk every quantifier to its
   minimal scope, so divisibility arising from any frontend shape is caught
   uniformly, and each catch replaces an unbounded quantified track plus a
   projection with the small direct automaton behind [Div]
   ([NfaCollection.mod_eq]).

   Only *bound* variables are folded. A free variable -- even an internal
   quotient the lowerings mint -- may be referenced by the accumulated
   environment when reconstructing a model (e.g. after equality propagation
   eliminated a user variable through it), and folding would delete the
   automaton track its value is read from. *)
let exists_to_div =
  let is_nat () = Config.config.mode = `Lsb in
  (* [Some conjs'] when [q] occurs linearly in exactly one conjunct, an
     equation, which is then replaced by the congruence; [None] otherwise. *)
  let fold_var q conjs =
    match q with
    | Pow2 _ -> None
    | Var qname ->
      let used, rest = List.partition (fun ir -> Set.mem (collect_free ir) q) conjs in
      (match used with
       | [] -> (* A vacuous binder: the integers are non-empty. *) Some rest
       | [ Rel (Eq, poly, c) ]
         when Map.mem poly q
              && (not (Map.mem poly (Pow2 qname)))
              && not (Z.equal (Map.find_exn poly q) Z.zero) ->
         let m = Map.find_exn poly q in
         let poly = Map.remove poly q in
         if Map.is_empty poly
         then (
           (* [exists q. m*q = c]. Over the naturals the quotient must also
              be non-negative, i.e. [c] and [m] must agree in sign. *)
           let feasible =
             Z.divisible c m && ((not (is_nat ())) || Z.sign c * Z.sign m >= 0)
           in
           Some (of_bool feasible :: rest))
         else (
           let congr =
             (* An invertible coefficient is always solvable. *)
             if Z.(equal (abs m) one) then [] else [ rel (Div (Z.abs m)) poly c ]
           in
           let bound =
             if is_nat ()
             then
               if Z.(gt m zero)
               then [ leq poly c ]
               else [ leq (Map.map poly ~f:Z.neg) (Z.neg c) ]
             else []
           in
           match congr @ bound with
           | [] -> Some (true_ :: rest)
           | irs -> Some (irs @ rest))
       | _ -> None)
  in
  let fold_atoms atoms conjs =
    List.fold_left
      (fun (atoms, conjs) q ->
         match fold_var q conjs with
         | Some conjs -> atoms, conjs
         | None -> q :: atoms, conjs)
      ([], conjs)
      atoms
  in
  let conjuncts_of = function
    | Land irs -> irs
    | ir -> [ ir ]
  in
  fun ir ->
    if Config.config.mod_eq = false
    then ir
    else
      map
        (function
          | Exists (atoms, body) ->
            let atoms, conjs = fold_atoms atoms (conjuncts_of body) in
            (match List.rev atoms with
             | [] -> land_ conjs
             | atoms -> exists atoms (land_ conjs))
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
  (* Bounds are collected and re-emitted conjoined, so both the collection and
     the erasure below must stay on the top-level conjunctive spine: merging an
     upper bound with [min] across the arms of a [Lor] (or from under a [Lnot])
     would strengthen the formula -- e.g. [x <= 0 /\ (x = 1 \/ x = 0)] used to
     collapse to false by combining [x = 1] from one arm with the rest. The
     arms themselves are simplified recursively by the wrapper at the bottom. *)
  let fold_conj f init ir =
    let rec go acc = function
      | Land irs -> List.fold_left go acc irs
      | ir -> f acc ir
    in
    go init ir
  in
  let map_conj f ir =
    let rec go = function
      | Land irs -> land_ (List.map go irs)
      | ir -> f ir
    in
    go ir
  in
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
      fold_conj
        (fun list -> function
           | Rel (Eq, term, c) when Map.length term = 1 ->
             let var, coeff = Map.min_elt_exn term in
             let value = Z.(c / coeff) in
             (var, (Some value, Some value)) :: list
           | Rel (Leq, term, c) when Map.length term = 1 ->
             let var, coeff = Map.min_elt_exn term in
             let q, r = Utils.div_rem c coeff in
             (* let value = if Z.(coeff < zero) then Z.(q + one) else q in *)
             if Z.(coeff > zero)
             then (var, (None, Some q)) :: list
             else (var, (Some q, None)) :: list
           | _ -> list)
        []
        ir
    in
    (* Values a variable is forbidden to take, from single-variable disequalities.
       [c * v <> rhs] forbids [rhs / c], and is vacuously true over the integers
       when [c] does not divide [rhs] -- so those are simply not recorded, and get
       erased below along with the rest. *)
    let forbidden =
      fold_conj
        (fun list -> function
           | Rel (Neq, term, c) when Map.length term = 1 ->
             let var, coeff = Map.min_elt_exn term in
             if Z.divisible c coeff then (var, Z.divexact c coeff) :: list else list
           | _ -> list)
        []
        ir
      |> Map.of_alist_multi
      |> Map.map ~f:(List.sort_uniq Z.compare)
    in
    let forbids var x =
      match Map.find forbidden var with
      | None -> false
      | Some xs -> List.exists (Z.equal x) xs
    in
    (* [v >= c] together with [v <> c] gives [v >= c + 1], and symmetrically for an
       upper bound. Each step consumes one forbidden value, so this terminates. *)
    let tighten var (lowb, uppb) =
      let rec raise_ x = if forbids var x then raise_ Z.(x + one) else x in
      let rec lower x = if forbids var x then lower Z.(x - one) else x in
      Option.map raise_ lowb, Option.map lower uppb
    in
    let bounds_map =
      bounds
      |> Map.of_alist_multi
      |> Map.map ~f:(fun data -> List.fold_left merge (None, None) data)
      |> Map.mapi ~f:(fun ~key ~data -> tighten key data)
    in
    (* A forbidden value outside the tightened range is already ruled out by the
       bounds, so its disequality has been discharged and need not be re-emitted. *)
    let neq_irs =
      Map.fold forbidden ~init:[] ~f:(fun ~key:var ~data:values irs ->
        let lowb, uppb = Map.find bounds_map var |> Option.value ~default:(None, None) in
        let within x =
          Option.fold ~none:true ~some:(fun l -> Z.geq x l) lowb
          && Option.fold ~none:true ~some:(fun u -> Z.leq x u) uppb
        in
        List.fold_left
          (fun irs x -> if within x then neq (Map.singleton var Z.one) x :: irs else irs)
          irs
          values)
    in
    let ir_without_eq_n_leq =
      map_conj
        (function
          | Rel (Eq, term, c) when Map.length term = 1 -> true_
          | Rel (Leq, term, c) when Map.length term = 1 -> true_
          (* Re-emitted by [neq_irs] above, minus the discharged and vacuous ones. *)
          | Rel (Neq, term, c) when Map.length term = 1 -> true_
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
        fold_conj
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
      map_conj
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
    let ir = land_ (List.concat [ irs'; neq_irs; ir_without_leq :: irs ]) |> simpl in
    ir
  in
  (* Single top-down visit: walk the conjunctive spine and give each
     disjunct/binder body its own recursive treatment, then run the
     bound-merging pass on the spine. Recursing through [map] instead (which
     visits every node) re-ran the whole pass once per [Lor] node per level
     -- exponential on the disjunction-heavy IRs the string suites produce. *)
  let rec top ir =
    let rec descend = function
      | Land irs -> land_ (List.map descend irs)
      | Lor irs -> lor_ (List.map top irs)
      | Lnot ir' -> lnot (top ir')
      | Exists (v, ir') -> exists v (top ir')
      | ir -> ir
    in
    simpl_ineq (descend ir)
  in
  top ir
;;

let%expect_test _ =
  (* 3v <= 3 ~> v <= 1 *)
  let v = leq (Map.singleton (var "t") Z.(of_int 3)) (Z.of_int 3) in
  Format.printf "@[%a@] " pp_smtlib2 v;
  Format.printf "@[%a@]\n%!" pp_smtlib2 (simpl_ineq v);
  (* 3v <= 4 ~> v <= 1 *)
  let v = leq (Map.singleton (var "t") Z.(of_int 3)) (Z.of_int 4) in
  Format.printf "@[%a@] " pp_smtlib2 v;
  Format.printf "@[%a@]\n%!" pp_smtlib2 (simpl_ineq v);
  (* 3v <= 2 ~> v <= 0 *)
  let v = leq (Map.singleton (var "t") Z.(of_int 3)) (Z.of_int 2) in
  Format.printf "@[%a@] " pp_smtlib2 v;
  Format.printf "@[%a@]\n%!" pp_smtlib2 (simpl_ineq v);
  (* 500v <= 0 ~> v <= 0 *)
  let v = leq (Map.singleton (var "t") Z.(of_int 500)) (Z.of_int 0) in
  Format.printf "@[%a@] " pp_smtlib2 v;
  Format.printf "@[%a@]\n%!" pp_smtlib2 (simpl_ineq v);
  (* 3v <= -2 ~> v <= -1 *)
  let v = leq (Map.singleton (var "t") Z.(of_int 3)) (Z.of_int (-2)) in
  Format.printf "@[%a@] " pp_smtlib2 v;
  Format.printf "@[%a@]\n%!" pp_smtlib2 (simpl_ineq v);
  (* 3v <= -4 ~> v <= -2 *)
  let v = leq (Map.singleton (var "t") Z.(of_int 3)) (Z.of_int (-4)) in
  Format.printf "@[%a@] " pp_smtlib2 v;
  Format.printf "@[%a@]\n%!" pp_smtlib2 (simpl_ineq v);
  (* 3v <= -3 ~> v <= -1 *)
  let v = leq (Map.singleton (var "t") Z.(of_int 3)) (Z.of_int (-3)) in
  Format.printf "@[%a@] " pp_smtlib2 v;
  Format.printf "@[%a@]\n%!" pp_smtlib2 (simpl_ineq v);
  (* -7v <= -8 ~> -v <= -2 *)
  let v = leq (Map.singleton (var "t") Z.(of_int (-7))) (Z.of_int (-8)) in
  Format.printf "@[%a@] " pp_smtlib2 v;
  Format.printf "@[%a@]\n%!" pp_smtlib2 (simpl_ineq v);
  (* -7v <= -7 ~> -v <= -1 *)
  let v = leq (Map.singleton (var "t") Z.(of_int (-7))) (Z.of_int (-7)) in
  Format.printf "@[%a@] " pp_smtlib2 v;
  Format.printf "@[%a@]\n%!" pp_smtlib2 (simpl_ineq v);
  (* -7v <= -6 ~> -v <= -1 *)
  let v = leq (Map.singleton (var "t") Z.(of_int (-7))) (Z.of_int (-6)) in
  Format.printf "@[%a@] " pp_smtlib2 v;
  Format.printf "@[%a@]\n%!" pp_smtlib2 (simpl_ineq v);
  (* -7v <= 8 ~> -v <= 1 *)
  let v = leq (Map.singleton (var "t") Z.(of_int (-7))) (Z.of_int 8) in
  Format.printf "@[%a@] " pp_smtlib2 v;
  Format.printf "@[%a@]\n%!" pp_smtlib2 (simpl_ineq v);
  (* -7v <= 6 ~> -v <= 0 *)
  let v = leq (Map.singleton (var "t") Z.(of_int (-7))) (Z.of_int 6) in
  Format.printf "@[%a@] " pp_smtlib2 v;
  Format.printf "@[%a@]\n%!" pp_smtlib2 (simpl_ineq v);
  (* -7v <= 7 ~> -v <= 1 *)
  let v = leq (Map.singleton (var "t") Z.(of_int (-7))) (Z.of_int 7) in
  Format.printf "@[%a@] " pp_smtlib2 v;
  Format.printf "@[%a@]\n%!" pp_smtlib2 (simpl_ineq v);
  (* -31v <= -35 ~> -v <= -2 *)
  let v = leq (Map.singleton (var "t") Z.(of_int (-31))) (Z.of_int (-35)) in
  Format.printf "@[%a@] " pp_smtlib2 v;
  Format.printf "@[%a@]\n%!" pp_smtlib2 (simpl_ineq v);
  [%expect
    {|
    (assert (<= (* 3 t)  3) ) (assert (<= t  1) )
    (assert (<= (* 3 t)  4) ) (assert (<= t  1) )
    (assert (<= (* 3 t)  2) ) (assert (<= t  0) )
    (assert (<= (* 500 t)  0) ) (assert (<= t  0) )
    (assert (<= (* 3 t)  -2) ) (assert (<= t  -1) )
    (assert (<= (* 3 t)  -4) ) (assert (<= t  -2) )
    (assert (<= (* 3 t)  -3) ) (assert (<= t  -1) )
    (assert (<= (* (- 7) t)  -8) ) (assert (<= (* (- 1) t)  -2) )
    (assert (<= (* (- 7) t)  -7) ) (assert (<= (* (- 1) t)  -1) )
    (assert (<= (* (- 7) t)  -6) ) (assert (<= (* (- 1) t)  -1) )
    (assert (<= (* (- 7) t)  8) ) (assert (<= (* (- 1) t)  1) )
    (assert (<= (* (- 7) t)  6) ) (assert (<= (* (- 1) t)  0) )
    (assert (<= (* (- 7) t)  7) ) (assert (<= (* (- 1) t)  1) )
    (assert (<= (* (- 31) t)  -35) ) (assert (<= (* (- 1) t)  -2) )
    |}]
;;

(* Eliminate variables whose only occurrences are bounds on themselves.

   Nothing else constrains such a variable, so it can be fixed to any value its own
   bounds admit: the bounds are dropped and the chosen value is returned for the
   caller to record in its environment, which keeps the model complete. That takes
   the variable out of the formula and with it a track from the automaton the solver
   builds.

   [simpl_monotonicty] below does this for *quantified* variables, pinning a
   monotone one to its bound, but it only fires on [Exists] and the pipeline hands it
   quantifier-free formulas -- so free variables never got the treatment.

   What disqualifies a variable:

   - an occurrence anywhere other than a single-variable bound on itself.
     Occurrences are looked for in *every* leaf, not just [Rel]: a variable also
     lives in [SLen], [SRegRaw], [Stoi] and friends, and treating one of those as
     absent would drop a bound that is doing real work. [Var v] and [Pow2 v] denote
     the same variable, so they count together.

   - an occurrence in a negative position, or under a quantifier. Below a [Lnot] a
     bound is a genuine constraint rather than something to be satisfied at will.

   - a [Neq] bound, whose feasible set is not an interval, or a zero coefficient.

   - bounds with no value between them, e.g. [x >= 5] together with [x <= 2]. That
     is a genuine contradiction; it is left in place for [simpl_ineq], which already
     reduces it to [false]. *)
let pin_unconstrained_vars ir =
  let var_of = function
    | Var v | Pow2 v -> v
  in
  let atoms_of = function
    | Rel (_, poly, _) -> Map.keys poly
    | Reg (_, atoms) -> atoms
    | SReg (a, _) | SRegRaw (a, _) -> [ a ]
    | SPrefixOf (a, b)
    | SSuffixOf (a, b)
    | SContains (a, b)
    | SLen (a, b)
    | Stoi (a, b)
    | Itos (a, b) -> [ a; b ]
    | True | Unsupp _ | Lnot _ | Land _ | Lor _ | Exists _ -> []
  in
  (* A bound on a single variable, which is the only shape we can eliminate.

     [Pow2 v] is deliberately rejected: it bounds the *power*, not [v], so the
     interval arithmetic below would be reasoning about the wrong quantity. Since
     occurrences are keyed on the bare name, such a bound still counts against [v]
     and disqualifies it, which is what we want. *)
  let self_bound = function
    | Rel (((Leq | Eq) as rel), poly, rhs) when Map.length poly = 1 ->
      (match Map.min_elt_exn poly with
       | Var v, coeff when not (Z.equal coeff Z.zero) -> Some (v, rel, coeff, rhs)
       | _ -> None)
    | _ -> None
  in
  let bump tbl v =
    tbl
    := Map.update !tbl v ~f:(function
         | None -> 1
         | Some n -> n + 1)
  in
  (* Count every occurrence, and separately those that are eliminable bounds. A
     variable is a candidate exactly when the two counts agree. *)
  let occurrences = ref Map.empty
  and as_bound = ref Map.empty
  and collected = ref [] in
  let rec scan positive ir =
    match ir with
    | Land irs | Lor irs -> List.iter (scan positive) irs
    | Lnot ir -> scan false ir
    | Exists (_, ir) -> scan false ir
    | leaf ->
      List.iter (fun atom -> bump occurrences (var_of atom)) (atoms_of leaf);
      (match self_bound leaf with
       | Some ((v, _, _, _) as bound) when positive ->
         bump as_bound v;
         collected := bound :: !collected
       | _ -> ())
  in
  scan true ir;
  let candidates =
    Map.filteri !as_bound ~f:(fun ~key ~data -> Map.find !occurrences key = Some data)
    |> Map.keys
  in
  (* Narrow each candidate's bounds to an interval, then take any value inside it. *)
  let tighter pick a b =
    match a, b with
    | None, x | x, None -> x
    | Some a, Some b -> Some (pick a b)
  in
  let value_for v =
    List.filter (fun (v', _, _, _) -> String.equal v v') !collected
    |> List.fold_left
         (fun acc (_, rel, coeff, rhs) ->
            match acc with
            | None -> None
            | Some (lo, hi) ->
              (match rel with
               (* [coeff * v <= rhs] bounds [v] above when [coeff > 0], below when
                  [coeff < 0]; the division rounds towards the feasible side. *)
               | Leq when Z.(coeff > zero) ->
                 Some (lo, tighter Z.min hi (Some (Z.fdiv rhs coeff)))
               | Leq -> Some (tighter Z.max lo (Some (Z.cdiv rhs coeff)), hi)
               | Eq ->
                 if Z.divisible rhs coeff
                 then (
                   let x = Z.divexact rhs coeff in
                   Some (tighter Z.max lo (Some x), tighter Z.min hi (Some x)))
                 else None
               (* Unreachable: [self_bound] only ever collects [Leq] and [Eq].
                  A variable under either of these still counts as an
                  occurrence without counting as a bound, so it never becomes a
                  candidate in the first place. *)
               | Neq | Div _ -> None))
         (Some (None, None))
    |> function
    | None -> None
    | Some (Some lo, Some hi) when Z.gt lo hi -> None
    (* Prefer [0] whenever the bounds admit it: that is the value model
       reconstruction used to supply for a variable the solver never assigned, so
       keeping it leaves existing models untouched. Only move off [0] when it is
       genuinely infeasible. *)
    | Some (lo, hi)
      when (match lo with
            | Some lo -> Z.leq lo Z.zero
            | None -> true)
           &&
             match hi with
             | Some hi -> Z.geq hi Z.zero
             | None -> true -> Some Z.zero
    | Some (Some lo, _) -> Some lo
    | Some (None, Some hi) -> Some hi
    | Some (None, None) -> Some Z.zero
  in
  let pinned =
    List.fold_left
      (fun acc v ->
         match value_for v with
         | Some x -> Map.set acc ~key:v ~data:x
         | None -> acc)
      Map.empty
      candidates
  in
  if Map.is_empty pinned
  then ir, []
  else (
    let eliminated leaf =
      match self_bound leaf with
      | Some (v, _, _, _) -> Map.mem pinned v
      | None -> false
    in
    (* [land_]/[lor_] keep [True]/[Lnot True] children and nothing re-runs [simpl]
       after this pass, so drop them here rather than leave them for the solver. *)
    let rec go positive ir =
      match ir with
      | Land irs ->
        land_ (List.map (go positive) irs |> List.filter (fun ir -> ir <> True))
      | Lor irs ->
        lor_ (List.map (go positive) irs |> List.filter (fun ir -> ir <> Lnot True))
      | leaf when positive && eliminated leaf -> true_
      | ir -> ir
    in
    go true ir, Map.to_alist pinned)
;;

let%expect_test "simpl_ineq and disequalities" =
  let show ir = Format.printf "@[%a@]\n%!" pp_smtlib2 (simpl_ineq ir) in
  let ge v n = leq (Map.singleton (var v) Z.minus_one) Z.(neg (of_int n)) in
  let le v n = leq (Map.singleton (var v) Z.one) (Z.of_int n) in
  let ne v n = neq (Map.singleton (var v) Z.one) (Z.of_int n) in
  (* [v >= 1] and [v <> 1] tighten to [v >= 2]; the disequality is discharged. *)
  show (land_ [ ge "v" 1; ne "v" 1 ]);
  [%expect "(assert (<= (* (- 1) v)  -2) )"];
  (* Consecutive excluded values keep tightening. *)
  show (land_ [ ge "v" 1; ne "v" 1; ne "v" 2 ]);
  [%expect "(assert (<= (* (- 1) v)  -3) )"];
  (* Symmetrically for an upper bound. *)
  show (land_ [ le "v" 5; ne "v" 5 ]);
  [%expect "(assert (<= v  4) )"];
  (* A forbidden value strictly inside the range has to stay. *)
  show (land_ [ ge "v" 0; le "v" 10; ne "v" 5 ]);
  [%expect
    " \n\
    \ (assert (distinct v  5) )\n\
    \ (assert (<= (* (- 1) v)  0) )\n\
    \ (assert (<= v  10) )\n\
    \ "];
  (* Already outside the range: discharged without changing the bound. *)
  show (land_ [ ge "v" 0; le "v" 3; ne "v" 9 ]);
  [%expect " \n (assert (<= (* (- 1) v)  0) )\n (assert (<= v  3) )\n "];
  (* [3v <> 7] holds for every integer [v], so it carries no information. *)
  show (neq (Map.singleton (var "v") (Z.of_int 3)) (Z.of_int 7));
  [%expect "(assert T)"];
  (* [3v <> 6] does forbid [v = 2]. *)
  show (land_ [ ge "v" 2; neq (Map.singleton (var "v") (Z.of_int 3)) (Z.of_int 6) ]);
  [%expect "(assert (<= (* (- 1) v)  -3) )"];
  (* No bounds at all: the disequality survives unchanged. *)
  show (ne "v" 3);
  [%expect "(assert (distinct v  3) )"];
  ()
;;

let%expect_test "pin_unconstrained_vars" =
  let show ir =
    let ir, pinned = pin_unconstrained_vars ir in
    Format.printf
      "@[%a@]  pinned: [%a]\n%!"
      pp_smtlib2
      ir
      (Format.pp_print_list
         ~pp_sep:(fun ppf () -> Format.fprintf ppf "; ")
         (fun ppf (v, x) -> Format.fprintf ppf "%s=%a" v Z.pp_print x))
      pinned
  in
  let ge v n = leq (Map.singleton (var v) Z.minus_one) Z.(neg (of_int n)) in
  let le v n = leq (Map.singleton (var v) Z.one) (Z.of_int n) in
  (* [x >= 0] alone: eliminated, value recorded. *)
  show (ge "x" 0);
  [%expect "(assert T)  pinned: [x=0]"];
  (* [x >= 5] alone: also eliminated now, pinned to 5. *)
  show (ge "x" 5);
  [%expect "(assert T)  pinned: [x=5]"];
  (* Both bounds and nothing else: still eliminable, pinned inside the interval. *)
  show (land_ [ ge "x" 3; le "x" 9 ]);
  [%expect "(assert T)  pinned: [x=3]"];
  (* Upper bound only. *)
  show (le "x" (-4));
  [%expect "(assert T)  pinned: [x=-4]"];
  (* Empty interval is a real contradiction: left for [simpl_ineq]. *)
  show (land_ [ ge "x" 5; le "x" 2 ]);
  [%expect " \n (assert (<= (* (- 1) x)  -5) )\n (assert (<= x  2) )\n   pinned: []\n "];
  (* Used by a non-bound constraint, so the bound stays. *)
  show (land_ [ ge "x" 0; sregraw (var "x") (Nfa.String.of_regex Regex.epsilon) ]);
  [%expect
    " \n (assert (<= (* (- 1) x)  0) )\n (assert (str.in.re.raw x))\n   pinned: []\n "];
  (* [Pow2 x] is the same variable as [Var x]. *)
  show (land_ [ ge "x" 0; le "y" 1; leq (Map.singleton (pow2 "x") Z.one) Z.one ]);
  [%expect
    " \n (assert (<= (* (- 1) x)  0) )\n (assert (<= pow2(x)  1) )\n   pinned: [y=0]\n "];
  (* Under a negation a bound is a genuine constraint. *)
  show (lnot (ge "x" 0));
  [%expect "(assert (not (<= (* (- 1) x)  0) ))  pinned: []"];
  (* An exact bound pins the only feasible value. *)
  show (eq (Map.singleton (var "x") (Z.of_int 3)) (Z.of_int 12));
  [%expect "(assert T)  pinned: [x=4]"];
  (* Not divisible: infeasible, so left alone. *)
  show (eq (Map.singleton (var "x") (Z.of_int 3)) (Z.of_int 7));
  [%expect "(assert (= (* 3 x)  7) )  pinned: []"];
  ()
;;

(** Habermehl's 2024 monotonicity simplification  *)
let simpl_monotonicty e ir =
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
  let ir, pinned =
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
          | false, _ | _, [] -> Exists (List.map var ovars @ other_atoms, Land rhs), []
          | true, ovars ->
            log
              "After stage %d there %d variables: %s"
              stage
              (List.length ovars)
              (String.concat " " ovars);
            fixpoint (Int.add stage 1) ovars [] rhs)
      in
      fixpoint 0 vars [] rhs
    (* Quantifier-free input, which is what the pipeline actually produces: the
     elimination above needs an [Exists] to work on, but free variables can still be
     pinned and their bounds dropped. *)
    | ir -> pin_unconstrained_vars ir
  in
  ( List.fold_left
      (fun e (v, value) ->
         if Env.is_absent_key v e then Env.extend_int_exn e v (Ast.Eia.const value) else e)
      e
      pinned
  , ir )
;;

let get_partial_model ir =
  fold
    (fun list -> function
       | Rel (Eq, term, c) when Map.length term = 1 ->
         let var, coeff = Map.min_elt_exn term in
         let value = Z.(c / coeff) in
         (var, value) :: list
       | _ -> list)
    []
    ir
;;
