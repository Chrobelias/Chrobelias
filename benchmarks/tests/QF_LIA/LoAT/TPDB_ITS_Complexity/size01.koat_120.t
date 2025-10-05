size01.koat_120
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_120.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it13)
    1) (* i3 it436)
    2) (* i3 it446)
    3) (* it13 it436)
    4) (* it13 it48)
    5) (* it436 it446)
    6) (* it436 it48)
    7) (exp i3 2)
    8) (exp it13 2)
    9) (exp it13 3)
    10) (exp it436 2)
    11) (exp it436 3)
    12) (exp it446 2)
    13) (exp it446 3)
    14) (exp it48 2)
    15) (exp it48 3)
    16) (exp (+ i3 (* (- 2) it13 it436) (* (- 2) it436 it48)) 2)
    
  unknown (non-linear)
