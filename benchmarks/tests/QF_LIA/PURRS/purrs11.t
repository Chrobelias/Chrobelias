purrs11
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs11.smt2 || echo TIMEOUT
  unknown
  ; converting to automaton expression: unimplemented (= (+ (* n n (exp 2 (+ (- 1) n))) (* n x1 (exp 2 (+ (- 1) n)))
                   (* x0 (exp 2 n)) (* (- 20) n (exp 2 (+ (- 3) n)))
                   (* (- 16) x0 (exp 2 (+ (- 2) n)))
                   (* (- 8) n x0 (exp 2 (+ (- 3) n)))
                   (* (- 8) x1 (exp 2 (+ (- 3) n)))
                   (* (- 8) (exp 2 (+ (- 2) n)))
                   (* (- 4) n n (exp 2 (+ (- 2) n)))
                   (* (- 4) n x1 (exp 2 (+ (- 2) n))) (* (- 1) n x0 (exp 2 n))
                   (* (- 1) n (exp 2 (+ (- 1) n))) (* (- 1) (exp 2 n))
                   (* 4 n n (exp 2 (+ (- 3) n))) (* 4 n x1 (exp 2 (+ (- 3) n)))
                   (* 4 x1 (exp 2 (+ (- 2) n))) (* 8 n x0 (exp 2 (+ (- 2) n)))
                   (* 12 n (exp 2 (+ (- 2) n))) (* 24 x0 (exp 2 (+ (- 3) n)))
                   (* 24 (exp 2 (+ (- 3) n)))) 0)
