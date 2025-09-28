size09.koat_62
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_62.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (* i7 it15)
    1) (* it15 it190)
    2) (* it15 it373)
    3) (* it160 it190)
    4) (* it190 it425)
    5) (* it190 it81)
    6) (* it373 it424)
    7) (exp it15 2)
    8) (exp it15 3)
    9) (exp (+ (- 1) (* (- 1) i7) (* 2 it190 it425 it81)
            (* 2 it373 it424 it425)) 2)
    
  unknown (non-linear)
