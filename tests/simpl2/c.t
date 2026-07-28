  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= (+ it2 (* (- 1) i2)) 2) )
  > (assert (= (* (- 2) z) 0) )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro -no-over -bound 0 --dsimpl --stop-after pre-simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (* (- 2) z) 0)
             (= (+ (- 2) it2 (* (- 1) i2)) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        it2 -> (+ 2 i2);
        z -> 0;
  
  [+simpl]
    iter(2)= (and
             (= (+ (- 2) (* (- 1) i2) it2) 0)
             (= (* (- 2) z) 0))
  [+simpl]
    iter(3)= True
  [+simpl]
    fixed-point
  
  sat (presimpl int)
