  $ export CHRO_DEBUG=1
  $ timeout 2 Chro -no-over -bound 0 --dsimpl ../../benchmarks/QF_LIA/PURRS/purrs02.smt2 --stop-after presimpl #| sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (not (= (* (+ x n) (exp 2 n)) (+ (* 2
                                              (* (+ x (+ n (* (- 1) 1)))
                                              (exp 2 (+ n (* (- 1) 1)))))
                                           (exp 2 n))))
             (<= (+ 0 1) n))
  iter(2)= (and
             (distinct (+ (* (- 2) (* (- 1) (exp 2 (+ (- 1) n))))
                       (* (- 2) (* n (exp 2 (+ (- 1) n))))
                       (* (- 2) (* x (exp 2 (+ (- 1) n)))) (* (- 1) (exp 2 n))
                       (* n (exp 2 n)) (* x (exp 2 n))) 0)
             (<= 1 n))
  iter(3)= (and
             (distinct (+ (* (- 1) n (exp 2 (+ n))) (* (- 1) x (exp 2 (+ n)))
                       (* (- 1) (exp 2 n)) (* n (exp 2 n)) (* x (exp 2 n))
                       (exp 2 (+ n))) 0)
             (<= 1 n))
  iter(4)= (not True)
  fixed-point
  
  unsat (presimpl int)


