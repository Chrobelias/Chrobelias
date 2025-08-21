$ export CHRO_DEBUG=1
  $ Chro -bound 0 -dsimpl -stop-after simpl ../../benchmarks/MysteriousProgram.jar-obl-12.smt2_9.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (it199 it208 it198)
          (and
            (<= (* (- 1) it192)  -1)
            (<= (* (- 1) it199)  -1)
            (<= (* (- 1) it208)  -1)
            (<= (+ it192 (* (- 1) it199) )  0)
            (<= (+ (* (- 1) it198) it199 )  0)
            (= (+ (* (- 1) it192) it198 )  0)
            (= (+ it208 (* (- 2) pow2(it192)) )  0)
            )
  )
