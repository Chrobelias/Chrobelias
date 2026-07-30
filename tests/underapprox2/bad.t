
  $ Chro -bound 0 --dpresimpl bad.smt2 | sed 's/[[:space:]]*$//'
  (and
    (= (+ %0flat_pow1 (* (- 1) x) (* (- 1) z)) 0)
    (<= (+ (- 1000000) (* 5 (exp 2 z)) (exp 2 %0flat_pow1)) 0))
  sat (under int)
