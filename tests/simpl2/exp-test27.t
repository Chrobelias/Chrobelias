  $ export CHRO_TRACE_OPT=1
$ export CHRO_DEBUG=1

  $ Chro -huge-c 100 --dpresimpl --stop-after simpl ../examples/exp-test27.smt2
  Lightweight run:
  (and
                     (= %r1 (* 11 %q4))
                     (= x (+ %r1 (* 29 %q2)))
                     (<= 0 %r1)
                     (<= 0 x)
                     (<= (exp 10 1) (exp 10 strlenx))
                     (<= %r1 28)
                     (<= (exp 10 strlenx) (exp 10 99))
                     (str.in_re.raw x)
                     (chrob.len x (exp 10 strlenx)))
  (and
    (= %r5 (* 11 %q8))
    (= x (+ %r5 (* 29 %q6)))
    (<= 0 %r5)
    (<= 0 x)
    (<= (exp 10 1) (exp 10 strlenx))
    (<= %r5 28)
    (<= (exp 10 strlenx) (exp 10 99))
    (str.in_re.raw x)
    (chrob.len x (exp 10 strlenx)))

  $ unset CHRO_TRACE_OPT
  $ timeout 15 Chro ../examples/exp-test27.smt2 -huge-c 99
  sat (nfa)
  (
     (define-fun x () String
      "1234582822626262626262626262626262626262626262626262626262626262626262626262626")
  )
