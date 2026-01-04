  $ export CHRO_TRACE_OPT=1
$ export CHRO_DEBUG=1

  $ Chro -huge 100 --dpresimpl --stop-after simpl ../examples/exp-test27.smt2
  (and
    (= x (+ (* 11 q4) (* 297 q2)))
    (<= (exp 10 0) (exp 10 strlenx))
    (<= q4 26)
    (<= (exp 10 strlenx) (exp 10 99))
    (<= (* (- 1) q4) 0)
    (str.in_re.raw x)
    (chrob.len x (exp 10 strlenx)))

  $ unset CHRO_TRACE_OPT
  $ timeout 15 Chro ../examples/exp-test27.smt2 -huge 100
  sat (nfa)
  ((define-fun q2 () (_ Int) 4156844539)
   (define-fun q4 () (_ Int) 13)
   (define-fun r1 () (_ Int) 143)
   (define-fun r3 () (_ Int) 0)
   (define-fun x () (_ String) "1234582828226"))
