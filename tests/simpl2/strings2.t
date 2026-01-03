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
                  (= %concat6 strlenx)
                  (<= 0 strlenx)
                  (= %concat5 (+ (* %concat7 (exp 10 %concat6)) %concat8))
                  (= %concat8 x)
                  (= %concat7 123)
                  (= %concat2 strlenx)
                  (<= 0 strlenx)
                  (= %concat1 (+ (* %concat3 (exp 10 %concat2)) %concat4))
                  (= %concat4 x)
                  (= %concat3 321)
                  (= %concat5 %concat1))
  
  Basic simplifications:
  
  iter(1)= (and
             (= %concat6 strlenx)
             (<= 0 strlenx)
             (= %concat5 (+ (* %concat7 (exp 10 %concat6)) %concat8))
             (= %concat8 x)
             (= %concat7 123)
             (= %concat2 strlenx)
             (<= 0 strlenx)
             (= %concat1 (+ (* %concat3 (exp 10 %concat2)) %concat4))
             (= %concat4 x)
             (= %concat3 321)
             (= %concat5 %concat1))
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
        %concat3 -> 321;
  
  iter(3)= (and
             (= %concat2 strlenx)
             (= %concat4 x)
             (= %concat5 (+ %concat4 (* %concat3 (exp 10 %concat2))))
             (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
             (= %concat6 strlenx)
             (= %concat7 123)
             (= %concat8 x)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat3 -> 321;
        %concat5 -> (+ %concat4 (* 321 (exp 10 %concat2)));
  
  iter(4)= (and
             (= %concat2 strlenx)
             (= %concat4 x)
             (= %concat5 (+ %concat8 (* %concat7 (exp 10 %concat6))))
             (= %concat6 strlenx)
             (= %concat7 123)
             (= %concat8 x)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat3 -> 321;
        %concat5 -> (+ %concat4 (* 321 (exp 10 %concat2)));
        %concat7 -> 123;
  
  iter(5)= (and
             (= %concat2 strlenx)
             (= %concat4 x)
             (= %concat6 strlenx)
             (= %concat8 x)
             (= (+ %concat4 (* (- 1) %concat7 (exp 10 %concat6))
                (* (- 1) %concat8) (* 321 (exp 10 %concat2))) 0)
             (<= 0 strlenx))
  Something ready to substitute
        %concat1 -> (+ %concat4 (* %concat3 (exp 10 %concat2)));
        %concat3 -> 321;
        %concat4 -> (+ %concat8 (* (- 321) (exp 10 %concat2))
                    (* 123 (exp 10 %concat6)));
        %concat5 -> (+ %concat4 (* 321 (exp 10 %concat2)));
        %concat7 -> 123;
  
  iter(6)= (and
             (= %concat2 strlenx)
             (= %concat4 x)
             (= %concat6 strlenx)
             (= %concat8 x)
             (<= 0 strlenx))
  iter(7)= (and
             (= %concat2 strlenx)
             (= %concat6 strlenx)
             (= %concat8 x)
             (= (+ %concat8 (* (- 321) (exp 10 %concat2))
                (* 123 (exp 10 %concat6))) x)
             (<= 0 strlenx))
  fixed-point
  
  Interesting: %concat2 %concat6
  
  Expecting 0 choices ...
  
  Can't decide in lib/Underapprox.ml
  (and
    (= %concat2 strlenx)
    (= %concat6 strlenx)
    (= %concat8 x)
    (= (+ %concat8 (* (- 321) (exp 10 %concat2)) (* 123 (exp 10 %concat6))) x)
    (<= 0 strlenx))
  (assert (exists (strlenx x)
          (and
            (exists (%concat8)
            (and
              (= (+ %concat8 (* (- 1) x) )  0)
              (= (+ %concat8 (* (- 1) x) (* (- 321) pow2(%concat2))
                 (* 123 pow2(%concat6)) )
               0)
              )
  
            (= (+ %concat2 (* (- 1) strlenx) )  0)
            (= (+ %concat6 (* (- 1) strlenx) )  0)
            (<= (* (- 1) strlenx)  0)
            )
  )

  $ Chro 1.smt2 | sed 's/[[:space:]]*$//'
  unsat (nfa)
