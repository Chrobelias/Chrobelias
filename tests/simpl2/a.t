  $ CHRO_DEBUG=simpl Chro --dsimpl --stop-after pre-simpl test1.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ 14 (* (- 5) x) (* (- 8) %stdexp2) (* (- 7) z)) 0)
             (= (+ (- 52) z y) 0)
             (<= (+ (- 13) (* (- 5) x)) 0)
             (<= (* (- 1) y) 0)
             (= (+ %stdexp1 (* (- 1) y)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp1 -> y;
        %stdexp2 -> (** 2 %stdexp1);
        y -> (+ 52 (- z));
        
  [+simpl]
    iter(2)= (and
             (= (+ (- 52) y z) 0)
             (= (+ %stdexp1 (* (- 1) y)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (<= (+ (- 13) (* (- 5) x)) 0)
             (<= (+ 14 (* (- 5) x) (* (- 8) %stdexp2) (* (- 7) z)) 0)
             (<= (* (- 1) y) 0))
  [+simpl]
    iter(3)= (and
             (= (+ (* 52 (- 1)) y (* (* (- 1) z) (- 1))) 0)
             (= (+ (** 2 %stdexp1) (* (- 1) (** 2 y))) 0)
             (<= (+ (- 13) (* (- 5) x)) 0)
             (<= (+ 14 (* (- 5) x) (* (- 7) z) (* (- 8) (** 2 %stdexp1))) 0)
             (<= (+ (* 52 (- 1)) (* (* (- 1) z) (- 1))) 0))
  [+simpl]
    iter(4)= (and
             (= (+ (** 2 y) (* (- 1) (** 2 (+ 52 (* (- 1) z))))) 0)
             (<= (+ (- 52) z) 0)
             (<= (+ (- 13) (* (- 5) x)) 0)
             (<= (+ 14 (* (- 5) x) (* (- 7) z) (* (- 8) (** 2 y))) 0))
  [+simpl]
    iter(5)= (and
             (<= (+ (- 52) z) 0)
             (<= (+ (- 13) (* (- 5) x)) 0)
             (<= (+ 14 (* (- 5) x) (* (- 7) z)
                 (* (- 8) (** 2 (+ 52 (* (- 1) z))))) 0))
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ 14 (* (- 5) x) (* (- 8) %stdexp2) (* (- 7) z)) 0)
             (= (+ (- 52) z y) 0)
             (<= (+ (- 13) (* (- 5) x)) 0)
             (<= (* (- 1) y) 0)
             (= (+ %stdexp1 (* (- 1) y)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp1 -> y;
        %stdexp2 -> (** 2 %stdexp1);
        y -> (+ 52 (- z));
        
  [+simpl]
    iter(2)= (and
             (= (+ (- 52) y z) 0)
             (= (+ %stdexp1 (* (- 1) y)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (<= (+ (- 13) (* (- 5) x)) 0)
             (<= (+ 14 (* (- 5) x) (* (- 8) %stdexp2) (* (- 7) z)) 0)
             (<= (* (- 1) y) 0))
  [+simpl]
    iter(3)= (and
             (= (+ (* 52 (- 1)) y (* (* (- 1) z) (- 1))) 0)
             (= (+ (** 2 %stdexp1) (* (- 1) (** 2 y))) 0)
             (<= (+ (- 13) (* (- 5) x)) 0)
             (<= (+ 14 (* (- 5) x) (* (- 7) z) (* (- 8) (** 2 %stdexp1))) 0)
             (<= (+ (* 52 (- 1)) (* (* (- 1) z) (- 1))) 0))
  [+simpl]
    iter(4)= (and
             (= (+ (** 2 y) (* (- 1) (** 2 (+ 52 (* (- 1) z))))) 0)
             (<= (+ (- 52) z) 0)
             (<= (+ (- 13) (* (- 5) x)) 0)
             (<= (+ 14 (* (- 5) x) (* (- 7) z) (* (- 8) (** 2 y))) 0))
  [+simpl]
    iter(5)= (and
             (<= (+ (- 52) z) 0)
             (<= (+ (- 13) (* (- 5) x)) 0)
             (<= (+ 14 (* (- 5) x) (* (- 7) z)
                 (* (- 8) (** 2 (+ 52 (* (- 1) z))))) 0))
  [+simpl]
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
  $ cat > sum_join1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun n () Int)
  > (assert (= (+ (* n (** 2 n)) ;(* x (** 2 n))
  >               (* (- 1) n (** 2 n))
  >               )
  >            0))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro -no-over -bound 0  --dsimpl --stop-after pre-simpl sum_join1.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ (* n %stdexp2) (* (- 1) %stdexp2 n)) 0)
             (<= (* (- 1) n) 0)
             (= (+ %stdexp1 (* (- 1) n)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp1 -> n;
        %stdexp2 -> (** 2 %stdexp1);
        
  [+simpl]
    iter(2)= (and
             (= (+ %stdexp1 (* (- 1) n)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (<= (* (- 1) n) 0))
  [+simpl]
    iter(3)= (and
             (= (+ (** 2 %stdexp1) (* (- 1) (** 2 n))) 0)
             (<= (* (- 1) n) 0))
  [+simpl]
    iter(4)= (<= (* (- 1) n) 0)
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ (* n %stdexp2) (* (- 1) %stdexp2 n)) 0)
             (<= (* (- 1) n) 0)
             (= (+ %stdexp1 (* (- 1) n)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp1 -> n;
        %stdexp2 -> (** 2 %stdexp1);
        
  [+simpl]
    iter(2)= (and
             (= (+ %stdexp1 (* (- 1) n)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (<= (* (- 1) n) 0))
  [+simpl]
    iter(3)= (and
             (= (+ (** 2 %stdexp1) (* (- 1) (** 2 n))) 0)
             (<= (* (- 1) n) 0))
  [+simpl]
    iter(4)= (<= (* (- 1) n) 0)
  [+simpl]
    fixed-point
  
  $ cat > sum_join2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun n () Int)
  > (assert (not (= (+ (* (- 1) (** 2 n)) (** 2 n)) 0)) )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro -no-over -bound 0  --dsimpl --stop-after pre-simpl sum_join2.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (distinct (+ (* (- 1) %stdexp2) %stdexp2) 0)
             (<= (* (- 1) n) 0)
             (= (+ %stdexp1 (* (- 1) n)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (not True)
  [+simpl]
    fixed-point
  
  [+simpl]
    contradicting clause: (distinct (+ (* (- 1) %stdexp2) %stdexp2) 0)
  [+simpl]
    contradicting env:  
  [+simpl]
    unsat core: (distinct (+ (* (- 1) %stdexp2) %stdexp2) 0)
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (distinct (+ (* (- 1) %stdexp2) %stdexp2) 0)
             (<= (+ 1 n) 0)
             (= %stdexp2 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (not True)
  [+simpl]
    fixed-point
  
  [+simpl]
    contradicting clause: (distinct (+ (* (- 1) %stdexp2) %stdexp2) 0)
  [+simpl]
    contradicting env:  
  [+simpl]
    unsat core: (distinct (+ (* (- 1) %stdexp2) %stdexp2) 0)
  
  unsat (presimpl int)
