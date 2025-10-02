size03.koat_26
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size03.koat_26.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it127)
    1) (* i3 it13)
    2) (* it127 it13)
    3) (exp i3 2)
    4) (exp it127 2)
    5) (exp it127 3)
    6) (exp it13 2)
    7) (exp it13 3)
    8) (exp (+ i3 (* (- 2) it13)) 2)
    
  unknown (non-linear)
