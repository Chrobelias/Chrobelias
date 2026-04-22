  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (+ 5 y (* (- 7) u)) 0))
  > (assert (= (+ 2 y (* (- 3) x)) 0))
  > (assert (>= z 100))
  > (check-sat)
  > (get-model)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over -bound 0 --dsimpl --stop-after simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (<= (+ 100 (* (- 1) z)) 0)
             (= (+ 2 y (* (- 3) x)) 0)
             (= (+ 5 y (* (- 7) u)) 0))
  Alphabet with extra char: #
  
  Something ready to substitute
        y -> (+ (- 2) (* 3 x));
  
  iter(2)= (and
             (= (+ 2 (* (- 3) x) y) 0)
             (= (+ 5 (* (- 7) u) y) 0)
             (<= (+ 100 (* (- 1) z)) 0))
  iter(3)= (and
             (= (+ 3 (* (- 7) u) (* 3 x)) 0)
             (<= (+ 100 (* (- 1) z)) 0))
  fixed-point
  
  Bound for underapproximation: 6
  
  Interesting:
  
  Expecting 1 choices ...
  
  lib/Underapprox.ml gives early Sat.
  sat (under int)
  (
     (define-fun u () Int
      0)
     (define-fun x () Int
      -1)
     (define-fun y () Int
      -5)
     (define-fun z () Int
      100)
  )
  Checking model correctness;
    ast=(and
                                      (= (+ (- 100) z) 0)
                                      (= (+ 5 y) 0)
                                      (= (+ 1 x) 0)
                                      (= u 0)
                                      (<= (+ 100 (* (- 1) z)) 0)
                                      (= (+ 2 y (* (- 3) x)) 0)
                                      (= (+ 5 y (* (- 7) u)) 0))
  
  Basic simplifications:
  
  iter(1)= (and
             (= (+ (- 100) z) 0)
             (= (+ 5 y) 0)
             (= (+ 1 x) 0)
             (= u 0)
             (<= (+ 100 (* (- 1) z)) 0)
             (= (+ 2 y (* (- 3) x)) 0)
             (= (+ 5 y (* (- 7) u)) 0))
  Alphabet with extra char: #
  
  Something ready to substitute
        u -> 0;
  
  iter(2)= (and
             (= u 0)
             (= (+ (- 100) z) 0)
             (= (+ 1 x) 0)
             (= (+ 2 (* (- 3) x) y) 0)
             (= (+ 5 y) 0)
             (= (+ 5 (* (- 7) u) y) 0)
             (<= (+ 100 (* (- 1) z)) 0))
  Something ready to substitute
        u -> 0;
        z -> 100;
  
  iter(3)= (and
             (= (+ (- 100) z) 0)
             (= (+ 1 x) 0)
             (= (+ 2 (* (- 3) x) y) 0)
             (= (+ 5 y) 0)
             (<= (+ 100 (* (- 1) z)) 0))
  Something ready to substitute
        u -> 0;
        x -> (- 1);
        z -> 100;
  
  iter(4)= (and
             (= (+ 1 x) 0)
             (= (+ 2 (* (- 3) x) y) 0)
             (= (+ 5 y) 0))
  Something ready to substitute
        u -> 0;
        x -> (- 1);
        y -> (- 5);
        z -> 100;
  
  iter(5)= (= (+ 5 y) 0)
  iter(6)= True
  fixed-point
  

TODO: fix this later
  $ cat > 2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= x x))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro -no-over -bound 0 --dsimpl --stop-after simpl 2.smt2 | sed 's/[[:space:]]*$//'
  sat (presimpl int)
  (
     (define-fun x () Int
      0)
  )
