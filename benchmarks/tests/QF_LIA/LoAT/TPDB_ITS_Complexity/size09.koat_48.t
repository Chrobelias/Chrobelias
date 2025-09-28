size09.koat_48
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_48.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i7 it160)
    1) (* it15 it220)
    2) (* it160 it190)
    3) (* it190 it81)
    4) (exp it15 2)
    5) (exp it15 3)
    6) (exp it160 2)
    7) (exp it160 3)
    8) (exp it220 2)
    9) (exp (+ 1 i7 (* (- 2) it190 it81)) 2)
    
  unknown (non-linear)
