  $ export CHRO_DEBUG=1
  $ timeout 2 Chro -no-over-approx -bound 0 -dsimpl -amin 1 -amax 11 ../../benchmarks/QF_LIA/PURRS/purrs02.smt2 -stop-after presimpl #| sed 's/[[:space:]]*$//'
  iter(1)= (and
             (not (= (* (+ x n) (exp 2 n)) (+ (* 2
                                              (* (+ x (+ n (* (- 1) 1)))
                                              (exp 2 (+ n (* (- 1) 1)))))
                                           (exp 2 n))))
             (<= (+ 0 1) n))
  iter(2)= (and
             (not (= (+ (* n (exp 2 n)) (* x (exp 2 n))
                     (* (- 2) (* n (exp 2 (+ (- 1) n))))
                     (* (- 2) (* x (exp 2 (+ (- 1) n))))
                     (* (- 2) (* (- 1) (exp 2 (+ (- 1) n))))
                     (* (- 1) (exp 2 n))) 0))
             (<= 1 n))
  iter(3)= (and
             (not (= (+ (* n (exp 2 n)) (* x (exp 2 n))
                     (* (- 1) n (exp 2 (+ n))) (* (- 1) x (exp 2 (+ n)))
                     (* (- 1) (exp 2 n)) (exp 2 (+ n))) 0))
             (<= 1 n))
  iter(4)= (not True)
  unsat (presimpl)


