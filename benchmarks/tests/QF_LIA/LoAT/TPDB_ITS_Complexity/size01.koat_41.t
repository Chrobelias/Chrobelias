size01.koat_41
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_41.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it13)
    1) (* i3 it48)
    2) (* it13 it48)
    3) (* it13 it73)
    4) (* it48 it73)
    5) (exp i3 2)
    6) (exp it13 2)
    7) (exp it13 3)
    8) (exp it48 2)
    9) (exp it48 3)
    10) (exp it73 2)
    11) (exp it73 3)
    12) (exp it78 2)
    13) (exp (+ (- 1) it78) 2)
    
  unknown (non-linear)
