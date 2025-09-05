  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= (exp x 2) 32))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -bound 1 -pre-simpl -dsimpl -stop-after pre-simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (exp x 2) 32))
  iter(2)= (= (exp x 2) 32)
  iter(2.0)= (= (exp x 2) 32)
  1 errors found
  Non linear arithmetic between
    0) (exp x 2)
  
  Leftover formula:
  (and
                      (= (exp x 2) 32))
  Non linear arithmetic between
    0) (exp x 2)
  
  UNKNOWN (Errors after simplification)
