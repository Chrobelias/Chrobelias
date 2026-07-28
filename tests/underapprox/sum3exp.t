$ cat  sum3exp.smt2
  $ export CHRO_DEBUG=simpl
$ export CHRO_TRACE_OPT=1
 -under2 -amin 0 -amax 11
  $ Chro -no-over -bound 3 --dsimpl sum3exp.smt2
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ (- 10) (exp 2 x1) (exp 2 x2) (exp 2 x3) (* (- 1) x1)
                 (* (- 1) x2) (* (- 1) x3)) 0)
             (<= (+ (exp 2 x1) (* (- 1) x2)) 0)
             (<= (+ 2 (* (- 1) x2)) 0)
             (<= (+ 1 (* (- 1) x2)) 0)
             (<= (* (- 1) x1) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (and
             (<= (+ (- 10) (* (- 1) x1) (* (- 1) x2) (* (- 1) x3) (exp 2 x1)
                 (exp 2 x2) (exp 2 x3)) 0)
             (<= (+ 1 (* (- 1) x2)) 0)
             (<= (+ 2 (* (- 1) x2)) 0)
             (<= (+ (* (- 1) x2) (exp 2 x1)) 0)
             (<= (* (- 1) x1) 0))
  [+simpl]
    fixed-point
  
  sat (under int)

