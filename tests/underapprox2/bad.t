
  $ Chro -bound 0 -pre-simpl -dpresimpl bad.smt2 | sed 's/[[:space:]]*$//'
  (and
    (= (+ (* 5 (exp 2 z)) (exp 2 (+ u7 z))) y)
    (<= y 1000000))
  sat ; nfa
