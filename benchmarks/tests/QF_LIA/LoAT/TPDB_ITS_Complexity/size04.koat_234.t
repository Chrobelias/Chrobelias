size04.koat_234
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size04.koat_234.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it1069)
    1) (* i3 it1115)
    2) (* i3 it117)
    3) (* i3 it92)
    4) (* it1069 it1115)
    5) (* it1069 it117)
    6) (* it1069 it13)
    7) (* it1115 it117)
    8) (* it1115 it92)
    9) (* it117 it13)
    10) (exp i3 2)
    11) (exp it1069 2)
    12) (exp it1069 3)
    13) (exp it1115 2)
    14) (exp it1115 3)
    15) (exp it117 2)
    16) (exp it117 3)
    17) (exp it13 2)
    18) (exp it13 3)
    19) (exp it92 2)
    20) (exp it92 3)
    21) (exp (+ i3 (* (- 2) it1069 it117) (* (- 2) it117 it13) (* (- 2) it92)) 2)
    22) (exp (+ i3 (* (- 2) it92)) 2)
    
  unknown (non-linear)
