size03.koat_42
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size03.koat_42.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it127)
    1) (* i3 it13)
    2) (* i3 it162)
    3) (* i3 it163)
    4) (* it127 it13)
    5) (* it127 it152)
    6) (* it13 it152)
    7) (* it162 it163)
    8) (exp i3 2)
    9) (exp it127 2)
    10) (exp it127 3)
    11) (exp it13 2)
    12) (exp it13 3)
    13) (exp it152 2)
    14) (exp it152 3)
    15) (exp it162 2)
    16) (exp it162 3)
    17) (exp it163 2)
    18) (exp it163 3)
    19) (exp (+ i3 (* (- 2) it127 it152) (* (- 2) it13 it152)) 2)
    20) (exp (+ i3 (* (- 2) it127 it152) (* (- 2) it13 it152) (* (- 2) it163)) 2)
    
  unknown (non-linear)
