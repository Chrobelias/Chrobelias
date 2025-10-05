size01.koat_173
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_173.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it13)
    1) (* i3 it48)
    2) (* i3 it73)
    3) (* it13 it48)
    4) (* it13 it73)
    5) (* it13 it844)
    6) (* it48 it73)
    7) (* it73 it844)
    8) (exp i3 2)
    9) (exp it13 2)
    10) (exp it13 3)
    11) (exp it48 2)
    12) (exp it48 3)
    13) (exp it73 2)
    14) (exp it73 3)
    15) (exp it844 2)
    16) (exp it844 3)
    17) (exp (+ i3 (* (- 2) it48)) 2)
    
  unknown (non-linear)
