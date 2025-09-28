twn05.koat_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn05.koat_0.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i8 it50)
    1) (exp i7 2)
    2) (exp it50 2)
    3) (exp (+ (- 1) (* (- 1) i8) (* 2 it50)) 2)
    
  unknown (non-linear)
