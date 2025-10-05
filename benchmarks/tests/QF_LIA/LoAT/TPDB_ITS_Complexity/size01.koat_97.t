size01.koat_97
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_97.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it13)
    1) (* i3 it436)
    2) (* i3 it446)
    3) (* it13 it436)
    4) (* it13 it48)
    5) (* it436 it446)
    6) (* it436 it48)
    7) (* it447 it73)
    8) (* it501 it73)
    9) (exp i3 2)
    10) (exp it13 2)
    11) (exp it13 3)
    12) (exp it436 2)
    13) (exp it436 3)
    14) (exp it446 2)
    15) (exp it446 3)
    16) (exp it48 2)
    17) (exp it48 3)
    18) (exp (+ i3 (* (- 2) it13 it436) (* (- 2) it436 it48)) 2)
    
  unknown (non-linear)
