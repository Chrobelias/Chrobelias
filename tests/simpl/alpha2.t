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
  (assert (not (exists (x0 x1) (= (+ (* (- 1) P) (* 199 x0) (* 211 x1) )  0) )
          ))
  (assert (not (exists (R) (not T)) ))
  (assert (= (+ (* (- 1) P) (* (- 1) Q) )  -101) )
  (assert (<= (* (- 1) x1)  0) )
  (assert (<= (* (- 1) x0)  0) )
  (assert (<= (* (- 1) P)  0) )
  
