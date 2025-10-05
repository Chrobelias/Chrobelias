twn05.koat_1
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn05.koat_1.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (exp i7 2)
    1) (exp it50 2)
    2) (exp (+ (- 1) (* (- 1) i8) (* 2 it50)) 2)
    
  ; Need to improve --- SAT is expected
  unknown
  ; non-linear
