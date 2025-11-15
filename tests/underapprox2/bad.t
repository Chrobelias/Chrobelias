$ export CHRO_DEBUG=1
  $ Chro -bound 0 -pre-simpl -dpresimpl bad.smt2 -stop-after simpl | sed 's/[[:space:]]*$//'
  (and
    (and
      (= (+ (* 5 (exp 2 z)) (exp 2 (+ u7 z))) y)
      (<= y 1000000)))
