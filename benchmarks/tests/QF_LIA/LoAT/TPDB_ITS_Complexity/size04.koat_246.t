size04.koat_246
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size04.koat_246.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it1069)
    1) (* i3 it117)
    2) (* i3 it92)
    3) (* it1069 it117)
    4) (* it1069 it13)
    5) (* it117 it13)
    6) (exp i3 2)
    7) (exp it1069 2)
    8) (exp it1069 3)
    9) (exp it117 2)
    10) (exp it117 3)
    11) (exp it13 2)
    12) (exp it13 3)
    13) (exp it92 2)
    14) (exp it92 3)
    15) (exp (+ i3 (* (- 2) it92)) 2)
    
  unknown (non-linear)
