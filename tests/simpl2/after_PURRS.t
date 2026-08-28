  $ export CHRO_DEBUG=simpl
  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun n () Int)
  > (assert (=
  >        (+ (** 2 n) (** 2 n))
  >        (* 2
  >              (+ (** 2 (+ n (- 1)))
  >                 (** 2 (+ n (- 1)))))
  > ))
  > (check-sat)
  > EOF
  $ Chro -bound -1 --dpresimpl --stop-after pre-simpl 1.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ %stdexp2 %stdexp2 (* (- 2) %stdexp4) (* (- 2) %stdexp4)) 0)
             (<= (+ 1 (* (- 1) n)) 0)
             (= (+ 1 %stdexp3 (* (- 1) n)) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (<= (* (- 1) n) 0)
             (= (+ %stdexp1 (* (- 1) n)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp1 -> n;
        %stdexp2 -> (** 2 %stdexp1);
        %stdexp4 -> (** 2 %stdexp3);
        
  [+simpl]
    iter(2)= (and
             (= (+ 1 %stdexp3 (* (- 1) n)) 0)
             (= (+ %stdexp1 (* (- 1) n)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (= (+ (* 2 %stdexp2) (* (- 4) %stdexp4)) 0)
             (<= (+ 1 (* (- 1) n)) 0)
             (<= (* (- 1) n) 0))
  [+simpl]
    iter(3)= (and
             (= (+ 1 %stdexp3 (* (- 1) n)) 0)
             (= (+ (* (- 4) (** 2 %stdexp3)) (* 2 (** 2 %stdexp1))) 0)
             (= (+ (** 2 %stdexp1) (* (- 1) (** 2 n))) 0)
             (<= (+ 1 (* (- 1) n)) 0)
             (<= (* (- 1) n) 0))
  [+simpl]
    iter(4)= (and
             (= (+ 1 %stdexp3 (* (- 1) n)) 0)
             (= (+ (* 2 (** 2 n)) (* (- 4) (** 2 %stdexp3))) 0)
             (<= (+ 1 (* (- 1) n)) 0)
             (<= (* (- 1) n) 0))
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ %stdexp2 %stdexp2 (* (- 2) %stdexp4) (* (- 2) %stdexp4)) 0)
             (<= (+ 1 (* (- 1) n)) 0)
             (= (+ 1 %stdexp3 (* (- 1) n)) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (<= (* (- 1) n) 0)
             (= (+ %stdexp1 (* (- 1) n)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp1 -> n;
        %stdexp2 -> (** 2 %stdexp1);
        %stdexp4 -> (** 2 %stdexp3);
        
  [+simpl]
    iter(2)= (and
             (= (+ 1 %stdexp3 (* (- 1) n)) 0)
             (= (+ %stdexp1 (* (- 1) n)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (= (+ (* 2 %stdexp2) (* (- 4) %stdexp4)) 0)
             (<= (+ 1 (* (- 1) n)) 0)
             (<= (* (- 1) n) 0))
  [+simpl]
    iter(3)= (and
             (= (+ 1 %stdexp3 (* (- 1) n)) 0)
             (= (+ (* (- 4) (** 2 %stdexp3)) (* 2 (** 2 %stdexp1))) 0)
             (= (+ (** 2 %stdexp1) (* (- 1) (** 2 n))) 0)
             (<= (+ 1 (* (- 1) n)) 0)
             (<= (* (- 1) n) 0))
  [+simpl]
    iter(4)= (and
             (= (+ 1 %stdexp3 (* (- 1) n)) 0)
             (= (+ (* 2 (** 2 n)) (* (- 4) (** 2 %stdexp3))) 0)
             (<= (+ 1 (* (- 1) n)) 0)
             (<= (* (- 1) n) 0))
  [+simpl]
    fixed-point
  
  (and
    (= (+ 1 %stdexp3 (* (- 1) n)) 0)
    (= (+ (* (- 4) (** 2 %stdexp3)) (* 2 (** 2 n))) 0)
    (<= (+ 1 (* (- 1) n)) 0)
    (<= (* (- 1) n) 0))
  $ cat > 2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun n () Int)
  > (assert (=
  >           (* 2  (+ (** 2 (- n 1))
  >                    (** 2 (- n 1))))
  >         333
  > 
  > ))
  > (check-sat)
  > EOF
  $ Chro -bound -1 --dpresimpl --stop-after pre-simpl 2.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ (- 333) (* 2 %stdexp2) (* 2 %stdexp2)) 0)
             (<= (+ 1 (* (- 1) n)) 0)
             (= (+ 1 %stdexp1 (* (- 1) n)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp2 -> (** 2 %stdexp1);
        
  [+simpl]
    iter(2)= (and
             (= (+ (- 333) (* 4 %stdexp2)) 0)
             (= (+ 1 %stdexp1 (* (- 1) n)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (<= (+ 1 (* (- 1) n)) 0))
  [+simpl]
    iter(3)= (and
             (= (+ (- 333) (* 4 (** 2 %stdexp1))) 0)
             (= (+ 1 %stdexp1 (* (- 1) n)) 0)
             (<= (+ 1 (* (- 1) n)) 0))
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ (- 333) (* 2 %stdexp2) (* 2 %stdexp2)) 0)
             (<= (+ 1 (* (- 1) n)) 0)
             (= (+ 1 %stdexp1 (* (- 1) n)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp2 -> (** 2 %stdexp1);
        
  [+simpl]
    iter(2)= (and
             (= (+ (- 333) (* 4 %stdexp2)) 0)
             (= (+ 1 %stdexp1 (* (- 1) n)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (<= (+ 1 (* (- 1) n)) 0))
  [+simpl]
    iter(3)= (and
             (= (+ (- 333) (* 4 (** 2 %stdexp1))) 0)
             (= (+ 1 %stdexp1 (* (- 1) n)) 0)
             (<= (+ 1 (* (- 1) n)) 0))
  [+simpl]
    fixed-point
  
  (and
    (= (+ (- 333) (* 4 (** 2 %stdexp1))) 0)
    (= (+ 1 %stdexp1 (* (- 1) n)) 0)
    (<= (+ 1 (* (- 1) n)) 0))
