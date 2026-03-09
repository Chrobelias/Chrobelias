
  $ Chro -bound 0 --dpresimpl bad.smt2 | sed 's/[[:space:]]*$//'
  (and
    (= %0flat_pow1 (+ u7 z))
    (= (+ (* 5 (exp 2 z)) (exp 2 %0flat_pow1)) y)
    (<= y 1000000))
  sat (under int)
