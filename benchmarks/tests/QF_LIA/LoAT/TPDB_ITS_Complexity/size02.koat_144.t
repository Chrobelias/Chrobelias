size02.koat_144
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_144.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it13)
    1) (* i3 it488)
    2) (* i3 it498)
    3) (* i3 it499)
    4) (* it13 it488)
    5) (* it13 it92)
    6) (* it488 it498)
    7) (* it488 it499)
    8) (* it488 it92)
    9) (* it498 it499)
    10) (exp i3 2)
    11) (exp it13 2)
    12) (exp it13 3)
    13) (exp it488 2)
    14) (exp it488 3)
    15) (exp it498 2)
    16) (exp it498 3)
    17) (exp it499 2)
    18) (exp it499 3)
    19) (exp it92 2)
    20) (exp it92 3)
    21) (exp (+ i3 (* (- 2) it13 it488) (* (- 2) it488 it92)) 2)
    22) (exp (+ i3 (* (- 2) it13 it488) (* (- 2) it488 it92) (* (- 2) it498)) 2)
    
  unknown (non-linear)
