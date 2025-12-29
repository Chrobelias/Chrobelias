  $ export CHRO_DEBUG=1
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "999" x) (str.++ y x)))
  > (check-sat)
  > EOF

  $ Chro 1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (str.++ "999" x) (str.++ y x)))
  iter(2)= (= (str.++ "999" x) (str.++ y x))
  Arithmetization gives 1 asts...
  Arithmetized: (and
                  (= eeb6 strlenx)
                  (<= 0 strlenx)
                  (= eeb5 (+ (* eeb7 (exp 10 eeb6)) eeb8))
                  (= eeb8 x)
                  (= eeb7 999)
                  (= eeb2 strlenx)
                  (<= 0 strlenx)
                  (= eeb1 (+ (* eeb3 (exp 10 eeb2)) eeb4))
                  (= eeb4 x)
                  (= eeb3 y)
                  (= eeb5 eeb1))
  
  Basic simplifications:
  
  iter(1)= (and
             (= eeb6 strlenx)
             (<= 0 strlenx)
             (= eeb5 (+ (* eeb7 (exp 10 eeb6)) eeb8))
             (= eeb8 x)
             (= eeb7 999)
             (= eeb2 strlenx)
             (<= 0 strlenx)
             (= eeb1 (+ (* eeb3 (exp 10 eeb2)) eeb4))
             (= eeb4 x)
             (= eeb3 y)
             (= eeb5 eeb1))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
  
  iter(2)= (and
             (= eeb2 strlenx)
             (= eeb3 y)
             (= eeb4 x)
             (= eeb5 eeb1)
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 strlenx)
             (= eeb7 999)
             (= eeb8 x)
             (<= 0 strlenx))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
        eeb2 -> strlenx;
  
  iter(3)= (and
             (= eeb3 y)
             (= eeb4 x)
             (= eeb5 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 strlenx)
             (= eeb7 999)
             (= eeb8 x)
             (<= 0 strlenx))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
        eeb2 -> strlenx;
        eeb3 -> y;
  
  iter(4)= (and
             (= eeb4 x)
             (= eeb5 (+ eeb4 (* eeb3 (exp 10 strlenx))))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 strlenx)
             (= eeb7 999)
             (= eeb8 x)
             (<= 0 strlenx))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
        eeb2 -> strlenx;
        eeb3 -> y;
        eeb4 -> x;
  
  iter(5)= (and
             (= eeb5 (+ eeb4 (* y (exp 10 strlenx))))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 strlenx)
             (= eeb7 999)
             (= eeb8 x)
             (<= 0 strlenx))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
        eeb2 -> strlenx;
        eeb3 -> y;
        eeb4 -> x;
        eeb5 -> (+ eeb8 (* eeb7 (exp 10 eeb6)));
  
  iter(6)= (and
             (= eeb5 (+ x (* y (exp 10 strlenx))))
             (= eeb6 strlenx)
             (= eeb7 999)
             (= eeb8 x)
             (<= 0 strlenx))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
        eeb2 -> strlenx;
        eeb3 -> y;
        eeb4 -> x;
        eeb5 -> (+ eeb8 (* eeb7 (exp 10 eeb6)));
        eeb6 -> strlenx;
  
  iter(7)= (and
             (= eeb7 999)
             (= eeb8 x)
             (= (+ eeb8 (* (- 1) x) (* (- 1) y (exp 10 strlenx))
                (* eeb7 (exp 10 eeb6))) 0)
             (<= 0 strlenx))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
        eeb2 -> strlenx;
        eeb3 -> y;
        eeb4 -> x;
        eeb5 -> (+ eeb8 (* eeb7 (exp 10 eeb6)));
        eeb6 -> strlenx;
        eeb7 -> 999;
  
  iter(8)= (and
             (= eeb8 x)
             (= (+ eeb8 (* (- 1) x) (* (- 1) y (exp 10 strlenx))
                (* eeb7 (exp 10 strlenx))) 0)
             (<= 0 strlenx))
  Something ready to substitute
        eeb1 -> (+ eeb4 (* eeb3 (exp 10 eeb2)));
        eeb2 -> strlenx;
        eeb3 -> y;
        eeb4 -> x;
        eeb5 -> (+ eeb8 (* eeb7 (exp 10 eeb6)));
        eeb6 -> strlenx;
        eeb7 -> 999;
        eeb8 -> x;
  
  iter(9)= (and
             (= (+ eeb8 (* (- 1) x) (* (- 1) y (exp 10 strlenx))
                (* 999 (exp 10 strlenx))) 0)
             (<= 0 strlenx))
  iter(10)= (and
              (= (+ (* (- 1) y (exp 10 strlenx)) (* 999 (exp 10 strlenx))) 0)
              (<= 0 strlenx))
  Interesting: strlenx
  
  Expecting 0 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| strlenx->0 y->999 |}
  sat (under I)
