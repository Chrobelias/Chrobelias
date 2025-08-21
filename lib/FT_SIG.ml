type sup_binop =
  | Bwand
  | Bwor
  | Bwxor

module type s_term = sig
  type term

  val pow : term -> term -> term
  val mul : term list -> term
  val add : term list -> term
  val bw : sup_binop -> term -> term -> term
  val const : int -> term
  val var : string -> term
end

module type s_ph = sig
  type ph
  type term

  val land_ : ph list -> ph
  val lor_ : ph list -> ph
  val not : ph -> ph
  val true_ : ph
  val false_ : ph
  val eq : term -> term -> ph
  val leq : term -> term -> ph
  val lt : term -> term -> ph
end

module type s_extra = sig
  type term
  type ph

  val ( <= ) : term -> term -> ph
  val ( < ) : term -> term -> ph
  val ( = ) : term -> term -> ph
end

type ('a, 'syn) folder =
  { land_ : 'self -> Ast.t list -> 'syn }
  constraint 'self = ('a, 'syn) folder

module Sugar (S : sig
    type term
    type ph

    val eq : term -> term -> ph
    val leq : term -> term -> ph
    val lt : term -> term -> ph
  end) =
struct
  let ( = ) = S.eq
  let ( < ) = S.lt
  let ( <= ) = S.leq
end
