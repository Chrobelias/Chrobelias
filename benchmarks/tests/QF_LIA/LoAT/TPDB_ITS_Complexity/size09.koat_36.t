size09.koat_36
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_36.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (exp it160 2)
    1) (exp it160 3)
    2) (exp (+ 1 i7 (* (- 2) it190 it81)) 2)
    
  ; Need to improve --- SAT is expected
  unknown
  ; non-linear
