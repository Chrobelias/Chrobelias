  $ export CHRO_DEBUG=simpl
  $ Chro ./example.smt2 
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ y (* (- 1) (str.to.int num1))) 0)
             (= (+ (- 5) z) 0)
             (<= (+ 2 (* (- 1) y)) 0)
             (= (+ (- 10) x (* 3 y)) 0)
             (= (+ (- 7) x) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        x -> (+ 10 (* (- 3) y));
        z -> 5;
        
  [+simpl]
    iter(2)= (and
             (= (+ (- 10) x (* 3 y)) 0)
             (= (+ (- 7) x) 0)
             (= (+ (- 5) z) 0)
             (<= (+ 2 (* (- 1) y)) 0)
             (<= (+ y (* (- 1) (str.to.int num1))) 0))
  [+simpl]
    iter(3)= (and
             (= (+ 3 (* (- 3) y)) 0)
             (<= (+ 2 (* (- 1) y)) 0)
             (<= (+ y (* (- 1) (str.to.int num1))) 0))
  [+simpl]
    fixed-point
  
  unsat (over)

  $ Chro ./issue229.smt2
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ (- 7) y) 0)
             (<= (+ (- 2) w) 0)
             (= (+ (- 1) w (* (- 1) z)) 0)
             (= (+ (- 1) z (* (- 1) x)) 0)
             (= (+ (- 1) x (* (- 1) y)) 0)
             (= (+ (- 7) w) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        w -> 7;
        x -> (+ 1 y);
        y -> 7;
        z -> (+ 1 x);
        
  [+simpl]
    iter(2)= (and
             (= (+ (- 7) w) 0)
             (= (+ (- 7) y) 0)
             (= (+ (- 1) w (* (- 1) z)) 0)
             (= (+ (- 1) x (* (- 1) y)) 0)
             (= (+ (- 1) (* (- 1) x) z) 0)
             (<= (+ (- 2) w) 0))
  [+simpl]
    iter(3)= (not True)
  [+simpl]
    fixed-point
  
  [+simpl]
    contradicting clause: (= (+ (- 1) w (* (- 1) z)) 0)
  [+simpl]
    contradicting env:  w -> 7; x -> (+ 1 y); y -> 7; z -> (+ 1 x); 
  [+simpl]
    unsat core: (and
                (<= (+ (- 2) w) 0)
                (= (+ (- 7) w) 0))
  
  unsat (presimpl int)
