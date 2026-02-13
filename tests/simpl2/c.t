  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= (+ it2 (* (- 1) i2)) 2) )
  > (assert (= (* (- 2) z) 0) )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over -bound 0 --dsimpl --stop-after pre-simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (= (* (* (- 1) 2) z) 0)
             (= (+ it2 (* (* (- 1) 1) i2)) 2))
  Something ready to substitute
        it2 -> (+ 2 i2);
  
  iter(2)= (= (* (- 2) z) 0)
  Something ready to substitute
        it2 -> (+ 2 i2);
        z -> 0;
  
  iter(3)= True
  fixed-point
  
  sat (presimpl int)
