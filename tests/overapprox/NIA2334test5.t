
  $ export CHRO_DEBUG=1
  $ export CHRO_TRACE_OPT=1
  $ export OCAMLRUNPARAM="b=0"
  $ Chro --dsimpl --stop-after simpl ../overapprox/NIA2334test5.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (<= (+ (+ (+ (+ (+ 0 (* (* (- 1) 69958) x1))
                          (* (* (- 1) 73696) x2))
                       (* 55275 x3))
                    (* (* (- 1) 38784) x4))
                 (* (* (- 1) 54064) x5)) (* (- 1) 717))
             (<= (+ (+ (+ (+ (+ 0 (* (* (- 1) 77280) x1)) (* 12387 x2))
                       (* (* (- 1) 26192) x3))
                    (* (* (- 1) 4662) x4))
                 (* 5594 x5)) 88727)
             (<= (+ (+ (+ (+ (+ 0 (* 86806 x1)) (* 95727 x2))
                       (* (* (- 1) 41491) x3))
                    (* 52186 x4))
                 (* 85893 x5)) (* (- 1) 55013))
             (<= (+ (+ (+ (+ (+ 0 (* (* (- 1) 94087) x1))
                          (* (* (- 1) 88353) x2))
                       (* (* (- 1) 83347) x3))
                    (* (* (- 1) 75426) x4))
                 (* 27609 x5)) (* (- 1) 3046))
             (<= (+ (+ (+ (+ (+ (+ (+ 0 (* (* (- 1) 96) (exp 2 x1)))
                                (* 40 (exp 2 x2)))
                             (* 75146 x1))
                          (* (* (- 1) 33357) x2))
                       (* (* (- 1) 55318) x3))
                    (* 16322 x4))
                 (* (* (- 1) 42327) x5)) (* (- 1) 54594))
             (<= (+ (+ (+ (+ (+ (+ (+ 0 (* 38 (exp 2 x1)))
                                (* (* (- 1) 69) (exp 2 x2)))
                             (* 70809 x1))
                          (* 77330 x2))
                       (* 91984 x3))
                    (* 4945 x4))
                 (* 52371 x5)) (* (- 1) 55034))
             (<= (+ (+ (+ (+ (+ (+ (+ 0 (* (* (- 1) 73) (exp 2 x1)))
                                (* 5 (exp 2 x2)))
                             (* (* (- 1) 11652) x1))
                          (* 91714 x2))
                       (* 75317 x3))
                    (* 87603 x4))
                 (* (* (- 1) 53824) x5)) 66490)
             (<= 0 x5)
             (<= 0 x4)
             (<= 0 x3)
             (<= 0 x2)
             (<= 0 x1))
  iter(2)= (and
             (<= 0 x1)
             (<= 0 x2)
             (<= 0 x3)
             (<= 0 x4)
             (<= 0 x5)
             (<= (+ (* (- 94087) x1) (* (- 88353) x2) (* (- 83347) x3)
                 (* (- 75426) x4) (* 27609 x5)) (- 3046))
             (<= (+ (* (- 77280) x1) (* (- 26192) x3) (* (- 4662) x4)
                 (* 5594 x5) (* 12387 x2)) 88727)
             (<= (+ (* (- 73696) x2) (* (- 69958) x1) (* (- 54064) x5)
                 (* (- 38784) x4) (* 55275 x3)) (- 717))
             (<= (+ (* (- 55318) x3) (* (- 42327) x5) (* (- 33357) x2)
                 (* (- 96) (exp 2 x1)) (* 40 (exp 2 x2)) (* 16322 x4)
                 (* 75146 x1)) (- 54594))
             (<= (+ (* (- 53824) x5) (* (- 11652) x1) (* (- 73) (exp 2 x1))
                 (* 5 (exp 2 x2)) (* 75317 x3) (* 87603 x4) (* 91714 x2)) 66490)
             (<= (+ (* (- 41491) x3) (* 52186 x4) (* 85893 x5) (* 86806 x1)
                 (* 95727 x2)) (- 55013))
             (<= (+ (* (- 69) (exp 2 x2)) (* 38 (exp 2 x1)) (* 4945 x4)
                 (* 52371 x5) (* 70809 x1) (* 77330 x2) (* 91984 x3)) (- 55034)))
  fixed-point
  
  Bound for underapproximation: 18
  
  Interesting: x1 x2
  
  Expecting 324 choices ...
  
  Can't decide in lib/Underapprox.ml
  whole: (bool.and
          (bool.and
           (bool.and
            (bool.and
             (bool.and
              (bool.and
               (bool.and
                (bool.and
                 (bool.and
                  (bool.and (bool.and (int.le_s 0 x1) (int.le_s 0 x2))
                   (int.le_s 0 x3)) (int.le_s 0 x4)) (int.le_s 0 x5))
                (int.le_s
                 (int.add
                  (int.add
                   (int.add (int.add (int.mul -94087 x1) (int.mul -88353 x2))
                    (int.mul -83347 x3)) (int.mul -75426 x4))
                  (int.mul 27609 x5)) -3046))
               (int.le_s
                (int.add
                 (int.add
                  (int.add (int.add (int.mul -77280 x1) (int.mul -26192 x3))
                   (int.mul -4662 x4)) (int.mul 5594 x5)) (int.mul 12387 x2))
                88727))
              (int.le_s
               (int.add
                (int.add
                 (int.add (int.add (int.mul -73696 x2) (int.mul -69958 x1))
                  (int.mul -54064 x5)) (int.mul -38784 x4)) (int.mul 55275 x3))
               -717))
             (int.le_s
              (int.add
               (int.add
                (int.add
                 (int.add
                  (int.add (int.add (int.mul -55318 x3) (int.mul -42327 x5))
                   (int.mul -33357 x2)) (int.mul -96 exp_2_x1))
                 (int.mul 40 exp_2_x2)) (int.mul 16322 x4)) (int.mul 75146 x1))
              -54594))
            (int.le_s
             (int.add
              (int.add
               (int.add
                (int.add
                 (int.add (int.add (int.mul -53824 x5) (int.mul -11652 x1))
                  (int.mul -73 exp_2_x1)) (int.mul 5 exp_2_x2))
                (int.mul 75317 x3)) (int.mul 87603 x4)) (int.mul 91714 x2))
             66490))
           (int.le_s
            (int.add
             (int.add
              (int.add (int.add (int.mul -41491 x3) (int.mul 52186 x4))
               (int.mul 85893 x5)) (int.mul 86806 x1)) (int.mul 95727 x2))
            -55013))
          (int.le_s
           (int.add
            (int.add
             (int.add
              (int.add
               (int.add (int.add (int.mul -69 exp_2_x2) (int.mul 38 exp_2_x1))
                (int.mul 4945 x4)) (int.mul 52371 x5)) (int.mul 70809 x1))
             (int.mul 77330 x2)) (int.mul 91984 x3)) -55034))
         (int.lt_s (int.mul 1 x1) exp_2_x1)
         (int.lt_s (int.mul 1 x2) exp_2_x2)
  
  Early Unsat in lib/Overapprox.ml
  unsat (over)
