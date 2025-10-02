size09.koat_87
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_87.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i7 it15)
    1) (* i7 it588)
    2) (* it15 it190)
    3) (* it15 it373)
    4) (* it15 it588)
    5) (* it190 it425)
    6) (* it190 it81)
    7) (* it373 it424)
    8) (exp it15 2)
    9) (exp it15 3)
    10) (exp it588 2)
    11) (exp it588 3)
    12) (exp (+ (- 1) (* (- 1) i7) (* 2 it15) (* 2 it190 it425 it589 it81)
             (* 2 it373 it424 it425 it589)) 2)
    13) (exp (+ (- 1) (* (- 1) i7) (* 2 it190 it425 it589 it81)
             (* 2 it373 it424 it425 it589)) 2)
    
  unknown (non-linear)
