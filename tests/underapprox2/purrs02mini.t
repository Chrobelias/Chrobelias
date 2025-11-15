  $ export CHRO_DEBUG=1
  $ timeout 2 Chro -no-over-approx -bound 0 -dsimpl -amin 1 -amax 11 ../../benchmarks/QF_LIA/PURRS/purrs02.smt2 -stop-after presimpl #| sed 's/[[:space:]]*$//'
  After strlen lowering:
  (and
    (not (= (* (+ x n) (exp 2 n)) (+ (* 2
                                     (* (+ x (+ n (* (- 1) 1)))
                                     (exp 2 (+ n (* (- 1) 1)))))
                                  (exp 2 n))))
    (<= (+ 0 1) n))
  
  iter(1)= (and
             (not (= (* (+ x n) (exp 2 n)) (+ (* 2
                                              (* (+ x (+ n (* (- 1) 1)))
                                              (exp 2 (+ n (* (- 1) 1)))))
                                           (exp 2 n))))
             (<= (+ 0 1) n))
  iter(2)= (and
             (not (= (+ (* (- 2) (* (- 1) (exp 2 (+ (- 1) n))))
                     (* (- 2) (* n (exp 2 (+ (- 1) n))))
                     (* (- 2) (* x (exp 2 (+ (- 1) n)))) (* (- 1) (exp 2 n))
                     (* n (exp 2 n)) (* x (exp 2 n))) 0))
             (<= 1 n))
  iter(3)= (and
             (not (= (+ (* (- 1) n (exp 2 (+ n))) (* (- 1) x (exp 2 (+ n)))
                     (* (- 1) (exp 2 n)) (* n (exp 2 n)) (* x (exp 2 n))
                     (exp 2 (+ n))) 0))
             (<= 1 n))
  iter(4)= (not True)
  unsat



  $ cat > XXXX.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun i3 () Int)
  > (declare-fun it134 () Int)
  > (declare-fun it1110 () Int)
  > (assert (and
  >  (not (= (+ (* n 1)
  >             (exp 2 n))
  >             (+ u v)))
  >           (<= 1 n))
  > )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl XXXX.smt2 | sed 's/[[:space:]]*$//'
  After strlen lowering:
  (and
    (and
      (not (= (+ (* n 1) (exp 2 n)) (+ u v)))
      (<= 1 n)))
  
  iter(1)= (and
             (and
               (not (= (+ (* n 1) (exp 2 n)) (+ u v)))
               (<= 1 n)))
  iter(2)= (and
             (not (= (+ n (* (- 1) u) (* (- 1) v) (exp 2 n)) 0))
             (<= 1 n))
  Interesting: n
  
  Expecting 2 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| n->1 u->0 v->0 |}
  sat (under I)
