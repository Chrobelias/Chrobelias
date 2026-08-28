  $ CHRO_DEBUG=simpl Chro  --dsimpl --stop-after pre-simpl test2exp.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ %stdexp2 (* (- 1) %stdexp4)) 0)
             (<= (* (- 1) z) 0)
             (= (+ %stdexp3 (* (- 1) z)) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (<= (+ (* (- 1) x) (* (- 1) y)) 0)
             (= (+ %stdexp1 (* (- 1) x) (* (- 1) y)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp2 -> (** 2 %stdexp1);
        %stdexp3 -> z;
        %stdexp4 -> (** 2 %stdexp3);
        
  [+simpl]
    iter(2)= (and
             (= (+ %stdexp1 (* (- 1) x) (* (- 1) y)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (= (+ %stdexp3 (* (- 1) z)) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (<= (+ %stdexp2 (* (- 1) %stdexp4)) 0)
             (<= (+ (* (- 1) x) (* (- 1) y)) 0)
             (<= (* (- 1) z) 0))
  [+simpl]
    iter(3)= (and
             (= (+ %stdexp1 (* (- 1) x) (* (- 1) y)) 0)
             (= (+ (** 2 %stdexp3) (* (- 1) (** 2 z))) 0)
             (<= (+ (* (- 1) x) (* (- 1) y)) 0)
             (<= (+ (** 2 %stdexp1) (* (- 1) (** 2 %stdexp3))) 0)
             (<= (* (- 1) z) 0))
  [+simpl]
    iter(4)= (and
             (= (+ %stdexp1 (* (- 1) x) (* (- 1) y)) 0)
             (<= (+ (* (- 1) x) (* (- 1) y)) 0)
             (<= (+ (** 2 %stdexp1) (* (- 1) (** 2 z))) 0)
             (<= (* (- 1) z) 0))
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ %stdexp2 (* (- 1) %stdexp4)) 0)
             (<= (* (- 1) z) 0)
             (= (+ %stdexp3 (* (- 1) z)) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (<= (+ (* (- 1) x) (* (- 1) y)) 0)
             (= (+ %stdexp1 (* (- 1) x) (* (- 1) y)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp2 -> (** 2 %stdexp1);
        %stdexp3 -> z;
        %stdexp4 -> (** 2 %stdexp3);
        
  [+simpl]
    iter(2)= (and
             (= (+ %stdexp1 (* (- 1) x) (* (- 1) y)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (= (+ %stdexp3 (* (- 1) z)) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (<= (+ %stdexp2 (* (- 1) %stdexp4)) 0)
             (<= (+ (* (- 1) x) (* (- 1) y)) 0)
             (<= (* (- 1) z) 0))
  [+simpl]
    iter(3)= (and
             (= (+ %stdexp1 (* (- 1) x) (* (- 1) y)) 0)
             (= (+ (** 2 %stdexp3) (* (- 1) (** 2 z))) 0)
             (<= (+ (* (- 1) x) (* (- 1) y)) 0)
             (<= (+ (** 2 %stdexp1) (* (- 1) (** 2 %stdexp3))) 0)
             (<= (* (- 1) z) 0))
  [+simpl]
    iter(4)= (and
             (= (+ %stdexp1 (* (- 1) x) (* (- 1) y)) 0)
             (<= (+ (* (- 1) x) (* (- 1) y)) 0)
             (<= (+ (** 2 %stdexp1) (* (- 1) (** 2 z))) 0)
             (<= (* (- 1) z) 0))
  [+simpl]
    fixed-point
  
