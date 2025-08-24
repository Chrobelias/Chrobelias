
  $ export CHRO_DEBUG=1
  $ export CHRO_TRACE_OPT=1
  $ export OCAMLRUNPARAM="b=0"
  $ Chro -no-pre-simpl -over-approx -dsimpl -stop-after simpl ../overapprox/NIA2334test5.smt2 | sed 's/[[:space:]]*$//'
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
                        (int.add (int.add 0 (int.mul -69958 x1))
                         (int.mul -73696 x2)) (int.mul 55275 x3))
                       (int.mul -38784 x4)) (int.mul -54064 x5)) -717)
                    (int.le_s
                     (int.add
                      (int.add
                       (int.add
                        (int.add (int.add 0 (int.mul -77280 x1))
                         (int.mul 12387 x2)) (int.mul -26192 x3))
                       (int.mul -4662 x4)) (int.mul 5594 x5)) 88727))
                   (int.le_s
                    (int.add
                     (int.add
                      (int.add
                       (int.add (int.add 0 (int.mul 86806 x1))
                        (int.mul 95727 x2)) (int.mul -41491 x3))
                      (int.mul 52186 x4)) (int.mul 85893 x5)) -55013))
                  (int.le_s
                   (int.add
                    (int.add
                     (int.add
                      (int.add (int.add 0 (int.mul -94087 x1))
                       (int.mul -88353 x2)) (int.mul -83347 x3))
                     (int.mul -75426 x4)) (int.mul 27609 x5)) -3046))
                 (int.le_s
                  (int.add
                   (int.add
                    (int.add
                     (int.add
                      (int.add
                       (int.add (int.add 0 (int.mul -96 exp_2_1))
                        (int.mul 40 exp_2_2)) (int.mul 75146 x1))
                      (int.mul -33357 x2)) (int.mul -55318 x3))
                    (int.mul 16322 x4)) (int.mul -42327 x5)) -54594))
                (int.le_s
                 (int.add
                  (int.add
                   (int.add
                    (int.add
                     (int.add
                      (int.add (int.add 0 (int.mul 38 exp_2_1))
                       (int.mul -69 exp_2_2)) (int.mul 70809 x1))
                     (int.mul 77330 x2)) (int.mul 91984 x3)) (int.mul 4945 x4))
                  (int.mul 52371 x5)) -55034))
               (int.le_s
                (int.add
                 (int.add
                  (int.add
                   (int.add
                    (int.add
                     (int.add (int.add 0 (int.mul -73 exp_2_1))
                      (int.mul 5 exp_2_2)) (int.mul -11652 x1))
                    (int.mul 91714 x2)) (int.mul 75317 x3)) (int.mul 87603 x4))
                 (int.mul -53824 x5)) 66490)) (int.le_s 0 x5)) (int.le_s 0 x4))
            (int.le_s 0 x3)) (int.le_s 0 x2)) (int.le_s 0 x1))
         (int.lt_s x1 exp_2_1)
         (int.lt_s x2 exp_2_2)
  
  Early Unsat in lib/Overapprox.ml
  unsat
