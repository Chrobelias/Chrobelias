size02.koat_65
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_65.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it117)
    1) (* i3 it127)
    2) (* i3 it128)
    3) (* i3 it13)
    4) (* it117 it127)
    5) (* it117 it128)
    6) (* it117 it13)
    7) (* it117 it92)
    8) (* it127 it128)
    9) (* it13 it92)
    10) (exp i3 2)
    11) (exp it117 2)
    12) (exp it117 3)
    13) (exp it127 2)
    14) (exp it127 3)
    15) (exp it128 2)
    16) (exp it128 3)
    17) (exp it13 2)
    18) (exp it13 3)
    19) (exp it92 2)
    20) (exp it92 3)
    21) (exp (+ i3 (* (- 2) it117 it13) (* (- 2) it117 it92)) 2)
    22) (exp (+ i3 (* (- 2) it117 it13) (* (- 2) it117 it92) (* (- 2) it128)) 2)
    
  unknown (non-linear)
