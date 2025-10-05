size09.koat_70
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_70.smt2 || echo TIMEOUT
  Non linear arithmetic between
    0) (exp it15 2)
    1) (exp it15 3)
    2) (exp (+ (- 1) (* (- 1) i7) (* 2 it190 it425 it81)
            (* 2 it373 it424 it425)) 2)
    
  ; Need to improve --- SAT is expected
  unknown
  ; non-linear
