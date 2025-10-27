  $ cat > test.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it11 () Int)
  > (declare-fun it147 () Int)
  > (declare-fun it159 () Int)
  > (assert
  >   (= (+ it159
  >         (* (exp 2 (+ 1 it147)) (- 2))
  >         )
  >      0))
  > (check-sat)
  > EOF
$ export OCAMLRUNPARAM='b=0'
$ export CHRO_DEBUG=1

  $ unset CHRO_EIA=
  $ timeout 2 Chro -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  sat (presimpl)

  $ export CHRO_EIA=old
  $ timeout 2 Chro -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  sat (presimpl)







  $ cat > test.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it1 () Int)
  > (declare-fun it2 () Int)
  > (assert
  >   (= (+ it1
  >         (* (exp 2 (- it2 1)) 7)
  >         )
  >      15))
  > (check-sat)
  > EOF
$ export CHRO_DEBUG=1
  $ unset CHRO_EIA
  $ Chro -bound 0 -dsimpl -stop-after simpl test.smt2 || echo TIMEOUT | sed 's/[[:space:]]*$//'
  (assert (exists (it1) (= (+ (* 2 it1) (* 7 pow2(it2)) )  30) )
  )

$ export CHRO_DEBUG=1
  $ Chro -bound 0  -no-pre-simpl -dsimpl -stop-after simpl ../../benchmarks/heapsort.c.koat_2.smt2 | sed 's/[[:space:]]*$//'
  unknown (nfa; unimplemented (* (+ 0 it11) (exp 2 (+ it147 (* (- 1) 1))) (+ 0 (* (- 1) 2))))

  $ unset CHRO_DEBUG
  $ export CHRO_EIA=old
  $ Chro -bound 0 -no-pre-simpl -dsimpl -stop-after simpl ../../benchmarks/heapsort.c.koat_2.smt2
  unknown (nfa; unimplemented (* (+ 0 it11) (exp 2 (+ it147 (* (- 1) 1))) (+ 0 (* (- 1) 2))))

Run solver
  $ unset CHRO_EIA
  $ timeout 2  Chro  -no-pre-simpl ../../benchmarks/heapsort.c.koat_2.smt2
  sat (under I)

