module Map = Base.Map.Poly

val check_sat
  :  Ir.t
  -> [ `Sat of (Ir.atom, [ `Str | `Int ]) Map.t -> (Ir.model, [ `No_model ]) Result.t
     | `Unsat
     | `Unknown of Ir.t
     ]
       list
