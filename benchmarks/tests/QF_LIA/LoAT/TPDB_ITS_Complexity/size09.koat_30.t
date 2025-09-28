size09.koat_30
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_30.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i7 it160)
    1) (* it160 it190)
    2) (* it190 it81)
    3) (exp it160 2)
    4) (exp it160 3)
    5) (exp (+ 1 i7 (* (- 2) it190 it81)) 2)
    
  unknown (non-linear)
