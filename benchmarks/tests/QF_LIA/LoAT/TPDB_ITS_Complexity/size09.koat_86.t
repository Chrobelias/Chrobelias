size09.koat_86
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_86.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i7 it15)
    1) (* i7 it588)
    2) (* it15 it190)
    3) (* it15 it373)
    4) (* it15 it588)
    5) (* it160 it190)
    6) (* it190 it425)
    7) (* it190 it81)
    8) (* it373 it424)
    9) (* it588 it589)
    10) (* it607 it608)
    11) (* it607 it610)
    12) (* it608 it609)
    13) (* it610 it612)
    14) (exp it15 2)
    15) (exp it15 3)
    16) (exp it588 2)
    17) (exp it588 3)
    18) (exp (+ (- 1) (* (- 1) i7) (* 2 it15) (* 2 it190 it425 it589 it81)
             (* 2 it373 it424 it425 it589)) 2)
    19) (exp (+ (- 1) (* (- 1) i7) (* 2 it190 it425 it589 it81)
             (* 2 it373 it424 it425 it589)) 2)
    
  unknown (non-linear)
