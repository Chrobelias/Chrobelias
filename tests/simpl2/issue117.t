
  $ CHRO_DEBUG=1 Chro -no-over -bound -1 --dpresimpl --stop-after presimpl issue117.smt2  | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (<= (+ 100 (* (- 1) x) (* (- 1) y) (* (- 1) z) (* (- 1) u)
                 (* (- 1) v)) 0)
             (= (+ (exp 2 (+ (- 5) x)) (* (- 1) v)) 0)
             (= (+ (exp 2 (+ (- 3) x)) (* (- 1) u)) 0)
             (= (+ (exp 2 (+ (- 1) x)) (* (- 1) z)) 0)
             (= (+ (exp 2 x) (* (- 1) y)) 0))
  Alphabet with extra char: 0
  
  Something ready to substitute
        u -> (exp 2 (+ (- 3) x));
  
  iter(2)= (and
             (= (+ (* (- 1) u) (exp 2 (+ (- 3) x))) 0)
             (= (+ (* (- 1) v) (exp 2 (+ (- 5) x))) 0)
             (= (+ (* (- 1) y) (exp 2 x)) 0)
             (= (+ (* (- 1) z) (exp 2 (+ (- 1) x))) 0)
             (<= (+ 100 (* (- 1) x) (* (- 1) y) (* (- 1) z) (* (- 1) u)
                 (* (- 1) v)) 0))
  Something ready to substitute
        u -> (exp 2 (+ (- 3) x));
        v -> (exp 2 (+ (- 5) x));
  
  iter(3)= (and
             (= (+ (* (- 1) v) (exp 2 (+ (- 5) x))) 0)
             (= (+ (* (- 1) y) (exp 2 x)) 0)
             (= (+ (* (- 1) z) (exp 2 (+ (- 1) x))) 0)
             (<= (+ 100 (* (- 1) x) (* (- 1) y) (* (- 1) z) (* (- 1) v)
                 (* (- 1) (exp 2 (+ (- 3) x)))) 0))
  Something ready to substitute
        u -> (exp 2 (+ (- 3) x));
        v -> (exp 2 (+ (- 5) x));
        y -> (exp 2 x);
  
  iter(4)= (and
             (= (+ (* (- 1) y) (exp 2 x)) 0)
             (= (+ (* (- 1) z) (exp 2 (+ (- 1) x))) 0)
             (<= (+ 100 (* (- 1) x) (* (- 1) y) (* (- 1) z)
                 (* (- 1) (exp 2 (+ (- 5) x))) (* (- 1) (exp 2 (+ (- 3) x)))) 0))
  Something ready to substitute
        u -> (exp 2 (+ (- 3) x));
        v -> (exp 2 (+ (- 5) x));
        y -> (exp 2 x);
        z -> (exp 2 (+ (- 1) x));
  
  iter(5)= (and
             (= (+ (* (- 1) z) (exp 2 (+ (- 1) x))) 0)
             (<= (+ 100 (* (- 1) x) (* (- 1) z) (* (- 1) (exp 2 x))
                 (* (- 1) (exp 2 (+ (- 5) x))) (* (- 1) (exp 2 (+ (- 3) x)))) 0))
  iter(6)= (<= (+ 100 (* (- 1) x) (* (- 1) (exp 2 (+ (- 1) x)))
               (* (- 1) (exp 2 x)) (* (- 1) (exp 2 (+ (- 5) x)))
               (* (- 1) (exp 2 (+ (- 3) x)))) 0)
  fixed-point
  
  (and
    (= (+ 3 %0flat_pow3 (* (- 1) x)) 0)
    (= (+ 5 %0flat_pow2 (* (- 1) x)) 0)
    (= (+ 1 %0flat_pow1 (* (- 1) x)) 0)
    (<= (+ 100 (* (- 1) x) (* (- 1) (exp 2 %0flat_pow1)) (* (- 1) (exp 2 x))
        (* (- 1) (exp 2 %0flat_pow2)) (* (- 1) (exp 2 %0flat_pow3))) 0))
  $ Chro -no-over -bound -1 issue117.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)

