type sup_binop =
  | Bwand
  | Bwor
  | Bwxor

module type str_term = sig
  type term
  type str

  (** String terms *)

  val iofs : str -> term
  val sofi : term -> str
  val str_len : str -> term
  val str_const : string -> str
  val str_var : string -> str
end

module type z_term = sig
  type term

  (** Arithmetic *)

  val mod_ : term -> Z.t -> term
  val pow : term -> term -> term
  val mul : term list -> term
  val add : term list -> term
  val bw : sup_binop -> term -> term -> term

  (* val const : int -> term *)
  val constz : Z.t -> term
  val var : string -> term
end

module type s_ph = sig
  type ph
  type str
  type term

  val land_ : ph list -> ph
  val lor_ : ph list -> ph
  val not : ph -> ph
  val true_ : ph
  val false_ : ph
  val eqz : term -> term -> ph
  val neqz : term -> term -> ph
  val eq_str : str -> str -> ph
  val neq_str : str -> str -> ph
  val leq : term -> term -> ph
  val lt : term -> term -> ph
  val in_re : str -> char list Regex.t -> ph
end

module type s_extra = sig
  type term
  type ph

  val ( ** ) : term -> term -> term
  val ( <= ) : term -> term -> ph
  val ( < ) : term -> term -> ph
  val ( = ) : term -> term -> ph
  val ( <> ) : term -> term -> ph
end

module Sugar (S : sig
    type term
    type ph

    val pow : term -> term -> term

    (* val constz : Z.t -> term *)
    val eqz : term -> term -> ph
    val leq : term -> term -> ph
    val lt : term -> term -> ph
    val neqz : term -> term -> ph
  end) =
struct
  let ( = ) = S.eqz
  let ( < ) = S.lt
  let ( <= ) = S.leq
  let ( ** ) b e = S.pow b e
  let ( <> ) = S.neqz
end

module To_smtml_symantics : sig
  include str_term with type term = Smtml.Expr.t and type str = Smtml.Expr.t
  include z_term with type term = Smtml.Expr.t

  include
    s_ph
    with type term = Smtml.Expr.t
     and type ph = Smtml.Expr.t
     and type str = Smtml.Expr.t

  include s_extra with type ph := Smtml.Expr.t and type term = Smtml.Expr.t
end = struct
  open Smtml

  type term = Expr.t
  type str = Expr.t
  type ph = term

  let str_len _ = failwith "not implemented"
  let sofi _ = failwith "not implemented"
  let iofs _ = failwith "not implemented"
  let str_const _ = failwith "not implemented"
  let str_var _ = failwith "not implemented"
  let const n = Smtml.Expr.value (Value.Int n)

  let constz z =
    match Z.to_int z with
    | exception Z.Overflow -> failwith "What to do?"
    | n -> Expr.value (Value.Int n)
  [@@ocaml.warnerror "-32"]
  ;;

  let mod_ _ _ = failwith "not implemented"
  let pow base p = Expr.binop Ty.Ty_int Ty.Binop.Pow base p

  let add = function
    | [] ->
      (* const 0 ??? *)
      failwith (Printf.sprintf "Bad argument: %s" __FUNCTION__)
    | x :: xs -> List.fold_left (Expr.binop Ty.Ty_int Ty.Binop.Add) x xs
  ;;

  let mul = function
    | [] -> const 1
    | x :: xs -> List.fold_left (Expr.binop Ty.Ty_int Ty.Binop.Mul) x xs
  ;;

  let bw op l r =
    match op with
    | Bwand -> Expr.binop Ty.Ty_int Ty.Binop.And l r
    | Bwor -> Expr.binop Ty.Ty_int Ty.Binop.Or l r
    | Bwxor -> Expr.binop Ty.Ty_int Ty.Binop.Xor l r
  ;;

  let true_ = Expr.Bool.true_
  let false_ = Expr.Bool.false_
  let not = Expr.Bool.not

  let land_ = function
    | [] -> false_
    | h :: tl -> List.fold_left Expr.Bool.and_ h tl
  ;;

  let lor_ = function
    | [] -> true_
    | h :: tl -> List.fold_left Expr.Bool.or_ h tl
  ;;

  let var s = Expr.symbol (Smtml.Symbol.make Smtml.Ty.Ty_int s)
  let in_re _ _ = failwith __FILE__

  (* let exists vars x = Smtml.Expr.exists (List.map var vars) x *)
  let eqz l r = Smtml.(Expr.relop Ty.Ty_bool Ty.Relop.Eq l r)
  let eq_str _ _ = failwith "tbd"
  let neqz l r = Smtml.(Expr.relop Ty.Ty_bool Ty.Relop.Ne l r)
  let neq_str _ _ = failwith "tbd"
  let leq l r = Smtml.(Expr.relop Ty.Ty_int Ty.Relop.Le l r)
  let lt l r = Smtml.(Expr.relop Ty.Ty_int Ty.Relop.Lt l r)
  let ( = ) = eqz
  let ( < ) = lt
  let ( <= ) = leq
  let ( ** ) b e = pow b e
  let ( <> ) = neqz
end
