  $ cat > test.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (<= (exp 2  x) x))
  > (check-sat)
  > EOF
  $ export CHRO_DEBUG=1
  $ Chro -over-approx -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  whole: (bool.and (int.le_s exp_2_1 x) (int.lt_s x exp_2_1))
  
  Early Unsat in lib/Overapprox.ml
  unsat
