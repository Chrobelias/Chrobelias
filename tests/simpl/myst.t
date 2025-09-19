$ export CHRO_DEBUG=1
  $ Chro -bound 0 -no-pre-simpl -dsimpl -stop-after simpl ../../benchmarks/MysteriousProgram.jar-obl-12.smt2_9.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (it179)
          (and
            (<= (* (- 1) it179)  -1)
            (<= (* (- 1) it192)  -1)
            (<= (* (- 1) it179)  0)
            (<= (+ (* (- 1) it179) it192 )  0)
            (exists (i1) (= i1  13) )
            (exists (it11 it200) (= (+ (* (- 1) it11) it200 )  0) )
            (exists (it16 it210) (= (+ (* (- 1) it16) it210 )  0) )
            (exists (it17 it209) (= (+ (* (- 1) it17) it209 )  0) )
            (exists (it178) (= it178  0) )
            (exists (it205)
            (and
              (<= (* (- 1) it205)  -3)
              (<= it205  3)
              (= it205  3)
              )
            (exists (it175)
            (and
              (<= (* (- 1) it175)  -2)
              (<= it175  2)
              (= it175  2)
              )
            (exists (it177) (and
                              (<= (* (- 1) it177)  -2)
                              (= it177  2)
                              )
            (exists (it208)
            (and
              (<= (* (- 1) it208)  -1)
              (<= (* (- 1) it208)  0)
              (exists (it223)
              (and
                (<= (* (- 1) it223)  -1)
                (<= (+ (* (- 1) it208) it223 )  0)
                )
              (exists (it197)
              (and
                (<= (* (- 1) it197)  0)
                (= (+ (* (- 1) it197) it208 )  0)
                (= (+ it197 (* (- 2) pow2(it192)) )  0)
                )
              )
            (exists (it206)
            (and
              (<= (* (- 1) it206)  -1)
              (exists (it25)
              (and
                (<= (* (- 1) it25)  -1)
                (<= (+ (* (- 1) it206) it25 )  0)
                )
              (exists (it20)
              (and
                (<= (* (- 1) it20)  -1)
                (= (+ (* (- 1) it20) it206 )  0)
                (exists (it196)
                (and
                  (<= (* (- 1) it196)  -1)
                  (<= (+ (* (- 1) it196) it20 )  0)
                  (exists (it176)
                  (and
                    (<= (* (- 1) it176)  -1)
                    (exists (it15)
                    (and
                      (<= (* (- 1) it15)  -1)
                      (<= (+ it15 (* (- 1) it176) )  0)
                      (= (+ (* (- 1) it15) it196 )  0)
                      )
                    (exists (it10)
                    (and
                      (<= (* (- 1) it10)  -1)
                      (= (+ (* (- 1) it10) it176 )  0)
                      )
                    )
                  )
                )
              )
            (exists (it144)
            (and
              (<= (* (- 1) it144)  0)
              (= (+ (* (- 1) it144) it179 )  0)
              )
            (exists (it180 it6) (= (+ it180 (* (- 1) it6) )  0) )
            (exists (it195) (= it195  2) )
            (exists (it207) (and
                              (<= (* (- 1) it207)  0)
                              (= it207  0)
                              )
            (exists (it199)
            (and
              (= (+ (* (- 1) it179) it199 )  0)
              (exists (it198)
              (and
                (<= (+ (* (- 1) it198) it199 )  0)
                (= (+ (* (- 1) it192) it198 )  0)
                )
              )
            )
  )
