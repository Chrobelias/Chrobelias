  $ cat > testU.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (exists ((x Int)) (<= (** 2  x) x)))
  > (assert (<= (** 2  y) x))
  > (check-sat)
  > EOF
  $ export CHRO_DEBUG=simpl
  $ timeout 2 Chro -no-over -bound 3 --dsimpl --stop-after simpl testU.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ %stdexp2 (* (- 1) x)) 0)
             (exists (x) (<= (+ (** 2 x) (* (- 1) x)) 0))
             (<= (* (- 1) y) 0)
             (= (+ %stdexp1 (* (- 1) y)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp1 -> y;
        %stdexp2 -> (** 2 %stdexp1);
        
  [+simpl]
    iter(2)= (and
             (= (+ %stdexp1 (* (- 1) y)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (<= (+ %stdexp2 (* (- 1) x)) 0)
             (<= (* (- 1) y) 0)
             (exists (x) (<= (+ (* (- 1) x) (** 2 x)) 0)))
  [+simpl]
    iter(3)= (and
             (= (+ (** 2 %stdexp1) (* (- 1) (** 2 y))) 0)
             (<= (+ (* (- 1) x) (** 2 %stdexp1)) 0)
             (<= (* (- 1) y) 0)
             (exists (x) (<= (+ (* (- 1) x) (** 2 x)) 0)))
  [+simpl]
    iter(4)= (and
             (<= (+ (* (- 1) x) (** 2 y)) 0)
             (<= (* (- 1) y) 0)
             (exists (x) (<= (+ (* (- 1) x) (** 2 x)) 0)))
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ %stdexp2 (* (- 1) x)) 0)
             (exists (x) (<= (+ (** 2 x) (* (- 1) x)) 0))
             (<= (* (- 1) y) 0)
             (= (+ %stdexp1 (* (- 1) y)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp1 -> y;
        %stdexp2 -> (** 2 %stdexp1);
        
  [+simpl]
    iter(2)= (and
             (= (+ %stdexp1 (* (- 1) y)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (<= (+ %stdexp2 (* (- 1) x)) 0)
             (<= (* (- 1) y) 0)
             (exists (x) (<= (+ (* (- 1) x) (** 2 x)) 0)))
  [+simpl]
    iter(3)= (and
             (= (+ (** 2 %stdexp1) (* (- 1) (** 2 y))) 0)
             (<= (+ (* (- 1) x) (** 2 %stdexp1)) 0)
             (<= (* (- 1) y) 0)
             (exists (x) (<= (+ (* (- 1) x) (** 2 x)) 0)))
  [+simpl]
    iter(4)= (and
             (<= (+ (* (- 1) x) (** 2 y)) 0)
             (<= (* (- 1) y) 0)
             (exists (x) (<= (+ (* (- 1) x) (** 2 x)) 0)))
  [+simpl]
    fixed-point
  
  (assert (<= (+ (* (- 1) x) pow2(y) )  0) )
  (assert (exists (x) (<= (+ (* (- 1) x) pow2(x) )  0) ) )
  (assert (<= (* (- 1) y)  0) )
  


