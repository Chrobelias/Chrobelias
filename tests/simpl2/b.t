  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= (+ z y) 52))
  > (assert (= (+ z x) 32))
  > (assert (< 111111 (+ (** 2 x) (** 2 y)) ))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro -no-over -bound -1 --dsimpl --stop-after pre-simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ 111112 (* (- 1) %stdexp2) (* (- 1) %stdexp4)) 0)
             (= (+ (- 32) z x) 0)
             (= (+ (- 52) z y) 0)
             (<= (* (- 1) y) 0)
             (= (+ %stdexp3 (* (- 1) y)) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (<= (* (- 1) x) 0)
             (= (+ %stdexp1 (* (- 1) x)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp1 -> x;
        %stdexp2 -> (** 2 %stdexp1);
        %stdexp3 -> y;
        %stdexp4 -> (** 2 %stdexp3);
        x -> (+ 32 (- z));
        y -> (+ 52 (- z));
        
  [+simpl]
    iter(2)= (and
             (= (+ (- 52) y z) 0)
             (= (+ (- 32) x z) 0)
             (= (+ %stdexp1 (* (- 1) x)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (= (+ %stdexp3 (* (- 1) y)) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (<= (+ 111112 (* (- 1) %stdexp2) (* (- 1) %stdexp4)) 0)
             (<= (* (- 1) x) 0)
             (<= (* (- 1) y) 0))
  [+simpl]
    iter(3)= (and
             (= (+ (* 32 (- 1)) x (* (* (- 1) z) (- 1))) 0)
             (= (+ (* 52 (- 1)) y (* (* (- 1) z) (- 1))) 0)
             (= (+ (** 2 %stdexp1) (* (- 1) (** 2 x))) 0)
             (= (+ (** 2 %stdexp3) (* (- 1) (** 2 y))) 0)
             (<= (+ 111112 (* (- 1) (** 2 %stdexp1)) (* (- 1) (** 2 %stdexp3))) 0)
             (<= (+ (* 32 (- 1)) (* (* (- 1) z) (- 1))) 0)
             (<= (+ (* 52 (- 1)) (* (* (- 1) z) (- 1))) 0))
  [+simpl]
    iter(4)= (and
             (= (+ (** 2 x) (* (- 1) (** 2 (+ 32 (* (- 1) z))))) 0)
             (= (+ (** 2 y) (* (- 1) (** 2 (+ 52 (* (- 1) z))))) 0)
             (<= (+ (- 52) z) 0)
             (<= (+ (- 32) z) 0)
             (<= (+ 111112 (* (- 1) (** 2 x)) (* (- 1) (** 2 y))) 0))
  [+simpl]
    iter(5)= (and
             (<= (+ (- 52) z) 0)
             (<= (+ (- 32) z) 0)
             (<= (+ 111112 (* (- 1) (** 2 (+ 32 (* (- 1) z))))
                 (* (- 1) (** 2 (+ 52 (* (- 1) z))))) 0))
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ 111112 (* (- 1) %stdexp2) (* (- 1) %stdexp4)) 0)
             (= (+ (- 32) z x) 0)
             (= (+ (- 52) z y) 0)
             (<= (* (- 1) y) 0)
             (= (+ %stdexp3 (* (- 1) y)) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (<= (* (- 1) x) 0)
             (= (+ %stdexp1 (* (- 1) x)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp1 -> x;
        %stdexp2 -> (** 2 %stdexp1);
        %stdexp3 -> y;
        %stdexp4 -> (** 2 %stdexp3);
        x -> (+ 32 (- z));
        y -> (+ 52 (- z));
        
  [+simpl]
    iter(2)= (and
             (= (+ (- 52) y z) 0)
             (= (+ (- 32) x z) 0)
             (= (+ %stdexp1 (* (- 1) x)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (= (+ %stdexp3 (* (- 1) y)) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (<= (+ 111112 (* (- 1) %stdexp2) (* (- 1) %stdexp4)) 0)
             (<= (* (- 1) x) 0)
             (<= (* (- 1) y) 0))
  [+simpl]
    iter(3)= (and
             (= (+ (* 32 (- 1)) x (* (* (- 1) z) (- 1))) 0)
             (= (+ (* 52 (- 1)) y (* (* (- 1) z) (- 1))) 0)
             (= (+ (** 2 %stdexp1) (* (- 1) (** 2 x))) 0)
             (= (+ (** 2 %stdexp3) (* (- 1) (** 2 y))) 0)
             (<= (+ 111112 (* (- 1) (** 2 %stdexp1)) (* (- 1) (** 2 %stdexp3))) 0)
             (<= (+ (* 32 (- 1)) (* (* (- 1) z) (- 1))) 0)
             (<= (+ (* 52 (- 1)) (* (* (- 1) z) (- 1))) 0))
  [+simpl]
    iter(4)= (and
             (= (+ (** 2 x) (* (- 1) (** 2 (+ 32 (* (- 1) z))))) 0)
             (= (+ (** 2 y) (* (- 1) (** 2 (+ 52 (* (- 1) z))))) 0)
             (<= (+ (- 52) z) 0)
             (<= (+ (- 32) z) 0)
             (<= (+ 111112 (* (- 1) (** 2 x)) (* (- 1) (** 2 y))) 0))
  [+simpl]
    iter(5)= (and
             (<= (+ (- 52) z) 0)
             (<= (+ (- 32) z) 0)
             (<= (+ 111112 (* (- 1) (** 2 (+ 32 (* (- 1) z))))
                 (* (- 1) (** 2 (+ 52 (* (- 1) z))))) 0))
  [+simpl]
    fixed-point
  
