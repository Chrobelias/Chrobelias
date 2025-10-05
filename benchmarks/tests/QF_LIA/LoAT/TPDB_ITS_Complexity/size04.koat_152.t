size04.koat_152
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size04.koat_152.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it13)
    1) (* i3 it488)
    2) (* i3 it498)
    3) (* it117 it499)
    4) (* it117 it553)
    5) (* it13 it488)
    6) (* it13 it92)
    7) (* it488 it498)
    8) (* it488 it92)
    9) (exp i3 2)
    10) (exp it13 2)
    11) (exp it13 3)
    12) (exp it488 2)
    13) (exp it488 3)
    14) (exp it498 2)
    15) (exp it498 3)
    16) (exp it92 2)
    17) (exp it92 3)
    18) (exp (+ i3 (* (- 2) it13 it488) (* (- 2) it488 it92)) 2)
    
  unknown (non-linear)
