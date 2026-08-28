$ cat  sum3exp.smt2
  $ export CHRO_DEBUG=simpl
  $ export CHRO_TRACE_OPT=1
  $ Chro --dsimpl --stop-after pre-simpl -bound 3 ../underapprox/sum3exp.smt2
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ (- 10) (** 2 x1) (** 2 x2) %stdexp2 (* (- 1) x1)
                 (* (- 1) x2) (* (- 1) x3)) 0)
             (<= (+ (** 2 x1) (* (- 1) x2)) 0)
             (<= (+ 2 (* (- 1) x2)) 0)
             (<= (+ 1 (* (- 1) x2)) 0)
             (<= (* (- 1) x1) 0)
             (<= (* (- 1) x3) 0)
             (= (+ %stdexp1 (* (- 1) x3)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp1 -> x3;
        %stdexp2 -> (** 2 %stdexp1);
        
  [+simpl]
    iter(2)= (and
             (= (+ %stdexp1 (* (- 1) x3)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (<= (+ (- 10) %stdexp2 (* (- 1) x1) (* (- 1) x2) (* (- 1) x3)
                 (** 2 x1) (** 2 x2)) 0)
             (<= (+ 1 (* (- 1) x2)) 0)
             (<= (+ 2 (* (- 1) x2)) 0)
             (<= (+ (* (- 1) x2) (** 2 x1)) 0)
             (<= (* (- 1) x1) 0)
             (<= (* (- 1) x3) 0))
  [+simpl]
    iter(3)= (and
             (= (+ (** 2 %stdexp1) (* (- 1) (** 2 x3))) 0)
             (<= (+ (- 10) (* (- 1) x1) (* (- 1) x2) (* (- 1) x3)
                 (** 2 %stdexp1) (** 2 x1) (** 2 x2)) 0)
             (<= (+ 1 (* (- 1) x2)) 0)
             (<= (+ 2 (* (- 1) x2)) 0)
             (<= (+ (* (- 1) x2) (** 2 x1)) 0)
             (<= (* (- 1) x1) 0)
             (<= (* (- 1) x3) 0))
  [+simpl]
    iter(4)= (and
             (<= (+ (- 10) (* (- 1) x1) (* (- 1) x2) (* (- 1) x3) (** 2 x1)
                 (** 2 x2) (** 2 x3)) 0)
             (<= (+ 1 (* (- 1) x2)) 0)
             (<= (+ 2 (* (- 1) x2)) 0)
             (<= (+ (* (- 1) x2) (** 2 x1)) 0)
             (<= (* (- 1) x1) 0)
             (<= (* (- 1) x3) 0))
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ (- 10) (** 2 x1) (** 2 x2) %stdexp2 (* (- 1) x1)
                 (* (- 1) x2) (* (- 1) x3)) 0)
             (<= (+ (** 2 x1) (* (- 1) x2)) 0)
             (<= (+ 2 (* (- 1) x2)) 0)
             (<= (+ 1 (* (- 1) x2)) 0)
             (<= (* (- 1) x1) 0)
             (<= (* (- 1) x3) 0)
             (= (+ %stdexp1 (* (- 1) x3)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp1 -> x3;
        %stdexp2 -> (** 2 %stdexp1);
        
  [+simpl]
    iter(2)= (and
             (= (+ %stdexp1 (* (- 1) x3)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (<= (+ (- 10) %stdexp2 (* (- 1) x1) (* (- 1) x2) (* (- 1) x3)
                 (** 2 x1) (** 2 x2)) 0)
             (<= (+ 1 (* (- 1) x2)) 0)
             (<= (+ 2 (* (- 1) x2)) 0)
             (<= (+ (* (- 1) x2) (** 2 x1)) 0)
             (<= (* (- 1) x1) 0)
             (<= (* (- 1) x3) 0))
  [+simpl]
    iter(3)= (and
             (= (+ (** 2 %stdexp1) (* (- 1) (** 2 x3))) 0)
             (<= (+ (- 10) (* (- 1) x1) (* (- 1) x2) (* (- 1) x3)
                 (** 2 %stdexp1) (** 2 x1) (** 2 x2)) 0)
             (<= (+ 1 (* (- 1) x2)) 0)
             (<= (+ 2 (* (- 1) x2)) 0)
             (<= (+ (* (- 1) x2) (** 2 x1)) 0)
             (<= (* (- 1) x1) 0)
             (<= (* (- 1) x3) 0))
  [+simpl]
    iter(4)= (and
             (<= (+ (- 10) (* (- 1) x1) (* (- 1) x2) (* (- 1) x3) (** 2 x1)
                 (** 2 x2) (** 2 x3)) 0)
             (<= (+ 1 (* (- 1) x2)) 0)
             (<= (+ 2 (* (- 1) x2)) 0)
             (<= (+ (* (- 1) x2) (** 2 x1)) 0)
             (<= (* (- 1) x1) 0)
             (<= (* (- 1) x3) 0))
  [+simpl]
    fixed-point
  


