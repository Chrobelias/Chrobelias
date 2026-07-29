  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= (+ x (* (- 1) y)) 2) )
  > (assert (= (* (- 2) z) 0) )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro -no-over -bound 0 --dsimpl --stop-after pre-simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (* (- 2) z) 0)
             (= (+ (- 2) x (* (- 1) y)) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        x -> (+ 2 y);
        z -> 0;
  
  [+simpl]
    iter(2)= (and
             (= (+ (- 2) x (* (- 1) y)) 0)
             (= (* (- 2) z) 0))
  [+simpl]
    iter(3)= True
  [+simpl]
    fixed-point
  
  sat (presimpl int)
