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
  Arithmetization gives 1 asts...
  Arithmetized: (and
                  (= eeb6 strlenx)
                  (<= 0 strlenx)
                  (= eeb5 (+ (* eeb7 (exp 10 eeb6)) eeb8))
                  (= eeb8 x)
                  (= eeb7 123)
                  (= eeb2 strlenx)
                  (<= 0 strlenx)
                  (= eeb1 (+ (* eeb3 (exp 10 eeb2)) eeb4))
                  (= eeb4 x)
                  (= eeb3 321)
                  (= eeb5 eeb1))
  
  Basic simplifications:
  
  iter(1)= (and
             (= eeb6 strlenx)
             (<= 0 strlenx)
             (= eeb5 (+ (* eeb7 (exp 10 eeb6)) eeb8))
             (= eeb8 x)
             (= eeb7 123)
             (= eeb2 strlenx)
             (<= 0 strlenx)
             (= eeb1 (+ (* eeb3 (exp 10 eeb2)) eeb4))
             (= eeb4 x)
             (= eeb3 321)
             (= eeb5 eeb1))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
  
  iter(2)= (and
             (= eeb2 strlenx)
             (= eeb3 321)
             (= eeb4 x)
             (= eeb5 eeb1)
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 strlenx)
             (= eeb7 123)
             (= eeb8 x)
             (<= 0 strlenx))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
        eeb2 -> strlenx;
  
  iter(3)= (and
             (= eeb3 321)
             (= eeb4 x)
             (= eeb5 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 strlenx)
             (= eeb7 123)
             (= eeb8 x)
             (<= 0 strlenx))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
        eeb2 -> strlenx;
        eeb3 -> 321;
  
  iter(4)= (and
             (= eeb4 x)
             (= eeb5 (+ eeb4 (* eeb3 (exp 10 strlenx))))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 strlenx)
             (= eeb7 123)
             (= eeb8 x)
             (<= 0 strlenx))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
        eeb2 -> strlenx;
        eeb3 -> 321;
        eeb4 -> x;
  
  iter(5)= (and
             (= eeb5 (+ eeb4 (* 321 (exp 10 strlenx))))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 strlenx)
             (= eeb7 123)
             (= eeb8 x)
             (<= 0 strlenx))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
        eeb2 -> strlenx;
        eeb3 -> 321;
        eeb4 -> x;
        eeb5 -> (+ eeb8 (* eeb7 (exp 10 eeb6)));
  
  iter(6)= (and
             (= eeb5 (+ x (* 321 (exp 10 strlenx))))
             (= eeb6 strlenx)
             (= eeb7 123)
             (= eeb8 x)
             (<= 0 strlenx))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
        eeb2 -> strlenx;
        eeb3 -> 321;
        eeb4 -> x;
        eeb5 -> (+ eeb8 (* eeb7 (exp 10 eeb6)));
        eeb6 -> strlenx;
  
  iter(7)= (and
             (= eeb7 123)
             (= eeb8 x)
             (= (+ eeb8 (* (- 321) (exp 10 strlenx)) (* (- 1) x)
                (* eeb7 (exp 10 eeb6))) 0)
             (<= 0 strlenx))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
        eeb2 -> strlenx;
        eeb3 -> 321;
        eeb4 -> x;
        eeb5 -> (+ eeb8 (* eeb7 (exp 10 eeb6)));
        eeb6 -> strlenx;
        eeb7 -> 123;
  
  iter(8)= (and
             (= eeb8 x)
             (= (+ eeb8 (* (- 321) (exp 10 strlenx)) (* (- 1) x)
                (* eeb7 (exp 10 strlenx))) 0)
             (<= 0 strlenx))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
        eeb2 -> strlenx;
        eeb3 -> 321;
        eeb4 -> x;
        eeb5 -> (+ eeb8 (* eeb7 (exp 10 eeb6)));
        eeb6 -> strlenx;
        eeb7 -> 123;
        eeb8 -> x;
  
  iter(9)= (and
             (= (+ eeb8 (* (- 198) (exp 10 strlenx)) (* (- 1) x)) 0)
             (<= 0 strlenx))
  iter(10)= (and
              (= (+ x (* (- 198) (exp 10 strlenx)) (* (- 1) x)) 0)
              (<= 0 strlenx))
  Interesting: strlenx
  
  Expecting 0 choices ...
  
  Can't decide in lib/Underapprox.ml
  (and
    (= (+ x (* (- 198) (exp 10 strlenx)) (* (- 1) x)) 0)
    (<= 0 strlenx))
  Vars: ["x"]
  Var x can't be interesting: used somewhere
  (assert (exists (x)
          (and
            (= (+ (* (- 0) x) (* (- 198) pow2(strlenx)) )  0)
            (<= (* (- 1) strlenx)  0)
            )
  )

  $ Chro 1.smt2 | sed 's/[[:space:]]*$//'
  unsat (nfa)
