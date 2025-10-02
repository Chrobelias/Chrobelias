TODO(Kakadu)
This test doesn't simplify (not True)
  $ export CHRO_DEBUG=1
  $ Chro -pre-simpl -dsimpl koat83mini.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
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
  Something ready to substitute:  it418 -> (* (- 1) it388 (* (- 1) 1));
  iter(2)= (not True)
  unsat
