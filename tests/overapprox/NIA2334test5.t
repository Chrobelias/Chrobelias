  $ export CHRO_DEBUG=simpl:over
  $ export CHRO_TRACE_OPT=1
  $ export OCAMLRUNPARAM="b=0"
  $ Chro --dsimpl --stop-after simpl ../overapprox/NIA2334test5.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ 717 (* (- 69958) x1) (* (- 73696) x2) (* 55275 x3)
                 (* (- 38784) x4) (* (- 54064) x5)) 0)
             (<= (+ (- 88727) (* (- 77280) x1) (* 12387 x2) (* (- 26192) x3)
                 (* (- 4662) x4) (* 5594 x5)) 0)
             (<= (+ 55013 (* 86806 x1) (* 95727 x2) (* (- 41491) x3)
                 (* 52186 x4) (* 85893 x5)) 0)
             (<= (+ 3046 (* (- 94087) x1) (* (- 88353) x2) (* (- 83347) x3)
                 (* (- 75426) x4) (* 27609 x5)) 0)
             (<= (+ 54594 (* (- 96) (** 2 x1)) (* 40 (** 2 x2)) (* 75146 x1)
                 (* (- 33357) x2) (* (- 55318) x3) (* 16322 x4)
                 (* (- 42327) x5)) 0)
             (<= (+ 55034 (* 38 (** 2 x1)) (* (- 69) (** 2 x2)) (* 70809 x1)
                 (* 77330 x2) (* 91984 x3) (* 4945 x4) (* 52371 x5)) 0)
             (<= (+ (- 66490) (* (- 73) (** 2 x1)) (* 5 (** 2 x2))
                 (* (- 11652) x1) (* 91714 x2) (* 75317 x3) (* 87603 x4)
                 (* (- 53824) x5)) 0)
             (<= (* (- 1) x5) 0)
             (<= (* (- 1) x4) 0)
             (<= (* (- 1) x3) 0)
             (<= (* (- 1) x2) 0)
             (<= (* (- 1) x1) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (and
             (<= (+ (- 88727) (* (- 77280) x1) (* 12387 x2) (* (- 26192) x3)
                 (* (- 4662) x4) (* 5594 x5)) 0)
             (<= (+ (- 66490) (* (- 11652) x1) (* 91714 x2) (* 75317 x3)
                 (* 87603 x4) (* (- 53824) x5) (* (- 73) (** 2 x1))
                 (* 5 (** 2 x2))) 0)
             (<= (+ 717 (* (- 69958) x1) (* (- 73696) x2) (* 55275 x3)
                 (* (- 38784) x4) (* (- 54064) x5)) 0)
             (<= (+ 3046 (* (- 94087) x1) (* (- 88353) x2) (* (- 83347) x3)
                 (* (- 75426) x4) (* 27609 x5)) 0)
             (<= (+ 54594 (* 75146 x1) (* (- 33357) x2) (* (- 55318) x3)
                 (* 16322 x4) (* (- 42327) x5) (* (- 96) (** 2 x1))
                 (* 40 (** 2 x2))) 0)
             (<= (+ 55013 (* 86806 x1) (* 95727 x2) (* (- 41491) x3)
                 (* 52186 x4) (* 85893 x5)) 0)
             (<= (+ 55034 (* 70809 x1) (* 77330 x2) (* 91984 x3) (* 4945 x4)
                 (* 52371 x5) (* 38 (** 2 x1)) (* (- 69) (** 2 x2))) 0)
             (<= (* (- 1) x1) 0)
             (<= (* (- 1) x2) 0)
             (<= (* (- 1) x3) 0)
             (<= (* (- 1) x4) 0)
             (<= (* (- 1) x5) 0))
  [+simpl]
    fixed-point
  
  [+over]
    whole: (bool.and
          (bool.and
           (bool.and
            (bool.and
             (bool.and
              (bool.and
               (bool.and
                (bool.and
                 (bool.and
                  (bool.and
                   (bool.and
                    (int.le_s
                     (int.add
                      (int.add
                       (int.add
                        (int.add (int.add -88727 (int.mul -77280 x1))
                         (int.mul 12387 x2)) (int.mul -26192 x3))
                       (int.mul -4662 x4)) (int.mul 5594 x5)) 0)
                    (int.le_s
                     (int.add
                      (int.add
                       (int.add
                        (int.add
                         (int.add
                          (int.add (int.add -66490 (int.mul -11652 x1))
                           (int.mul 91714 x2)) (int.mul 75317 x3))
                         (int.mul 87603 x4)) (int.mul -53824 x5))
                       (int.mul -73 exp_2_x1)) (int.mul 5 exp_2_x2)) 0))
                   (int.le_s
                    (int.add
                     (int.add
                      (int.add
                       (int.add (int.add 717 (int.mul -69958 x1))
                        (int.mul -73696 x2)) (int.mul 55275 x3))
                      (int.mul -38784 x4)) (int.mul -54064 x5)) 0))
                  (int.le_s
                   (int.add
                    (int.add
                     (int.add
                      (int.add (int.add 3046 (int.mul -94087 x1))
                       (int.mul -88353 x2)) (int.mul -83347 x3))
                     (int.mul -75426 x4)) (int.mul 27609 x5)) 0))
                 (int.le_s
                  (int.add
                   (int.add
                    (int.add
                     (int.add
                      (int.add
                       (int.add (int.add 54594 (int.mul 75146 x1))
                        (int.mul -33357 x2)) (int.mul -55318 x3))
                      (int.mul 16322 x4)) (int.mul -42327 x5))
                    (int.mul -96 exp_2_x1)) (int.mul 40 exp_2_x2)) 0))
                (int.le_s
                 (int.add
                  (int.add
                   (int.add
                    (int.add (int.add 55013 (int.mul 86806 x1))
                     (int.mul 95727 x2)) (int.mul -41491 x3))
                   (int.mul 52186 x4)) (int.mul 85893 x5)) 0))
               (int.le_s
                (int.add
                 (int.add
                  (int.add
                   (int.add
                    (int.add
                     (int.add (int.add 55034 (int.mul 70809 x1))
                      (int.mul 77330 x2)) (int.mul 91984 x3))
                    (int.mul 4945 x4)) (int.mul 52371 x5))
                  (int.mul 38 exp_2_x1)) (int.mul -69 exp_2_x2)) 0))
              (int.le_s (int.mul -1 x1) 0)) (int.le_s (int.mul -1 x2) 0))
            (int.le_s (int.mul -1 x3) 0)) (int.le_s (int.mul -1 x4) 0))
          (int.le_s (int.mul -1 x5) 0))
         (int.lt_s (int.mul 1 x1) exp_2_x1)
         (int.lt_s (int.mul 1 x2) exp_2_x2)
  
  [+simpl]
    Basic simplifications:
  
  [+over]
    whole: (bool.and
          (bool.and
           (bool.and
            (bool.and
             (bool.and
              (bool.and
               (bool.and
                (bool.and
                 (bool.and
                  (bool.or
                   (bool.and
                    (bool.and (int.le_s (int.mul -1 x2) 0)
                     (bool.eq (int.add %stdexp2 (int.mul -1 x2)) 0))
                    (bool.or
                     (bool.and
                      (bool.and
                       (bool.and
                        (bool.and (int.le_s (int.mul -1 x1) 0)
                         (bool.eq (int.add %stdexp1 (int.mul -1 x1)) 0))
                        (int.le_s
                         (int.add
                          (int.add
                           (int.add
                            (int.add
                             (int.add
                              (int.add
                               (int.add 54594 (int.mul -96 exp_2_%stdexp1))
                               (int.mul 40 exp_2_%stdexp2)) (int.mul 75146 x1))
                             (int.mul -33357 x2)) (int.mul -55318 x3))
                           (int.mul 16322 x4)) (int.mul -42327 x5)) 0))
                       (int.le_s
                        (int.add
                         (int.add
                          (int.add
                           (int.add
                            (int.add
                             (int.add
                              (int.add 55034 (int.mul 38 exp_2_%stdexp1))
                              (int.mul -69 exp_2_%stdexp2)) (int.mul 70809 x1))
                            (int.mul 77330 x2)) (int.mul 91984 x3))
                          (int.mul 4945 x4)) (int.mul 52371 x5)) 0))
                      (int.le_s
                       (int.add
                        (int.add
                         (int.add
                          (int.add
                           (int.add
                            (int.add
                             (int.add -66490 (int.mul -73 exp_2_%stdexp1))
                             (int.mul 5 exp_2_%stdexp2)) (int.mul -11652 x1))
                           (int.mul 91714 x2)) (int.mul 75317 x3))
                         (int.mul 87603 x4)) (int.mul -53824 x5)) 0))
                     (bool.and
                      (bool.and
                       (bool.and (int.le_s (int.add 1 x1) 0)
                        (int.le_s
                         (int.add
                          (int.add
                           (int.add
                            (int.add
                             (int.add
                              (int.add 54594 (int.mul 40 exp_2_%stdexp2))
                              (int.mul 75146 x1)) (int.mul -33357 x2))
                            (int.mul -55318 x3)) (int.mul 16322 x4))
                          (int.mul -42327 x5)) 0))
                       (int.le_s
                        (int.add
                         (int.add
                          (int.add
                           (int.add
                            (int.add
                             (int.add 55034 (int.mul -69 exp_2_%stdexp2))
                             (int.mul 70809 x1)) (int.mul 77330 x2))
                           (int.mul 91984 x3)) (int.mul 4945 x4))
                         (int.mul 52371 x5)) 0))
                      (int.le_s
                       (int.add
                        (int.add
                         (int.add
                          (int.add
                           (int.add (int.add -66490 (int.mul 5 exp_2_%stdexp2))
                            (int.mul -11652 x1)) (int.mul 91714 x2))
                          (int.mul 75317 x3)) (int.mul 87603 x4))
                        (int.mul -53824 x5)) 0))))
                   (bool.and (int.le_s (int.add 1 x2) 0)
                    (bool.or
                     (bool.and
                      (bool.and
                       (bool.and
                        (bool.and (int.le_s (int.mul -1 x1) 0)
                         (bool.eq (int.add %stdexp1 (int.mul -1 x1)) 0))
                        (int.le_s
                         (int.add
                          (int.add
                           (int.add
                            (int.add
                             (int.add
                              (int.add 54594 (int.mul -96 exp_2_%stdexp1))
                              (int.mul 75146 x1)) (int.mul -33357 x2))
                            (int.mul -55318 x3)) (int.mul 16322 x4))
                          (int.mul -42327 x5)) 0))
                       (int.le_s
                        (int.add
                         (int.add
                          (int.add
                           (int.add
                            (int.add
                             (int.add 55034 (int.mul 38 exp_2_%stdexp1))
                             (int.mul 70809 x1)) (int.mul 77330 x2))
                           (int.mul 91984 x3)) (int.mul 4945 x4))
                         (int.mul 52371 x5)) 0))
                      (int.le_s
                       (int.add
                        (int.add
                         (int.add
                          (int.add
                           (int.add
                            (int.add -66490 (int.mul -73 exp_2_%stdexp1))
                            (int.mul -11652 x1)) (int.mul 91714 x2))
                          (int.mul 75317 x3)) (int.mul 87603 x4))
                        (int.mul -53824 x5)) 0))
                     (bool.and
                      (bool.and
                       (bool.and (int.le_s (int.add 1 x1) 0)
                        (int.le_s
                         (int.add
                          (int.add
                           (int.add
                            (int.add (int.add 54594 (int.mul 75146 x1))
                             (int.mul -33357 x2)) (int.mul -55318 x3))
                           (int.mul 16322 x4)) (int.mul -42327 x5)) 0))
                       (int.le_s
                        (int.add
                         (int.add
                          (int.add
                           (int.add (int.add 55034 (int.mul 70809 x1))
                            (int.mul 77330 x2)) (int.mul 91984 x3))
                          (int.mul 4945 x4)) (int.mul 52371 x5)) 0))
                      (int.le_s
                       (int.add
                        (int.add
                         (int.add
                          (int.add (int.add -66490 (int.mul -11652 x1))
                           (int.mul 91714 x2)) (int.mul 75317 x3))
                         (int.mul 87603 x4)) (int.mul -53824 x5)) 0)))))
                  (int.le_s
                   (int.add
                    (int.add
                     (int.add
                      (int.add (int.add 717 (int.mul -69958 x1))
                       (int.mul -73696 x2)) (int.mul 55275 x3))
                     (int.mul -38784 x4)) (int.mul -54064 x5)) 0))
                 (int.le_s
                  (int.add
                   (int.add
                    (int.add
                     (int.add (int.add -88727 (int.mul -77280 x1))
                      (int.mul 12387 x2)) (int.mul -26192 x3))
                    (int.mul -4662 x4)) (int.mul 5594 x5)) 0))
                (int.le_s
                 (int.add
                  (int.add
                   (int.add
                    (int.add (int.add 55013 (int.mul 86806 x1))
                     (int.mul 95727 x2)) (int.mul -41491 x3))
                   (int.mul 52186 x4)) (int.mul 85893 x5)) 0))
               (int.le_s
                (int.add
                 (int.add
                  (int.add
                   (int.add (int.add 3046 (int.mul -94087 x1))
                    (int.mul -88353 x2)) (int.mul -83347 x3))
                  (int.mul -75426 x4)) (int.mul 27609 x5)) 0))
              (int.le_s (int.mul -1 x5) 0)) (int.le_s (int.mul -1 x4) 0))
            (int.le_s (int.mul -1 x3) 0)) (int.le_s (int.mul -1 x2) 0))
          (int.le_s (int.mul -1 x1) 0))
         (int.lt_s (int.mul 1 %stdexp1) exp_2_%stdexp1)
         (int.lt_s (int.mul 1 %stdexp2) exp_2_%stdexp2)
  
  Early Unsat in lib/Overapprox.ml
  Early Unsat in lib/Overapprox.ml
  unsat (over)
