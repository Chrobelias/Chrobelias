size04.koat_78
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size04.koat_78.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it117)
    1) (* i3 it128)
    2) (* i3 it13)
    3) (* it117 it128)
    4) (* it117 it13)
    5) (* it117 it92)
    6) (* it13 it92)
    7) (exp i3 2)
    8) (exp it117 2)
    9) (exp it117 3)
    10) (exp it128 2)
    11) (exp it128 3)
    12) (exp it13 2)
    13) (exp it13 3)
    14) (exp it92 2)
    15) (exp it92 3)
    16) (exp (+ i3 (* (- 2) it117 it13) (* (- 2) it117 it92)) 2)
    
  unknown (non-linear)
