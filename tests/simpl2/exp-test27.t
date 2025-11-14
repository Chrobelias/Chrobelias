  $ export CHRO_TRACE_OPT=1
$ export CHRO_DEBUG=1

  $ Chro -huge 100 --dpresimpl --stop-after simpl ../examples/exp-test27.smt2
  (and
    (= %0 (str.len x))
    (= r1 (* 811 q4))
    (= (str.to.int x) (+ r1 (* 5297 q2)))
    (<= %0 99)
    (<= r1 5296)
    (<= 0 r1)
    (str.in_re x (re.++ (re.++ (re.++ (re.++ (re.++ (str.to.re "6") (str.to.re "2")) (re.* (re.++ (str.to.re "6") (str.to.re "2")))) (re.++ (re.++ (str.to.re "2") (str.to.re "8")) (re.* (re.++ (str.to.re "2") (str.to.re "8"))))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  old ast: (and
             (= %2 (chrob.len x))
             (= (+ x (* (- 5297) q2) (* (- 811) q4)) 0)
             (= (+ (* (- 1) %2) (exp 10 %1)) 1)
             (<= %1 99)
             (<= q4 6)
             (<= (* (- 1) q4) 0)
             (str.in_re x (re.++ (re.++ (re.++ (re.++ (re.++ (str.to.re "6") (str.to.re "2")) (re.* (re.++ (str.to.re "6") (str.to.re "2")))) (re.++ (re.++ (str.to.re "2") (str.to.re "8")) (re.* (re.++ (str.to.re "2") (str.to.re "8"))))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  Old info:
    Exp: %1
    Str: x
    ALL: %1 %2 q2 q4 x
  new ast: (and
             (= %2 (chrob.len x))
             (= (+ x (* (- 5297) q2) (* (- 811) q4)) 0)
             (= (+ (* (- 1) %2) (exp 10 %1)) 1)
             (<= (exp 10 %1) (exp 10 99))
             (<= q4 6)
             (<= (* (- 1) q4) 0)
             (str.in_re x (re.++ (re.++ (re.++ (re.++ (re.++ (str.to.re "6") (str.to.re "2")) (re.* (re.++ (str.to.re "6") (str.to.re "2")))) (re.++ (re.++ (str.to.re "2") (str.to.re "8")) (re.* (re.++ (str.to.re "2") (str.to.re "8"))))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  New info:
    Exp: %1
    Str: x
    ALL: %1 %2 q2 q4 x

  $ unset CHRO_TRACE_OPT
  $ timeout 15 Chro ../examples/exp-test27.smt2 -huge 100
  unsat (nfa)
  no model
