size02.koat_215
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_215.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it13)
    1) (* i3 it488)
    2) (* i3 it872)
    3) (* it13 it488)
    4) (* it13 it872)
    5) (* it488 it872)
    6) (* it488 it92)
    7) (* it872 it92)
    8) (exp i3 2)
    9) (exp it13 2)
    10) (exp it13 3)
    11) (exp it488 2)
    12) (exp it488 3)
    13) (exp it872 2)
    14) (exp it872 3)
    15) (exp it92 2)
    16) (exp it92 3)
    17) (exp (+ i3 (* (- 2) it13)) 2)
    
  unknown (non-linear)
