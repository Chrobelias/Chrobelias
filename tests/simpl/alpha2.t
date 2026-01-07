  $ cat > testA2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun P () Int)
  > (declare-fun Q () Int)
  > (assert (= 101 (+ P Q)))
  > (assert (and
  >   (<= 0 P)
  >   (forall ((x0 Int) (x1 Int))
  >     (=> (and (<= 0 x0) (<= 0 x1)) (not (= (+ (* x0 199) (* x1 211)) P))))
  >   (forall ((R Int)) (=> (forall ((x0 Int) (x1 Int)) (=> (and (<= 0 x0) (<= 0 x1)) (not (= (+ (* x0 199) (* x1 211)) R)))) (<= R P)))))
  > (check-sat)
  > EOF
  $ export OCAMLRUNPARAM='b=0'
$ export CHRO_DEBUG=1

  $ unset CHRO_EIA=
  $ timeout 2 Chro -bound -1 -no-over --dsimpl --stop-after simpl testA2.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (P)
          (and
            (exists (Q) (= (+ (* (- 1) P) (* (- 1) Q) )  -101) )
            (<= (* (- 1) P)  0)
            (not (exists (x1)
                 (and
                   (exists (x0)
                   (and
                     (<= (* (- 1) x0)  0)
                     (= (+ (* (- 1) P) (* 199 x0) (* 211 x1) )  0)
                     )
  
                   (<= (* (- 1) x1)  0)
                   )
            )
            (not (exists (R)
                 (and
                   (not (exists (x1)
                        (and
                          (exists (x0)
                          (and
                            (<= (* (- 1) x0)  0)
                            (= (+ (* (- 1) R) (* 199 x0) (* 211 x1) )  0)
                            )
  
                          (<= (* (- 1) x1)  0)
                          )
                   )
                   (not (<= (+ (* (- 1) P) R )  0) )
                   )
            )
            )
  )
