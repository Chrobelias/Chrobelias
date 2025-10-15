  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= (+ it2 (* (- 1) i2)) 2) )
  > (assert (= (* (- 2) z) 0) )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over-approx -bound 0 -pre-simpl -dsimpl -stop-after pre-simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (* (* (- 1) 2) z) 0)
             (= (+ it2 (* (* (- 1) 1) i2)) 2))
  Something ready to substitute:  it2 -> (+ 2 i2); z -> 0;
  iter(2)= (and
             (= (+ it2 (* (- 1) i2)) 2)
             (= (* (- 2) z) 0))
  iter(3)= True
  sat ; presimpl
