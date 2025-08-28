TODO(Kakadu)
This test doesn't simplify (not True)
  $ export CHRO_DEBUG=1
  $ Chro -pre-simpl -dsimpl koat83mini.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (and
               (= 1 0)
               (<= 0 (+ (* it413 (* (- 1) 1)) 3))
               (<= (+ 0 1) (+ it416 it417))
               (<= 0 (+ it413 (* (- 1) 3))))
             (= (+ it418 (* it388 (* (- 1) 1))) 0)
             (and
               (<= 0 (+ (* it1 (* (- 1) 1)) 2))
               (<= 0 (+ it117 (* (- 1) 1)))
               (<= (+ 0 1) (+ (+ (+ (+ (* (+ it117 (* (- 1) 1)) it13
                                       (* (- 1) 2))
                                    it3)
                                 (* it13 (* (- 1) 2)))
                              (* (+ it117 (* (- 1) 1)) it92 (* (- 1) 2)))
                           2))
               (<= (+ 0 1) (+ (+ it3 (* it13 (* (- 1) 2))) 1))
               (<= 0 (+ it92 (* (- 1) 1)))))
  iteration 2
  ast(2) = (and
             (= (+ it418 (* (- 1) it388)) 0)
             (<= it1 2)
             (<= it413 3)
             (<= (+ (* (- 1) it3) (* 2 it13)) 0)
             (<= (+ (* (- 1) it3) (* 2 it13) (* 2 it13 (+ (- 1) it117))
                 (* 2 it92 (+ (- 1) it117))) 1)
             (<= (+ (* (- 1) it416) (* (- 1) it417)) (- 1))
             (<= (* (- 1) it117) (- 1))
             (<= (* (- 1) it413) (- 3))
             (<= (* (- 1) it92) (- 1))
             (not True))
  Something ready to substitute:  it418 -> it388;
  iteration 3
  ast(3) = (and
             (= (+ it418 (* (- 1) it388)) 0)
             (<= it1 2)
             (<= it413 3)
             (<= (+ (* (- 1) it3) (* 2 it13)) 0)
             (<= (+ (* (- 1) it3) (* 2 it13) (* 2 it13 (+ (- 1) it117))
                 (* 2 it92 (+ (- 1) it117))) 1)
             (<= (+ (* (- 1) it416) (* (- 1) it417)) (- 1))
             (<= (* (- 1) it117) (- 1))
             (<= (* (- 1) it413) (- 3))
             (<= (* (- 1) it92) (- 1))
             (not True))
  iteration 4
  ast(4) = (and
             (<= it1 2)
             (<= it413 3)
             (<= (+ (* (- 1) it3) (* 2 it13)) 0)
             (<= (+ (* (- 1) it3) (* 2 it13) (* 2 it13 (+ (- 1) it117))
                 (* 2 it92 (+ (- 1) it117))) 1)
             (<= (+ (* (- 1) it416) (* (- 1) it417)) (- 1))
             (<= (* (- 1) it117) (- 1))
             (<= (* (- 1) it413) (- 3))
             (<= (* (- 1) it92) (- 1))
             (not True))
  Fixpoint after 4 steps
  Error after simplification.
    Non linear arithmetic between
      0) it13
      1) (+ (- 1) it117)
  
    Non linear arithmetic between
      0) it92
      1) (+ (- 1) it117)
  
  Leftover formula:
  (and
                      (<= it1 2)
                      (<= it413 3)
                      (<= (+ (* (- 1) it3) (* 2 it13)) 0)
                      (<= (+ (* (- 1) it3) (* 2 it13)
                          (* 2 it13 (+ (- 1) it117))
                          (* 2 it92 (+ (- 1) it117))) 1)
                      (<= (+ (* (- 1) it416) (* (- 1) it417)) (- 1))
                      (<= (* (- 1) it117) (- 1))
                      (<= (* (- 1) it413) (- 3))
                      (<= (* (- 1) it92) (- 1))
                      (not True))
