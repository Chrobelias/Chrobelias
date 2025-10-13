module type SYM = sig
  include FT_SIG.s_term with type term := Q.t * Ast.Eia.term

  include
    FT_SIG.s_ph
    with type term := Q.t * Ast.Eia.term
     and type ph = Ast.t
     and type str = Ast.Str.term

  val exists : string list -> ph -> ph
end

module Sy : SYM

val try_under2_heuristics
  :  base:int
  -> ?all_as:int list
  -> ?all_bs:int list
  -> fLat:int
  -> Ast.t
  -> Ast.t list
