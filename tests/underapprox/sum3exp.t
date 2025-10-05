$ cat  sum3exp.smt2
  $ export CHRO_DEBUG=1
$ export CHRO_TRACE_OPT=1
 -under2 -amin 0 -amax 11
  $ Chro -no-over-approx -bound 3 -dsimpl  sum3exp.smt2
  iter(1)= (and
             (<= (+ (+ (exp 2 x1) (exp 2 x2)) (exp 2 x3)) (+ (+ (+ x1 x2) x3)
                                                          10))
             (<= (exp 2 x1) x2)
             (<= 2 x2)
             (<= 1 x2)
             (<= 0 x1))
  iter(2)= (and
             (<= 0 x1)
             (<= 1 x2)
             (<= 2 x2)
             (<= (+ (- 10) (* (- 1) x1) (* (- 1) x2) (* (- 1) x3) (exp 2 x1)
                 (exp 2 x2) (exp 2 x3)) 0)
             (<= (exp 2 x1) x2))
  iter(3)= (and
             (<= 0 x1)
             (<= 1 x2)
             (<= 2 x2)
             (<= (+ (* (- 1) x1) (* (- 1) x2) (* (- 1) x3) (exp 2 x1)
                 (exp 2 x2) (exp 2 x3)) 10)
             (<= (exp 2 x1) x2))
  Interesting: x1 x2 x3
  
  Expecting 27 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| x1->0 x2->2 x3->0 |}
  sat ; underapprox1

