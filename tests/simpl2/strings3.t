  $ export CHRO_DEBUG=1
  $ cat strings3.smt2
  (set-logic QF_S)
  (declare-const x String)
  (declare-const y String)
  (assert (= (str.++ "999" x) (str.++ y x)))
  (check-sat)
  (get-model)

  $ Chro strings3.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (= (str.++ "999" x) (str.++ y x))
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
                  (= %concat3 y)
                  (= %concat4 x)
                  (= %concat5 %concat1)
                  (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
                  (= %concat6 strlenx)
                  (<= (+ x 1) (exp 10 strlenx))
                  (<= 0 strlenx)
                  (= %concat7 999)
                  (= %concat8 x)
                  (= (+ strlenx (* (- 1) strlenx) (* (- 1) strleny)) (- 3))
                  (<= (+ x 1) (exp 10 strlenx))
                  (<= 0 strlenx)
                  (<= (+ x 1) (exp 10 strlenx))
                  (<= 0 strlenx)
                  (<= (+ y 1) (exp 10 strleny))
                  (<= 0 strleny))
  
  Basic simplifications:
  
  iter(1)= (and
             (= %concat1 (+ %concat4 (* %concat3 (exp 10 %concat2))))
             (= %concat2 strlenx)
             (<= (+ x 1) (exp 10 strlenx))
             (<= 0 strlenx)
             (= %concat3 y)
             (= %concat4 x)
             (= %concat5 %concat1)
             (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
             (= %concat6 strlenx)
             (<= (+ x 1) (exp 10 strlenx))
             (<= 0 strlenx)
             (= %concat7 999)
             (= %concat8 x)
             (= (+ strlenx (* (- 1) strlenx) (* (- 1) strleny)) (- 3))
             (<= (+ x 1) (exp 10 strlenx))
             (<= 0 strlenx)
             (<= (+ x 1) (exp 10 strlenx))
             (<= 0 strlenx)
             (<= (+ y 1) (exp 10 strleny))
             (<= 0 strleny))
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
             (= (+ (* (- 1) strleny)) (- 3))
             (<= 0 strlenx)
             (<= 0 strleny)
             (<= (+ 1 x) (exp 10 strlenx))
             (<= (+ 1 y) (exp 10 strleny)))
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
             (= (* (- 1) strleny) (- 3))
             (<= 0 strlenx)
             (<= 0 strleny)
             (<= (+ 1 x) (exp 10 strlenx))
             (<= (+ 1 y) (exp 10 strleny)))
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
             (= (* (- 1) strleny) (- 3))
             (<= 0 strlenx)
             (<= 0 strleny)
             (<= (+ 1 x) (exp 10 strlenx))
             (<= (+ 1 y) (exp 10 strleny)))
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
             (= (* (- 1) strleny) (- 3))
             (<= 0 strlenx)
             (<= 0 strleny)
             (<= (+ 1 x) (exp 10 strlenx))
             (<= (+ 1 y) (exp 10 strleny)))
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
             (= (* (- 1) strleny) (- 3))
             (<= 0 strlenx)
             (<= 0 strleny)
             (<= (+ 1 x) (exp 10 strlenx))
             (<= (+ 1 y) (exp 10 strleny)))
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
             (= (* (- 1) strleny) (- 3))
             (<= 0 strlenx)
             (<= 0 strleny)
             (<= (+ 1 x) (exp 10 strlenx))
             (<= (+ 1 y) (exp 10 strleny)))
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
             (= (* (- 1) strleny) (- 3))
             (<= 0 strlenx)
             (<= 0 strleny)
             (<= (+ 1 x) (exp 10 strlenx))
             (<= (+ 1 y) (exp 10 strleny)))
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
             (= (* (- 1) strleny) (- 3))
             (<= 0 strlenx)
             (<= 0 strleny)
             (<= (+ 1 x) (exp 10 strlenx))
             (<= (+ 1 y) (exp 10 strleny)))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat2 -> strlenx;
        %concat3 -> y;
        %concat4 -> x;
        %concat5 -> (+ %concat8 (* %concat7 (exp 10 %concat6)));
        %concat6 -> strlenx;
        %concat7 -> 999;
        %concat8 -> x;
        strleny -> 3;
  
  iter(10)= (and
              (= (+ (* (- 1) y (exp 10 strlenx)) (* 999 (exp 10 strlenx))) 0)
              (<= 0 strlenx)
              (<= 0 strleny)
              (<= (+ 1 x) (exp 10 strlenx))
              (<= (+ 1 y) (exp 10 strleny)))
  iter(11)= (and
              (= (+ (* (- 1) y (exp 10 strlenx)) (* 999 (exp 10 strlenx))) 0)
              (<= 0 strlenx)
              (<= y 999)
              (<= (+ 1 x) (exp 10 strlenx)))
  fixed-point
  
  Post-simplification: (and
                         (= (+ (* (- 1) y (exp 10 strlenx))
                            (* 999 (exp 10 strlenx))) 0)
                         (<= (exp 10 0) (exp 10 strlenx))
                         (<= y 999)
                         (<= (+ 1 x) (exp 10 strlenx)))
  
  New info:
    Exp: strlenx
    Str:
    ALL: strlenx x y
  
  Bound for underapproximation: 9
  
  Interesting: strlenx
  
  Expecting 9 choices ...
  
  lib/Underapprox.ml gives early Sat.
  sat (under int)
  (
     (define-fun x () String
      "")   (define-fun y () String
      "999")
  )
  $ unset CHRO_DEBUG
  $ timeout 8 Chro -flat 0 -amin 0 -amax 1 --dsimpl strings3.smt2
  sat (under int)
  (
     (define-fun x () String
      "")   (define-fun y () String
      "999")
  )
