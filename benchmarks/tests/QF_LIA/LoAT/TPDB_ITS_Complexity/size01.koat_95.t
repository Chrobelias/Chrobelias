size01.koat_95
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_95.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it13)
    1) (* i3 it436)
    2) (* i3 it446)
    3) (* i3 it447)
    4) (* it13 it436)
    5) (* it13 it48)
    6) (* it436 it446)
    7) (* it436 it447)
    8) (* it436 it48)
    9) (* it446 it447)
    10) (exp i3 2)
    11) (exp it13 2)
    12) (exp it13 3)
    13) (exp it436 2)
    14) (exp it436 3)
    15) (exp it446 2)
    16) (exp it446 3)
    17) (exp it447 2)
    18) (exp it447 3)
    19) (exp it48 2)
    20) (exp it48 3)
    21) (exp (+ i3 (* (- 2) it13 it436) (* (- 2) it436 it48)) 2)
    22) (exp (+ i3 (* (- 2) it13 it436) (* (- 2) it436 it48) (* (- 2) it446)) 2)
    
  unknown (non-linear)
