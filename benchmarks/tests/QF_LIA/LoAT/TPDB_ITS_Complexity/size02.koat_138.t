size02.koat_138
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_138.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (exp i3 2)
    1) (exp it13 2)
    2) (exp it13 3)
    3) (exp it488 2)
    4) (exp it488 3)
    5) (exp it493 2)
    6) (exp it498 2)
    7) (exp it498 3)
    8) (exp it549 2)
    9) (exp it92 2)
    10) (exp it92 3)
    11) (exp (+ (- 1) it549) 2)
    
  ; Need to improve --- UNSAT is expected
  unknown
  ; non-linear
