  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= (exp x 2) 32))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -bound 1 --pre-simpl --dsimpl --stop-after pre-simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (= (exp x 2) 32)
  Interesting:
  
  Expecting 1 choices ...
  
  unsat (nia)
