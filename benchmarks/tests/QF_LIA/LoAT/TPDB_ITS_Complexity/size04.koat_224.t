size04.koat_224
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size04.koat_224.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i3 it13)
    1) (* i3 it92)
    2) (* it13 it92)
    3) (exp i3 2)
    4) (exp it13 2)
    5) (exp it13 3)
    6) (exp it92 2)
    7) (exp it92 3)
    8) (exp (+ i3 (* (- 2) it92)) 2)
    
  unknown (non-linear)
