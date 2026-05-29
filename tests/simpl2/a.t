  $ CHRO_DEBUG=1 Chro --dsimpl --stop-after pre-simpl test1.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (<= (+ 14 (* (- 5) x) (* (- 8) (exp 2 y)) (* (- 7) z)) 0)
             (= (+ (- 52) z y) 0)
             (<= (+ (- 13) (* (- 5) x)) 0))
  Alphabet with extra char: 0
  
  iter(2)= (and
             (= (+ (- 52) y z) 0)
             (<= (+ (- 13) (* (- 5) x)) 0)
             (<= (+ 14 (* (- 5) x) (* (- 7) z) (* (- 8) (exp 2 y))) 0))
  fixed-point
  

  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (<= (* x (- 0 5)) 13))
  > (assert (= (+ z y) 52))
  > (assert (> (+ (* x 5) (* (pow2 y) 8) (* z 7) ) 13))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over -bound 0  --dsimpl --stop-after pre-simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (<= (+ 14 (* (- 5) x) (* (- 8) (exp 2 y)) (* (- 7) z)) 0)
             (= (+ (- 52) z y) 0)
             (<= (+ (- 13) (* (- 5) x)) 0))
  Alphabet with extra char: 0
  
  iter(2)= (and
             (= (+ (- 52) y z) 0)
             (<= (+ (- 13) (* (- 5) x)) 0)
             (<= (+ 14 (* (- 5) x) (* (- 7) z) (* (- 8) (exp 2 y))) 0))
  fixed-point
  
  $ cat > sum_join1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (+ (* n (exp 2 n)) ;(* x (exp 2 n))
  >               (* (- 1) n (exp 2 n))
  >               )
  >            0))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over -bound 0  --dsimpl --stop-after pre-simpl sum_join1.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (= (+ (* n (exp 2 n)) (* (- 1) (exp 2 n) n)) 0)
  Alphabet with extra char: 0
  
  iter(2)= True
  fixed-point
  
  sat (presimpl int)
  $ cat > sum_join2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun n () Int)
  > (assert (not (= (+ (* (- 1) (exp 2 n)) (exp 2 n)) 0)) )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over -bound 0  --dsimpl --stop-after pre-simpl sum_join2.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (distinct (+ (* (- 1) (exp 2 n)) (exp 2 n)) 0)
  Alphabet with extra char: 0
  
  iter(2)= (not True)
  fixed-point
  
  unsat (presimpl int)
