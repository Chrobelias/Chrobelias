$ export CHRO_DEBUG=1
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "123" x) (str.++ y x)))
  > (assert (= y "321"))
  > (check-sat)
  > EOF

  $ CHRO_DEBUG=1 Chro --pre-simpl --dpresimpl --dsimpl --stop-after simpl 1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= y "321")
             (= (str.++ "123" x) (str.++ y x)))
  Something ready to substitute
        y -> "321";
  
  iter(2)= (and
             (= (str.++ "123" x) (str.++ y x)))
  iter(3)= (= (str.++ "123" x) (str.++ "321" x))
  fixed-point
  
  Arithmetization gives 1 asts...
  Arithmetized: (and
                  (= %concat1 (+ %concat4 (* %concat3 (exp 10 %concat2))))
                  (= %concat2 strlenx)
                  (<= 0 strlenx)
                  (= %concat3 321)
                  (= %concat4 x)
                  (= %concat5 %concat1)
                  (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
                  (= %concat6 strlenx)
                  (<= 0 strlenx)
                  (= %concat7 123)
                  (= %concat8 x))
  
  Basic simplifications:
  
  iter(1)= (and
             (= %concat1 (+ %concat4 (* %concat3 (exp 10 %concat2))))
             (= %concat2 strlenx)
             (<= 0 strlenx)
             (= %concat3 321)
             (= %concat4 x)
             (= %concat5 %concat1)
             (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
             (= %concat6 strlenx)
             (<= 0 strlenx)
             (= %concat7 123)
             (= %concat8 x))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
  
  iter(2)= (and
             (= %concat2 strlenx)
             (= %concat3 321)
             (= %concat4 x)
             (= %concat5 %concat1)
             (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
             (= %concat6 strlenx)
             (= %concat7 123)
             (= %concat8 x)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat2 -> strlenx;
  
  iter(3)= (and
             (= %concat3 321)
             (= %concat4 x)
             (= %concat5 (+ %concat4 (* %concat3 (exp 10 %concat2))))
             (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
             (= %concat6 strlenx)
             (= %concat7 123)
             (= %concat8 x)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat2 -> strlenx;
        %concat3 -> 321;
  
  iter(4)= (and
             (= %concat4 x)
             (= %concat5 (+ %concat4 (* %concat3 (exp 10 strlenx))))
             (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
             (= %concat6 strlenx)
             (= %concat7 123)
             (= %concat8 x)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat2 -> strlenx;
        %concat3 -> 321;
        %concat4 -> x;
  
  iter(5)= (and
             (= %concat5 (+ %concat4 (* 321 (exp 10 strlenx))))
             (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
             (= %concat6 strlenx)
             (= %concat7 123)
             (= %concat8 x)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat2 -> strlenx;
        %concat3 -> 321;
        %concat4 -> x;
        %concat5 -> (+ %concat8 (* %concat7 (exp 10 %concat6)));
  
  iter(6)= (and
             (= %concat5 (+ x (* 321 (exp 10 strlenx))))
             (= %concat6 strlenx)
             (= %concat7 123)
             (= %concat8 x)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat2 -> strlenx;
        %concat3 -> 321;
        %concat4 -> x;
        %concat5 -> (+ %concat8 (* %concat7 (exp 10 %concat6)));
        %concat6 -> strlenx;
  
  iter(7)= (and
             (= %concat7 123)
             (= %concat8 x)
             (= (+ %concat8 (* (- 321) (exp 10 strlenx)) (* (- 1) x)
                (* %concat7 (exp 10 %concat6))) 0)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat2 -> strlenx;
        %concat3 -> 321;
        %concat4 -> x;
        %concat5 -> (+ %concat8 (* %concat7 (exp 10 %concat6)));
        %concat6 -> strlenx;
        %concat7 -> 123;
  
  iter(8)= (and
             (= %concat8 x)
             (= (+ %concat8 (* (- 321) (exp 10 strlenx)) (* (- 1) x)
                (* %concat7 (exp 10 strlenx))) 0)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat2 -> strlenx;
        %concat3 -> 321;
        %concat4 -> x;
        %concat5 -> (+ %concat8 (* %concat7 (exp 10 %concat6)));
        %concat6 -> strlenx;
        %concat7 -> 123;
        %concat8 -> x;
  
  iter(9)= (and
             (= (+ %concat8 (* (- 198) (exp 10 strlenx)) (* (- 1) x)) 0)
             (<= 0 strlenx))
  iter(10)= (and
              (= (+ x (* (- 198) (exp 10 strlenx)) (* (- 1) x)) 0)
              (<= 0 strlenx))
  fixed-point
  
  Post-simplification: (and
                         (= (+ x (* (- 198) (exp 10 strlenx)) (* (- 1) x)) 0)
                         (<= (exp 10 0) (exp 10 strlenx)))
  
  New info:
    Exp: strlenx
    Str:
    ALL: strlenx x
  
  Bound for underapproximation: 7
  
  Interesting: strlenx
  
  Expecting 7 choices ...
  
  Can't decide in lib/Underapprox.ml
  (and
    (= (+ x (* (- 198) (exp 10 strlenx)) (* (- 1) x)) 0)
    (<= (exp 10 0) (exp 10 strlenx)))
  Starting NFA Solver ...
  
  Running string-bitvector MSB mode
  (assert (exists (x)
          (and
            (= (+ (* (- 0) x) (* (- 198) pow2(strlenx)) )  0)
            (<= (* (- 1) pow2(strlenx))  -1)
            )
  )

  $ Chro 1.smt2 | sed 's/[[:space:]]*$//'
  unsat (nfa)
