size02.koat_268
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_268.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it117)
    1) (* i3 it1188)
    2) (* i3 it1210)
    3) (* i3 it92)
    4) (* it117 it1188)
    5) (* it117 it1210)
    6) (* it117 it13)
    7) (* it1188 it13)
    8) (* it1210 it92)
    9) (exp i3 2)
    10) (exp it117 2)
    11) (exp it117 3)
    12) (exp it1188 2)
    13) (exp it1188 3)
    14) (exp it1210 2)
    15) (exp it1210 3)
    16) (exp it13 2)
    17) (exp it13 3)
    18) (exp it92 2)
    19) (exp it92 3)
    20) (exp (+ i3 (* (- 2) it117 it1188) (* (- 2) it117 it13) (* (- 2) it92)) 2)
    21) (exp (+ i3 (* (- 2) it92)) 2)
    
  unknown (non-linear)
