  $ export CHRO_DEBUG=1
  $ cat strings3.smt2
  (set-logic QF_S)
  (declare-const x String)
  (declare-const y String)
  (assert (= (str.++ "999" x) (str.++ y x)))
  (check-sat)
  (get-model)

  $ Chro strings3.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (str.++ "999" x) (str.++ y x)))
  iter(2)= (= (str.++ "999" x) (str.++ y x))
  fixed-point
  
  Arithmetization gives 1 asts...
  Arithmetized: (and
                  (= %concat1 (+ %concat4 (* %concat3 (exp 10 %concat2))))
                  (= %concat2 strlenx)
                  (<= 0 strlenx)
                  (= %concat3 y)
                  (= %concat4 x)
                  (= %concat5 %concat1)
                  (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
                  (= %concat6 strlenx)
                  (<= 0 strlenx)
                  (= %concat7 999)
                  (= %concat8 x))
  
  Basic simplifications:
  
  iter(1)= (and
             (= %concat1 (+ %concat4 (* %concat3 (exp 10 %concat2))))
             (= %concat2 strlenx)
             (<= 0 strlenx)
             (= %concat3 y)
             (= %concat4 x)
             (= %concat5 %concat1)
             (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
             (= %concat6 strlenx)
             (<= 0 strlenx)
             (= %concat7 999)
             (= %concat8 x))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
  
  iter(2)= (and
             (= %concat2 strlenx)
             (= %concat3 y)
             (= %concat4 x)
             (= %concat5 %concat1)
             (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
             (= %concat6 strlenx)
             (= %concat7 999)
             (= %concat8 x)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat2 -> strlenx;
  
  iter(3)= (and
             (= %concat3 y)
             (= %concat4 x)
             (= %concat5 (+ %concat4 (* %concat3 (exp 10 %concat2))))
             (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
             (= %concat6 strlenx)
             (= %concat7 999)
             (= %concat8 x)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat2 -> strlenx;
        %concat3 -> y;
  
  iter(4)= (and
             (= %concat4 x)
             (= %concat5 (+ %concat4 (* %concat3 (exp 10 strlenx))))
             (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
             (= %concat6 strlenx)
             (= %concat7 999)
             (= %concat8 x)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat2 -> strlenx;
        %concat3 -> y;
        %concat4 -> x;
  
  iter(5)= (and
             (= %concat5 (+ %concat4 (* y (exp 10 strlenx))))
             (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
             (= %concat6 strlenx)
             (= %concat7 999)
             (= %concat8 x)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat2 -> strlenx;
        %concat3 -> y;
        %concat4 -> x;
        %concat5 -> (+ %concat8 (* %concat7 (exp 10 %concat6)));
  
  iter(6)= (and
             (= %concat5 (+ x (* y (exp 10 strlenx))))
             (= %concat6 strlenx)
             (= %concat7 999)
             (= %concat8 x)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat2 -> strlenx;
        %concat3 -> y;
        %concat4 -> x;
        %concat5 -> (+ %concat8 (* %concat7 (exp 10 %concat6)));
        %concat6 -> strlenx;
  
  iter(7)= (and
             (= %concat7 999)
             (= %concat8 x)
             (= (+ %concat8 (* (- 1) x) (* (- 1) y (exp 10 strlenx))
                (* %concat7 (exp 10 %concat6))) 0)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat2 -> strlenx;
        %concat3 -> y;
        %concat4 -> x;
        %concat5 -> (+ %concat8 (* %concat7 (exp 10 %concat6)));
        %concat6 -> strlenx;
        %concat7 -> 999;
  
  iter(8)= (and
             (= %concat8 x)
             (= (+ %concat8 (* (- 1) x) (* (- 1) y (exp 10 strlenx))
                (* %concat7 (exp 10 strlenx))) 0)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat2 -> strlenx;
        %concat3 -> y;
        %concat4 -> x;
        %concat5 -> (+ %concat8 (* %concat7 (exp 10 %concat6)));
        %concat6 -> strlenx;
        %concat7 -> 999;
        %concat8 -> x;
  
  iter(9)= (and
             (= (+ %concat8 (* (- 1) x) (* (- 1) y (exp 10 strlenx))
                (* 999 (exp 10 strlenx))) 0)
             (<= 0 strlenx))
  iter(10)= (and
              (= (+ (* (- 1) y (exp 10 strlenx)) (* 999 (exp 10 strlenx))) 0)
              (<= 0 strlenx))
  fixed-point
  
  Post-simplification: (and
                         (= (+ (* (- 1) y (exp 10 strlenx))
                            (* 999 (exp 10 strlenx))) 0)
                         (<= (exp 10 0) (exp 10 strlenx)))
  
  New info:
    Exp: strlenx
    Str:
    ALL: strlenx y
  
  Bound for underapproximation: 9
  
  Interesting: strlenx
  
  Expecting 9 choices ...
  
  lib/Underapprox.ml gives early Sat.
  sat (under I)
  ((define-fun x () (_ String) "") (define-fun y () (_ String) "999"))
  $ unset CHRO_DEBUG
  $ timeout 8 Chro -flat 0 -amin 0 -amax 1 --dsimpl strings3.smt2
  sat (under I)
  ((define-fun x () (_ String) "") (define-fun y () (_ String) "999"))
