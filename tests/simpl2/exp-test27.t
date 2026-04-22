  $ export CHRO_TRACE_OPT=1
$ export CHRO_DEBUG=1

  $ Chro -huge-c 100 --dpresimpl --stop-after simpl ../examples/exp-test27.smt2
  (and
    (= (+ (* (- 11) %q4) (* (- 29) %q2) x) 0)
    (<= (+ (- 99) strlenx) 0)
    (<= (+ (- 28) (* (- 29) %q2) x) 0)
    (<= (+ (* 29 %q2) (* (- 1) x)) 0)
    (<= (* (- 1) strlenx) 0)
    (<= (* (- 1) x) 0)
    (str.in_re.raw x)
    (chrob.len x (exp 10 strlenx)))

  $ unset CHRO_TRACE_OPT
  $ timeout 15 Chro ../examples/exp-test27.smt2 -huge-c 100
  sat (nfa)
  (
     (define-fun x () String
      "1234582828282828282828282828282828282828282828282828282828282828282262626262626")
  )
