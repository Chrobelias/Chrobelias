  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= (exp x 2) 32))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -bound 1 --pre-simpl --dsimpl --stop-after pre-simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (exp x 2) 32))
  iter(2)= (= (exp x 2) 32)
  Interesting:
  
  Expecting 1 choices ...
  
  Can't decide in lib/Underapprox.ml
  
  Non linear arithmetic between
  
  0) (exp x 2)
  
  
  
  Into Z3 goes: (bool.eq (int.pow x 2) 32)
  
  unsat (non-linear)
