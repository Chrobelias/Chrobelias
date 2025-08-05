  $ cat > test.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it11 () Int)
  > (declare-fun it147 () Int)
  > (declare-fun it159 () Int)
  > (assert (let ((a!1 (+ (* it11 (exp 2 it147) (- 2))
  >                      it159
  >                      (* (exp 2 it147) (- 2))
  >                      1)))
  >   (= a!1 0)))
  > (check-sat)
  > EOF
  $ export OCAMLRUNPARAM='b=0'
  $ Chro -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  Lib__Me.of_eia.of_term fails on '(* -2 * it11 * (2 ** it147))'
  Fatal error: exception Failure("unimplemented: (+ 1 + (* -2 * it11 * (2 ** it147)) + it159 + (* -2 * (2 ** it147))) = 0")

$ Chro -dsimpl -stop-after simpl ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/heapsort.c.koat_2.smt2
