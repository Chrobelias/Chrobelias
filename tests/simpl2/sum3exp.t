$ cat  sum3exp.smt2
  $ export CHRO_DEBUG=1
  $ export CHRO_TRACE_OPT=1
  $ Chro --dsimpl --stop-after pre-simpl -bound 3 ../underapprox/sum3exp.smt2
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
  


