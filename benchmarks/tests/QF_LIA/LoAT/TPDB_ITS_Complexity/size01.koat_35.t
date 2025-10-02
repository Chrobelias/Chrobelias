size01.koat_35
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_35.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it13)
    1) (* i3 it48)
    2) (* i3 it84)
    3) (* it13 it48)
    4) (* it13 it73)
    5) (* it48 it73)
    6) (exp i3 2)
    7) (exp it13 2)
    8) (exp it13 3)
    9) (exp it48 2)
    10) (exp it48 3)
    11) (exp it73 2)
    12) (exp it73 3)
    13) (exp it84 2)
    14) (exp it84 3)
    15) (exp (+ i3 (* (- 2) it13 it73) (* (- 2) it48 it73)) 2)
    
  unknown (non-linear)
