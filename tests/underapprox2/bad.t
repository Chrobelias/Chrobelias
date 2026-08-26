
  $ Chro -bound 0 --dpresimpl bad.smt2 | sed 's/[[:space:]]*$//'
  (and
    (= (+ %0flat_pow2 (* (- 1) x) (* (- 1) z)) 0)
    (<= (+ (- 1000000) (* 5 (** 2 z)) (** 2 %0flat_pow2)) 0))
  sat (under int)
