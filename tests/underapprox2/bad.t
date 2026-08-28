
  $ Chro -bound 0 --dpresimpl bad.smt2 | sed 's/[[:space:]]*$//'
  (and
    (= (+ %stdexp3 (* (- 1) x) (* (- 1) z)) 0)
    (<= (+ (- 1000000) (** 2 %stdexp3) (* 5 (** 2 z))) 0)
    (<= (+ (* (- 1) x) (* (- 1) z)) 0)
    (<= (* (- 1) z) 0))
  sat (under int)
