  $ export CHRO_DEBUG=1
  $ cat strings3.smt2
  (set-logic QF_S)
  (declare-const x String)
  (declare-const y String)
  (assert (= (str.++ "999" x) (str.++ y x)))
  (check-sat)

  $ Chro strings3.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (str.++ "999" x) (str.++ y x)))
  iter(2)= (= (str.++ "999" x) (str.++ y x))
  fixed-point
  
  Arithmetization gives 1 asts...
  Arithmetized: (and
                  (= %concat6 strlenx)
                  (<= 0 strlenx)
                  (= %concat5 (+ (* %concat7 (exp 10 %concat6)) %concat8))
                  (= %concat8 x)
                  (= %concat7 999)
                  (= %concat2 strlenx)
                  (<= 0 strlenx)
                  (= %concat1 (+ (* %concat3 (exp 10 %concat2)) %concat4))
                  (= %concat4 x)
                  (= %concat3 y)
                  (= %concat5 %concat1))
  
  Basic simplifications:
  
  iter(1)= (and
             (= %concat6 strlenx)
             (<= 0 strlenx)
             (= %concat5 (+ (* %concat7 (exp 10 %concat6)) %concat8))
             (= %concat8 x)
             (= %concat7 999)
             (= %concat2 strlenx)
             (<= 0 strlenx)
             (= %concat1 (+ (* %concat3 (exp 10 %concat2)) %concat4))
             (= %concat4 x)
             (= %concat3 y)
             (= %concat5 %concat1))
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
        %concat5 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
  
  iter(3)= (and
             (= %concat2 strlenx)
             (= %concat3 y)
             (= %concat4 x)
             (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
             (= %concat6 strlenx)
             (= %concat7 999)
             (= %concat8 x)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat5 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat7 -> 999;
  
  iter(4)= (and
             (= %concat2 strlenx)
             (= %concat3 y)
             (= %concat4 x)
             (= %concat6 strlenx)
             (= %concat8 x)
             (= (+ %concat4 (* (- 1) %concat7 (exp 10 %concat6))
                (* (- 1) %concat8) (* %concat3 (exp 10 %concat2))) 0)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat4 -> (+ %concat8 (* (- 1) %concat3 (exp 10 %concat2))
                    (* 999 (exp 10 %concat6)));
        %concat5 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat7 -> 999;
  
  iter(5)= (and
             (= %concat2 strlenx)
             (= %concat3 y)
             (= %concat4 x)
             (= %concat6 strlenx)
             (= %concat8 x)
             (<= 0 strlenx))
  iter(6)= (and
             (= %concat2 strlenx)
             (= %concat3 y)
             (= %concat6 strlenx)
             (= %concat8 x)
             (= (+ %concat8 (* (- 1) %concat3 (exp 10 %concat2))
                (* 999 (exp 10 %concat6))) x)
             (<= 0 strlenx))
  fixed-point
  
  Interesting: %concat2 %concat6
  
  Expecting 0 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| %concat2->0 %concat3->999 %concat6->0 %concat8->0 strlenx->0
        x->0 y->999 |}
  sat (under I)
  $ unset CHRO_DEBUG
  $ timeout 8 Chro -flat 0 -amin 0 -amax 1 --dsimpl strings3.smt2
  sat (under I)
