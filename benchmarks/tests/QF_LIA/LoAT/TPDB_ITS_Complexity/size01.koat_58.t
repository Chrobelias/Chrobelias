size01.koat_58
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_58.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it13)
    1) (* i3 it48)
    2) (* it13 it48)
    3) (exp i3 2)
    4) (exp it13 2)
    5) (exp it13 3)
    6) (exp it48 2)
    7) (exp it48 3)
    8) (exp (+ i3 (* (- 2) it13)) 2)
    
  unknown (non-linear)
