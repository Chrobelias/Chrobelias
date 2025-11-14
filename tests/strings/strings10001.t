
  $ Chro -flat 0 -amin 0 -amax 13 --dpresimpl ../examples/strings10001.smt2
  (and
    (= eeb2 (str.len x))
    (= eeb2 (+ 1 (str.to.int y)))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb4 (* 10001 (exp 10 eeb2))))
    (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb2))))
    (= eeb7 (str.to.int y))
    (= eeb8 (str.to.int x)))
  sat (under II)
