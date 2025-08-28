size09.koat_93
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_93.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ it15 it588))
                      (= (+ it599 (* (- 4) it190 it425 it589 it81)
                         (* (- 4) it373 it424 it425 it589)
                         (* (- 2) it15 it373 it425 it589)
                         (* (- 2) it160 it190 it425 it589)
                         (* (- 2) it588 it589) (* (- 1) i2)) 1)
                      (= (+ it600 (* (- 2) it190 it425 it81)
                         (* (- 2) it190 it81) (* (- 2) it373 it424)
                         (* (- 2) it373 it424 it425) (* (- 2) it424)
                         (* (- 1) i7) (* 2 it15) (* 2 it190 it425 it589 it81)
                         (* 2 it190 it425 it81) (* 2 it190 it81)
                         (* 2 it373 it424) (* 2 it373 it424 it425)
                         (* 2 it373 it424 it425 it589) (* 2 it424) (* 2 it588)) 1)
                      (= (+ it601 (* (- 4) it190 it425 it81 (exp (- 1) eee1))
                         (* (- 4) it190 it81 (exp (- 1) eee1))
                         (* (- 4) it373 it424 it425 (exp (- 1) eee1))
                         (* (- 4) it373 it424 (exp (- 1) eee1))
                         (* (- 4) it424 (exp (- 1) eee1))
                         (* (- 2) i7 (exp (- 1) eee1))
                         (* (- 2) (exp (- 1) eee1))
                         (* 4 it190 it425 it589 it81 (exp (- 1) eee1))
                         (* 4 it190 it425 it81 (exp (- 1) eee1))
                         (* 4 it190 it81 (exp (- 1) eee1))
                         (* 4 it373 it424 it425 it589 (exp (- 1) eee1))
                         (* 4 it373 it424 it425 (exp (- 1) eee1))
                         (* 4 it373 it424 (exp (- 1) eee1))
                         (* 4 it424 (exp (- 1) eee1))) 0)
                      (= (+ it602 (* (- 6) it190 it425 it81 (exp (- 1) eee1))
                         (* (- 6) it190 it81 (exp (- 1) eee1))
                         (* (- 6) it373 it424 it425 (exp (- 1) eee1))
                         (* (- 6) it373 it424 (exp (- 1) eee1))
                         (* (- 6) it424 (exp (- 1) eee1))
                         (* (- 3) i7 (exp (- 1) eee1))
                         (* (- 3) (exp (- 1) eee1))
                         (* 6 it190 it425 it589 it81 (exp (- 1) eee1))
                         (* 6 it190 it425 it81 (exp (- 1) eee1))
                         (* 6 it190 it81 (exp (- 1) eee1))
                         (* 6 it373 it424 it425 it589 (exp (- 1) eee1))
                         (* 6 it373 it424 it425 (exp (- 1) eee1))
                         (* 6 it373 it424 (exp (- 1) eee1))
                         (* 6 it424 (exp (- 1) eee1))) 0)
                      (= (+ it604 (* (- 1) i7) (* 2 it190 it425 it589 it81)
                         (* 2 it373 it424 it425 it589)) 0)
                      (= (+ it667 (* (- 3) it601) (* (- 2) it602)) 0)
                      (= (+ it668 (* 3 it602) (* 5 it601)) 0)
                      (= (+ it669 (* (- 1) it603) (* (- 1) (exp it600 2))) 0)
                      (= (+ (* (- 24) it15 (exp it588 2))
                         (* (- 24) it190 it425 it589 it81 (exp it15 2))
                         (* (- 24) it190 it425 it589 it81 (exp it588 2))
                         (* (- 24) it190 it425 it81 (exp it15 2))
                         (* (- 24) it190 it425 it81 (exp it588 2))
                         (* (- 24) it190 it81 (exp it15 2))
                         (* (- 24) it190 it81 (exp it588 2))
                         (* (- 24) it373 it424 it425 it589 (exp it15 2))
                         (* (- 24) it373 it424 it425 it589 (exp it588 2))
                         (* (- 24) it373 it424 it425 (exp it15 2))
                         (* (- 24) it373 it424 it425 (exp it588 2))
                         (* (- 24) it373 it424 (exp it15 2))
                         (* (- 24) it373 it424 (exp it588 2))
                         (* (- 24) it424 (exp it15 2))
                         (* (- 24) it424 (exp it588 2))
                         (* (- 12) it15 it190 it425 it81)
                         (* (- 12) it15 it190 it81) (* (- 12) it15 it373 it424)
                         (* (- 12) it15 it373 it424 it425)
                         (* (- 12) it15 it424)
                         (* (- 12) it190 it425 it588 it81)
                         (* (- 12) it190 it588 it81)
                         (* (- 12) it373 it424 it425 it588)
                         (* (- 12) it373 it424 it588) (* (- 12) it424 it588)
                         (* (- 8) (exp it15 3)) (* (- 8) (exp it588 3))
                         (* (- 6) i7 it15) (* (- 6) i7 it588) (* (- 6) it15)
                         (* (- 6) it15
                         (exp (+ (- 1) (* (- 2) it190 it425 it81)
                              (* (- 2) it190 it81) (* (- 2) it373 it424)
                              (* (- 2) it373 it424 it425) (* (- 2) it424)
                              (* (- 1) i7) (* 2 it190 it425 it589 it81)
                              (* 2 it190 it425 it81) (* 2 it190 it81)
                              (* 2 it373 it424) (* 2 it373 it424 it425)
                              (* 2 it373 it424 it425 it589) (* 2 it424)) 2))
                         (* (- 6) it190 it425 it81) (* (- 6) it190 it81)
                         (* (- 6) it373 it424) (* (- 6) it373 it424 it425)
                         (* (- 6) it424) (* (- 6) it588)
                         (* (- 6) it588
                         (exp (+ (- 1) (* (- 2) it190 it425 it81)
                              (* (- 2) it190 it81) (* (- 2) it373 it424)
                              (* (- 2) it373 it424 it425) (* (- 2) it424)
                              (* (- 1) i7) (* 2 it15)
                              (* 2 it190 it425 it589 it81)
                              (* 2 it190 it425 it81) (* 2 it190 it81)
                              (* 2 it373 it424) (* 2 it373 it424 it425)
                              (* 2 it373 it424 it425 it589) (* 2 it424)) 2))
                         (* (- 3) i7) (* (- 1) it15) (* (- 1) it588)
                         (* 3 it603) (* 6 it190 it425 it589 it81)
                         (* 6 it190 it425 it81) (* 6 it190 it81)
                         (* 6 it373 it424) (* 6 it373 it424 it425)
                         (* 6 it373 it424 it425 it589) (* 6 it424)
                         (* 6 (exp it15 2)) (* 6 (exp it588 2))
                         (* 12 i7 (exp it15 2)) (* 12 i7 (exp it588 2))
                         (* 12 it15 it190 it425 it589 it81)
                         (* 12 it15 it190 it425 it81) (* 12 it15 it190 it81)
                         (* 12 it15 it373 it424) (* 12 it15 it373 it424 it425)
                         (* 12 it15 it373 it424 it425 it589) (* 12 it15 it424)
                         (* 12 it15 it588) (* 12 it190 it425 it588 it589 it81)
                         (* 12 it190 it425 it588 it81) (* 12 it190 it588 it81)
                         (* 12 it373 it424 it425 it588)
                         (* 12 it373 it424 it425 it588 it589)
                         (* 12 it373 it424 it588) (* 12 it424 it588)
                         (* 12 (exp it15 2)) (* 12 (exp it588 2))
                         (* 24 it190 it425 it81 (exp it15 2))
                         (* 24 it190 it425 it81 (exp it588 2))
                         (* 24 it190 it81 (exp it15 2))
                         (* 24 it190 it81 (exp it588 2))
                         (* 24 it373 it424 it425 (exp it15 2))
                         (* 24 it373 it424 it425 (exp it588 2))
                         (* 24 it373 it424 (exp it15 2))
                         (* 24 it373 it424 (exp it588 2))
                         (* 24 it424 (exp it15 2)) (* 24 it424 (exp it588 2))) 6)
                      (= (* 2 it612) 0)
                      (<= 1 i3)
                      (<= 1 i7)
                      (<= 1 it600)
                      (<= 1 it604)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 2) it424) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425) (* 2 it373 it424 it425 it589)
                          (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 2) it424) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425) (* 2 it373 it424 it425 it589)
                          (* 2 it424)) 2)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 2) it424) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425) (* 2 it373 it424 it425 it589)
                          (* 2 it424) (* 2 it588)) 1)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 2) it424) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425) (* 2 it373 it424 it425 it589)
                          (* 2 it424) (* 2 it588)) 2)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 2) it424) (* (- 1) i7)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425) (* 2 it373 it424 it425 it589)
                          (* 2 it424)) 0)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 2) it424) (* (- 1) i7)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425) (* 2 it373 it424 it425 it589)
                          (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 2) it81) (* (- 1) i7) (* 2 it160)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425)
                          (* 2 it373 it424 it425 it589) (* 2 it81)) 1)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 2) it81) (* (- 1) i7) (* 2 it160)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425)
                          (* 2 it373 it424 it425 it589) (* 2 it81)) 2)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 2) it81) (* (- 1) i7)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425)
                          (* 2 it373 it424 it425 it589)) (- 2))
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 2) it81) (* (- 1) i7)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425)
                          (* 2 it373 it424 it425 it589) (* 2 it81)) 0)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 2) it81) (* (- 1) i7)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425)
                          (* 2 it373 it424 it425 it589) (* 2 it81)) 1)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 1) i7) (* 2 it15) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425) (* 2 it373 it424 it425 it589)
                          (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 1) i7) (* 2 it15) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425) (* 2 it373 it424 it425 it589)
                          (* 2 it424)) 2)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 1) i7) (* 2 it160) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it425 it81) (* 2 it373 it424 it425)
                          (* 2 it373 it424 it425 it589) (* 2 it81)) 1)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 1) i7) (* 2 it160) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it425 it81) (* 2 it373 it424 it425)
                          (* 2 it373 it424 it425 it589) (* 2 it81)) 2)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 1) i7) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425)
                          (* 2 it373 it424 it425 it589)) (- 2))
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 1) i7) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425)
                          (* 2 it373 it424 it425 it589)) (- 1))
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 1) i7) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425) (* 2 it373 it424 it425 it589)
                          (* 2 it424)) 0)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 1) i7) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425) (* 2 it373 it424 it425 it589)
                          (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 1) i7) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it425 it81) (* 2 it373 it424 it425)
                          (* 2 it373 it424 it425 it589)) (- 2))
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 1) i7) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it425 it81) (* 2 it373 it424 it425)
                          (* 2 it373 it424 it425 it589) (* 2 it81)) 0)
                      (<= (+ (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
                          (* (- 2) it373 it424) (* (- 2) it373 it424 it425)
                          (* (- 1) i7) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it425 it81) (* 2 it373 it424 it425)
                          (* 2 it373 it424 it425 it589) (* 2 it81)) 1)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 2) it424)
                          (* (- 1) i7) (* 2 it15) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425 it589) (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 2) it424)
                          (* (- 1) i7) (* 2 it15) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425 it589) (* 2 it424)) 2)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 2) it424)
                          (* (- 1) i7) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it425 it81) (* 2 it373 it424 it425)
                          (* 2 it373 it424 it425 it589)) (- 2))
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 2) it424)
                          (* (- 1) i7) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425 it589)) (- 2))
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 2) it424)
                          (* (- 1) i7) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425 it589) (* 2 it424)) 0)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 2) it424)
                          (* (- 1) i7) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425 it589) (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 2) it81)
                          (* (- 1) i7) (* 2 it160) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425 it589)
                          (* 2 it81)) 1)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 2) it81)
                          (* (- 1) i7) (* 2 it160) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425 it589)
                          (* 2 it81)) 2)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 2) it81)
                          (* (- 1) i7) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425 it589)) (- 2))
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 2) it81)
                          (* (- 1) i7) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425 it589)
                          (* 2 it81)) 0)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 2) it81)
                          (* (- 1) i7) (* 2 it190 it425 it589 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425 it589)
                          (* 2 it81)) 1)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425 it589) (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425 it589) (* 2 it424)) 2)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 1) i7) (* 2 it160)
                          (* 2 it190 it425 it589 it81)
                          (* 2 it373 it424 it425 it589) (* 2 it81)) 1)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 1) i7) (* 2 it160)
                          (* 2 it190 it425 it589 it81)
                          (* 2 it373 it424 it425 it589) (* 2 it81)) 2)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 1) i7)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425 it589)) (- 2))
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 1) i7)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425 it589)) (- 1))
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 1) i7)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425 it589) (* 2 it424)) 0)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 1) i7)
                          (* 2 it190 it425 it589 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425 it589) (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 1) i7)
                          (* 2 it190 it425 it589 it81)
                          (* 2 it373 it424 it425 it589) (* 2 it81)) 0)
                      (<= (+ (* (- 2) it190 it425 it81)
                          (* (- 2) it373 it424 it425) (* (- 1) i7)
                          (* 2 it190 it425 it589 it81)
                          (* 2 it373 it424 it425 it589) (* 2 it81)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it424) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424) (* 2 it373 it424 it425)
                          (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it424) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424) (* 2 it373 it424 it425)
                          (* 2 it424)) 2)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it424) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424) (* 2 it373 it424 it425) (* 2 it424)
                          (* 2 it588)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it424) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424) (* 2 it373 it424 it425) (* 2 it424)
                          (* 2 it588)) 2)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it424) (* (- 1) i7) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425) (* 2 it424)) 0)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it424) (* (- 1) i7) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424)
                          (* 2 it373 it424 it425) (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it81) (* (- 1) i7) (* 2 it160)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425) (* 2 it81)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it81) (* (- 1) i7) (* 2 it160)
                          (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425) (* 2 it81)) 2)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 2) it81) (* (- 1) i7) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425)) (- 2))
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it15) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425) (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it15) (* 2 it190 it425 it81)
                          (* 2 it190 it81) (* 2 it373 it424 it425) (* 2 it424)) 2)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it160) (* 2 it190 it425 it81)
                          (* 2 it373 it424 it425) (* 2 it81)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it160) (* 2 it190 it425 it81)
                          (* 2 it373 it424 it425) (* 2 it81)) 2)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425)) (- 2))
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425)) (- 1))
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425)) 0)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425) (* 2 it424)) 0)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81) (* 2 it190 it81)
                          (* 2 it373 it424 it425) (* 2 it424)) 1)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81)
                          (* 2 it373 it424 it425)) (- 2))
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81)
                          (* 2 it373 it424 it425) (* 2 it81)) 0)
                      (<= (+ (* (- 2) it190 it81) (* (- 2) it373 it424)
                          (* (- 1) i7) (* 2 it190 it425 it81)
                          (* 2 it373 it424 it425) (* 2 it81)) 1)
                      (<= (+ (* (- 2) it424) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it81) (* 2 it373 it424) (* 2 it424)) 1)
                      (<= (+ (* (- 2) it424) (* (- 1) i7) (* 2 it15)
                          (* 2 it190 it81) (* 2 it373 it424) (* 2 it424)) 2)
                      (<= (+ (* (- 2) it424) (* (- 1) i7)
                          (* 2 it190 it425 it81) (* 2 it373 it424 it425)) (- 2))
                      (<= (+ (* (- 2) it424) (* (- 1) i7) (* 2 it190 it81)
                          (* 2 it373 it424)) (- 2))
                      (<= (+ (* (- 2) it424) (* (- 1) i7) (* 2 it190 it81)
                          (* 2 it373 it424) (* 2 it424)) 0)
                      (<= (+ (* (- 2) it424) (* (- 1) i7) (* 2 it190 it81)
                          (* 2 it373 it424) (* 2 it424)) 1)
                      (<= (+ (* (- 2) it81) (* (- 1) i7) (* 2 it160)
                          (* 2 it190 it81) (* 2 it81)) 1)
                      (<= (+ (* (- 2) it81) (* (- 1) i7) (* 2 it160)
                          (* 2 it190 it81) (* 2 it81)) 2)
                      (<= (+ (* (- 2) it81) (* (- 1) i7) (* 2 it190 it81)) (- 2))
                      (<= (+ (* (- 1) i7) (* 2 it15) (* 2 it190 it81)
                          (* 2 it424)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it15) (* 2 it190 it81)
                          (* 2 it424)) 2)
                      (<= (+ (* (- 1) i7) (* 2 it160) (* 2 it81)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it160) (* 2 it81)) 2)
                      (<= (+ (* (- 1) i7) (* 2 it190 it81)) (- 2))
                      (<= (+ (* (- 1) i7) (* 2 it190 it81)) (- 1))
                      (<= (+ (* (- 1) i7) (* 2 it190 it81)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it190 it81)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it190 it81) (* 2 it424)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it190 it81) (* 2 it424)) 1)
                      (<= (+ (* (- 1) i7) (* 2 it81)) 0)
                      (<= (+ (* (- 1) i7) (* 2 it81)) 1)
                      (<= (+ (* (- 1) it604) (* 2 it612)) 0)
                      (<= (+ (* (- 1) it604) (* 2 it612)) 1)
                      (<= (+ (* (- 1) it604) (* 2 it612) (* 2 it613)) 1)
                      (<= (+ (* (- 1) it604) (* 2 it612) (* 2 it613)) 2)
                      (<= (* (- 1) i7) (- 2))
                      (<= (* (- 1) it15) (- 1))
                      (<= (* (- 1) it160) (- 1))
                      (<= (* (- 1) it190) (- 1))
                      (<= (* (- 1) it373) (- 1))
                      (<= (* (- 1) it424) (- 1))
                      (<= (* (- 1) it425) (- 1))
                      (<= (* (- 1) it588) (- 1))
                      (<= (* (- 1) it589) (- 1))
                      (<= (* (- 1) it604) (- 2))
                      (<= (* (- 1) it612) (- 1))
                      (<= (* (- 1) it613) (- 1))
                      (<= (* (- 1) it81) (- 1))
                      (<= (* 2 it612) 0))
  Non linear arithmetic between
    0) i7
    1) it15
    
  Non linear arithmetic between
    0) i7
    1) it588
    
  Non linear arithmetic between
    0) i7
    1) (exp it15 2)
    
  Non linear arithmetic between
    0) i7
    1) (exp it588 2)
    
  Non linear arithmetic between
    0) i7
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it15
    1) it190
    2) it425
    3) it589
    4) it81
    
  Non linear arithmetic between
    0) it15
    1) it190
    2) it425
    3) it81
    
  Non linear arithmetic between
    0) it15
    1) it190
    2) it81
    
  Non linear arithmetic between
    0) it15
    1) it373
    2) it424
    
  Non linear arithmetic between
    0) it15
    1) it373
    2) it424
    3) it425
    
  Non linear arithmetic between
    0) it15
    1) it373
    2) it424
    3) it425
    4) it589
    
  Non linear arithmetic between
    0) it15
    1) it373
    2) it425
    3) it589
    
  Non linear arithmetic between
    0) it15
    1) it424
    
  Non linear arithmetic between
    0) it15
    1) it588
    
  Non linear arithmetic between
    0) it15
    1) (exp it588 2)
    
  Non linear arithmetic between
    0) it15
    1) (exp (+ (- 1) (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
            (* (- 2) it373 it424) (* (- 2) it373 it424 it425) (* (- 2) it424)
            (* (- 1) i7) (* 2 it190 it425 it589 it81) (* 2 it190 it425 it81)
            (* 2 it190 it81) (* 2 it373 it424) (* 2 it373 it424 it425)
            (* 2 it373 it424 it425 it589) (* 2 it424)) 2)
    
  Non linear arithmetic between
    0) it160
    1) it190
    2) it425
    3) it589
    
  Non linear arithmetic between
    0) it190
    1) it425
    2) it588
    3) it589
    4) it81
    
  Non linear arithmetic between
    0) it190
    1) it425
    2) it588
    3) it81
    
  Non linear arithmetic between
    0) it190
    1) it425
    2) it589
    3) it81
    
  Non linear arithmetic between
    0) it190
    1) it425
    2) it589
    3) it81
    4) (exp it15 2)
    
  Non linear arithmetic between
    0) it190
    1) it425
    2) it589
    3) it81
    4) (exp it588 2)
    
  Non linear arithmetic between
    0) it190
    1) it425
    2) it589
    3) it81
    4) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it190
    1) it425
    2) it81
    
  Non linear arithmetic between
    0) it190
    1) it425
    2) it81
    3) (exp it15 2)
    
  Non linear arithmetic between
    0) it190
    1) it425
    2) it81
    3) (exp it588 2)
    
  Non linear arithmetic between
    0) it190
    1) it425
    2) it81
    3) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it190
    1) it588
    2) it81
    
  Non linear arithmetic between
    0) it190
    1) it81
    
  Non linear arithmetic between
    0) it190
    1) it81
    2) (exp it15 2)
    
  Non linear arithmetic between
    0) it190
    1) it81
    2) (exp it588 2)
    
  Non linear arithmetic between
    0) it190
    1) it81
    2) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it373
    1) it424
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) it425
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) it425
    3) it588
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) it425
    3) it588
    4) it589
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) it425
    3) it589
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) it425
    3) it589
    4) (exp it15 2)
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) it425
    3) it589
    4) (exp it588 2)
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) it425
    3) it589
    4) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) it425
    3) (exp it15 2)
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) it425
    3) (exp it588 2)
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) it425
    3) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) it588
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) (exp it15 2)
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) (exp it588 2)
    
  Non linear arithmetic between
    0) it373
    1) it424
    2) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it424
    1) it588
    
  Non linear arithmetic between
    0) it424
    1) (exp it15 2)
    
  Non linear arithmetic between
    0) it424
    1) (exp it588 2)
    
  Non linear arithmetic between
    0) it424
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it588
    1) it589
    
  Non linear arithmetic between
    0) it588
    1) (exp (+ (- 1) (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
            (* (- 2) it373 it424) (* (- 2) it373 it424 it425) (* (- 2) it424)
            (* (- 1) i7) (* 2 it15) (* 2 it190 it425 it589 it81)
            (* 2 it190 it425 it81) (* 2 it190 it81) (* 2 it373 it424)
            (* 2 it373 it424 it425) (* 2 it373 it424 it425 it589) (* 2 it424)) 2)
    
  Non linear arithmetic between
    0) (exp it15 2)
    
  Non linear arithmetic between
    0) (exp it15 3)
    
  Non linear arithmetic between
    0) (exp it588 2)
    
  Non linear arithmetic between
    0) (exp it588 3)
    
  Non linear arithmetic between
    0) (exp it600 2)
    
  Non linear arithmetic between
    0) (exp (+ (- 1) (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
            (* (- 2) it373 it424) (* (- 2) it373 it424 it425) (* (- 2) it424)
            (* (- 1) i7) (* 2 it15) (* 2 it190 it425 it589 it81)
            (* 2 it190 it425 it81) (* 2 it190 it81) (* 2 it373 it424)
            (* 2 it373 it424 it425) (* 2 it373 it424 it425 it589) (* 2 it424)) 2)
    
  Non linear arithmetic between
    0) (exp (+ (- 1) (* (- 2) it190 it425 it81) (* (- 2) it190 it81)
            (* (- 2) it373 it424) (* (- 2) it373 it424 it425) (* (- 2) it424)
            (* (- 1) i7) (* 2 it190 it425 it589 it81) (* 2 it190 it425 it81)
            (* 2 it190 it81) (* 2 it373 it424) (* 2 it373 it424 it425)
            (* 2 it373 it424 it425 it589) (* 2 it424)) 2)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
