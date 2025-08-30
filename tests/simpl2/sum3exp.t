$ cat  sum3exp.smt2
  $ export CHRO_DEBUG=1
  $ export CHRO_TRACE_OPT=1
$ ls ../underapprox
  $ Chro -dsimpl -pre-simpl -stop-after pre-simpl -bound 3 ../underapprox/sum3exp.smt2
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
  iter(3.0)= (and
               (not True)
               (not True)
               (<= (+ (exp 2 0) (exp 2 0) (exp 2 0)) 10)
               (<= (exp 2 0) 0))
  iter(3.1)= (and
               (not True)
               (not True)
               (not True))
  iter(3.2)= (not True)
  iter(3.1)= (and
               (not True)
               (not True)
               (<= (+ (exp 2 0) (exp 2 0) (exp 2 1)) 11)
               (<= (exp 2 1) 0))
  iter(3.2)= (and
               (not True)
               (not True)
               (not True))
  iter(3.3)= (not True)
  iter(3.2)= (and
               (not True)
               (not True)
               (<= (+ (exp 2 0) (exp 2 0) (exp 2 2)) 12)
               (<= (exp 2 2) 0))
  iter(3.3)= (and
               (not True)
               (not True)
               (not True))
  iter(3.4)= (not True)
  iter(3.3)= (and
               (not True)
               (<= (+ (exp 2 0) (exp 2 0) (exp 2 1)) 11)
               (<= (exp 2 0) 1))
  iter(3.4)= (and
               (not True))
  iter(3.5)= (not True)
  iter(3.4)= (and
               (not True)
               (<= (+ (exp 2 0) (exp 2 1) (exp 2 1)) 12)
               (<= (exp 2 1) 1))
  iter(3.5)= (and
               (not True)
               (not True))
  iter(3.6)= (not True)
  iter(3.5)= (and
               (not True)
               (<= (+ (exp 2 0) (exp 2 1) (exp 2 2)) 13)
               (<= (exp 2 2) 1))
  iter(3.6)= (and
               (not True)
               (not True))
  iter(3.7)= (not True)
  iter(3.6)= (and
               (<= (+ (exp 2 0) (exp 2 0) (exp 2 2)) 12)
               (<= (exp 2 0) 2))
  iter(3.7)= True
  sat (underappox)


