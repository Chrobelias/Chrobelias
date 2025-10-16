
  $ Chro -dpresimpl ../examples/strings10001.smt2 -flat 0 -under3 -amin 0 -amax 13
  (and
    (= %0 (str.len x))
    (= %0 (+ 1 (str.to.int y)))
    (= (str.++ "10001" x) (str.++ y x)))
  unknown
  ; Under2 resigns
  (and
    (= %0 (str.len x))
    (= %0 (+ 1 (str.to.int y)))
    (= (str.++ "10001" x) (str.++ y x)))
  sat ; under III
