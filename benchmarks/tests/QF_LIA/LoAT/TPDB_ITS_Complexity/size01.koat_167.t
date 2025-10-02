size01.koat_167
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_167.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it13)
    1) (* i3 it48)
    2) (* i3 it73)
    3) (* i3 it926)
    4) (* it13 it48)
    5) (* it13 it73)
    6) (* it13 it844)
    7) (* it48 it73)
    8) (* it48 it926)
    9) (* it73 it844)
    10) (exp i3 2)
    11) (exp it13 2)
    12) (exp it13 3)
    13) (exp it48 2)
    14) (exp it48 3)
    15) (exp it73 2)
    16) (exp it73 3)
    17) (exp it844 2)
    18) (exp it844 3)
    19) (exp it926 2)
    20) (exp it926 3)
    21) (exp (+ i3 (* (- 2) it13 it73) (* (- 2) it48) (* (- 2) it73 it844)) 2)
    22) (exp (+ i3 (* (- 2) it48)) 2)
    
  unknown (non-linear)
