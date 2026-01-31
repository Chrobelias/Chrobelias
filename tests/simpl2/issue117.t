
  $ CHRO_DEBUG=1 Chro -no-over -bound -1 --dpresimpl --stop-after presimpl issue117.smt2  | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (<= 100 (+ (+ (+ (+ x y) z) u) v))
             (= (exp 2 (+ x (* (- 1) 5))) v)
             (= (exp 2 (+ x (* (- 1) 3))) u)
             (= (exp 2 (+ x (* (- 1) 1))) z)
             (= (exp 2 x) y))
  Lib__SimplII.propagate_exponents.check: (exp 2 (+ x)) -> (* 32 v)
  Lib__SimplII.propagate_exponents.check: (exp 2 (+ x)) -> (* 32 v)
  iter(2)= (and
             (= (exp 2 x) y)
             (= (* 32 v) (* 2 z))
             (= (* 32 v) (* 8 u))
             (= (exp 2 (+ x)) (* 32 v))
             (<= (+ (* (- 1) u) (* (- 1) v) (* (- 1) x) (* (- 1) y)
                 (* (- 1) z)) (- 100)))
  Lib__SimplII.propagate_exponents.check: (exp 2 x) -> (* 32 v)
  iter(3)= (and
             (= (* 4 v) (* 1 u))
             (= (* 16 v) (* 1 z))
             (= (* 32 v) y)
             (= (exp 2 x) (* 32 v))
             (<= (+ (* (- 1) u) (* (- 1) v) (* (- 1) x) (* (- 1) y)
                 (* (- 1) z)) (- 100)))
  iter(4)= (and
             (= (* 4 v) u)
             (= (* 16 v) z)
             (= (* 32 v) y)
             (= (exp 2 x) (* 32 v))
             (<= (+ (* (- 1) u) (* (- 1) v) (* (- 1) x) (* (- 1) y)
                 (* (- 1) z)) (- 100)))
  fixed-point
  
  (and
    (= (* 4 v) u)
    (= (* 16 v) z)
    (= (* 32 v) y)
    (= (exp 2 x) (* 32 v))
    (<= (+ (* (- 1) u) (* (- 1) v) (* (- 1) x) (* (- 1) y) (* (- 1) z)) (- 100)))
  $ Chro -no-over -bound -1 issue117.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)

