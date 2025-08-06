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
  $ Chro -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (it159 [691769754]) (= (+ it159 (* (- 4) [691769754]) )  0)
  )

  $ export CHRO_EIA=old
  $ Chro -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (it159) (= (+ it159 (* (- 2) pow2(691769754)) )  0)  )
  (assert (exists (it147) (= (+ it147 (* (- 1) [691769754]) )  -1)  )

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
  $ unset CHRO_EIA=
  $ Chro -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'

  $ Chro -dsimpl -stop-after simpl ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/heapsort.c.koat_2.smt2
  $ export CHRO_EIA=old
  $ Chro -dsimpl -stop-after simpl ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/heapsort.c.koat_2.smt2
