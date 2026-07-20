
  $ CHRO_DEBUG=1 Chro -no-over -bound -1 --dpresimpl --stop-after presimpl issue117.smt2  | sed 's/[[:space:]]*$//'
  (and
    (= (+ 5 %0flat_pow3 (* (- 1) x)) 0)
    (= (+ 3 %0flat_pow2 (* (- 1) x)) 0)
    (= (+ 1 %0flat_pow1 (* (- 1) x)) 0)
    (<= (+ 100 (* (- 1) x) (* (- 1) (exp 2 x)) (* (- 1) (exp 2 %0flat_pow1))
        (* (- 1) (exp 2 %0flat_pow2)) (* (- 1) (exp 2 %0flat_pow3))) 0))
  $ Chro -no-over -bound -1 issue117.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)

