size09.koat_55
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_55.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i7 it160)
    1) (* it15 it199)
    2) (* it15 it202)
    3) (* it15 it373)
    4) (* it160 it190)
    5) (* it190 it81)
    6) (* it202 it373)
    7) (exp it15 2)
    8) (exp it15 3)
    9) (exp it160 2)
    10) (exp it160 3)
    11) (exp (+ (- 1) (* (- 1) it199) (* 2 it202 it373)) 2)
    12) (exp (+ 1 i7 (* (- 2) it190 it81)) 2)
    
  unknown (non-linear)
