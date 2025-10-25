
  $ Chro -dpresimpl ../examples/strings10001.smt2 -flat 0 -amin 0 -amax 13
  (and
    (= %0 (str.from_int eeb1))
    (= %0 (str.from_int eeb5))
    (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
    (= eeb2 (str.len x))
    (= eeb2 (+ 1 (str.to.int y)))
    (= eeb3 (str.to.int y))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb8 (* 10001 (exp 10 eeb2))))
    (= eeb8 (str.to.int x)))
  sat (under II)
