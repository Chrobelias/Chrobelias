  $ export CHRO_DEBUG=1
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "999" x) (str.++ y x)))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro 1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (str.++ "999" x) (str.++ y x)))
  iter(2)= (= (str.++ "999" x) (str.++ y x))
  fixed-point
  
  Alphapbet with extra char: # 9
  Strings for y:
  
  
  Alphapbet with extra char: # 9
  Arithmetization gives 1 asts...
  Arithmetized: (and
                  (= %concat1 (+ %concat4 (* %concat3 (exp 10 %concat2))))
                  (= %concat2 strlenx)
                  (<= (+ x 1) (exp 10 strlenx))
                  (<= 0 strlenx)
                  (= %concat3 999)
                  (= %concat4 x)
                  (= (+ 3 strlenx) strlenx)
                  (<= (+ x 1) (exp 10 strlenx))
                  (<= 0 strlenx)
                  (<= (+ x 1) (exp 10 strlenx))
                  (<= 0 strlenx)
                  (= %concat1 x))
  
  Basic simplifications:
  
  iter(1)= (and
             (= %concat1 (+ %concat4 (* %concat3 (exp 10 %concat2))))
             (= %concat2 strlenx)
             (<= (+ x 1) (exp 10 strlenx))
             (<= 0 strlenx)
             (= %concat3 999)
             (= %concat4 x)
             (= (+ 3 strlenx) strlenx)
             (<= (+ x 1) (exp 10 strlenx))
             (<= 0 strlenx)
             (<= (+ x 1) (exp 10 strlenx))
             (<= 0 strlenx)
             (= %concat1 x))
  Something ready to substitute
        %concat1 -> x;
        y -> "";
  
  iter(2)= (and
             (= %concat1 (+ %concat4 (* %concat3 (exp 10 %concat2))))
             (= %concat2 strlenx)
             (= %concat3 999)
             (= %concat4 x)
             (= (+ 3 strlenx) strlenx)
             (<= 0 strlenx)
             (<= (+ 1 x) (exp 10 strlenx)))
  Something ready to substitute
        %concat1 -> x;
        %concat2 -> strlenx;
        y -> "";
  
  iter(3)= (and
             (= %concat3 999)
             (= %concat4 x)
             (= x (+ %concat4 (* %concat3 (exp 10 %concat2))))
             (= (+ 3 strlenx) strlenx)
             (<= 0 strlenx)
             (<= (+ 1 x) (exp 10 strlenx)))
  Something ready to substitute
        %concat1 -> x;
        %concat2 -> strlenx;
        %concat3 -> 999;
        y -> "";
  
  iter(4)= (and
             (= %concat4 x)
             (= x (+ %concat4 (* %concat3 (exp 10 strlenx))))
             (= (+ 3 strlenx) strlenx)
             (<= 0 strlenx)
             (<= (+ 1 x) (exp 10 strlenx)))
  Something ready to substitute
        %concat1 -> x;
        %concat2 -> strlenx;
        %concat3 -> 999;
        %concat4 -> x;
        y -> "";
  
  iter(5)= (and
             (= x (+ %concat4 (* 999 (exp 10 strlenx))))
             (= (+ 3 strlenx) strlenx)
             (<= 0 strlenx)
             (<= (+ 1 x) (exp 10 strlenx)))
  iter(6)= (and
             (= x (+ x (* 999 (exp 10 strlenx))))
             (= (+ 3 strlenx) strlenx)
             (<= 0 strlenx)
             (<= (+ 1 x) (exp 10 strlenx)))
  fixed-point
  
  Bound for underapproximation: 9
  
  Interesting: strlenx
  
  Expecting 9 choices ...
  
  Can't decide in lib/Underapprox.ml
  Starting NFA Solver ...
  
  Strings for x:
  
  
  sat (under str)
  (
     (define-fun x () String
      "")   (define-fun y () String
      "999")
  )
