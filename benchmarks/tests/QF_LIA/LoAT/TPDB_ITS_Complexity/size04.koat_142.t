size04.koat_142
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size04.koat_142.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it13)
    1) (* i3 it488)
    2) (* i3 it498)
    3) (* it13 it488)
    4) (* it13 it92)
    5) (* it488 it498)
    6) (* it488 it92)
    7) (exp i3 2)
    8) (exp it13 2)
    9) (exp it13 3)
    10) (exp it488 2)
    11) (exp it488 3)
    12) (exp it498 2)
    13) (exp it498 3)
    14) (exp it92 2)
    15) (exp it92 3)
    16) (exp (+ i3 (* (- 2) it13 it488) (* (- 2) it488 it92)) 2)
    
  unknown (non-linear)
