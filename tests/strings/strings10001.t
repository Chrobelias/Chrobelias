
$ Chro -flat 0 -amin 0 -amax 13 --dpresimpl ../examples/strings10001.smt2
(and
(= (+ (* (- 1) y (exp 10 (+ 1 y))) (* 10001 (exp 10 (+ 1 y)))) 0)
(<= (* (- 1) y) 1))
sat (under II)
