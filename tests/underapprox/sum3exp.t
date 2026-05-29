$ cat  sum3exp.smt2
  $ export CHRO_DEBUG=1
$ export CHRO_TRACE_OPT=1
 -under2 -amin 0 -amax 11
  $ Chro -no-over -bound 3 --dsimpl sum3exp.smt2
  Basic simplifications:
  
  iter(1)= (and
             (<= (+ (- 10) (exp 2 x1) (exp 2 x2) (exp 2 x3) (* (- 1) x1)
                 (* (- 1) x2) (* (- 1) x3)) 0)
             (<= (+ (exp 2 x1) (* (- 1) x2)) 0)
             (<= (+ 2 (* (- 1) x2)) 0)
             (<= (+ 1 (* (- 1) x2)) 0)
             (<= (* (- 1) x1) 0))
  Alphabet with extra char: 0
  
  iter(2)= (and
             (<= (+ (- 10) (* (- 1) x1) (* (- 1) x2) (* (- 1) x3) (exp 2 x1)
                 (exp 2 x2) (exp 2 x3)) 0)
             (<= (+ 1 (* (- 1) x2)) 0)
             (<= (+ 2 (* (- 1) x2)) 0)
             (<= (+ (* (- 1) x2) (exp 2 x1)) 0)
             (<= (* (- 1) x1) 0))
  fixed-point
  
  Bound for underapproximation: 4
  
  Interesting: x1 x2 x3
  
  Expecting 64 choices ...
  
  lib/Underapprox.ml gives early Sat.
  sat (under int)

