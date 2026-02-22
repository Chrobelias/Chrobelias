  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "999" x) (str.++ y x)))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro 1.smt2 --dpresimpl | sed 's/[[:space:]]*$//'
  Light run:
  (and
               (= (+ (* (- 1) y (exp 10 strlenx)) (* 999 (exp 10 strlenx))) 0)
               (<= (exp 10 0) (exp 10 strlenx))
               (str.in_re.raw x)
               (str.in_re.raw y)
               (chrob.len x (exp 10 strlenx))
               (chrob.len y 1000)
               x in unsupported concat
               y in unsupported concat)
  Light run:
  (and
               (= (+ (* (- 1) y (exp 10 %re_len9)) (* 999 (exp 10 %re_len9))) 0)
               (<= (exp 10 0) (exp 10 %re_len9))
               (str.in_re.raw y)
               (chrob.len y 1000)
               x in unsupported concat
               y in unsupported concat)
  Light run:
  (and
               (= (+ (* (- 1) y (exp 10 strlenx)) (* 999 (exp 10 strlenx))) 0)
               (<= (exp 10 0) (exp 10 strlenx))
               (str.in_re.raw x)
               (str.in_re.raw y)
               (chrob.len x (exp 10 strlenx))
               (chrob.len y 1000)
               x in unsupported concat
               y in unsupported concat)
  Light run:
  (and
               (= %flat_pow39 (+ 2 %re_len19))
               (= (+ (* (- 1) y (exp 10 %flat_pow39))
                  (* 999 (exp 10 %flat_pow39))) 0)
               (<= 0 %re_len19)
               (<= (* (- 1) %re_len19) 2)
               (str.in_re.raw y)
               (chrob.len y 1000)
               x in unsupported concat
               y in unsupported concat)
  Light run:
  (and
               (= (+ (* (- 1) y (exp 10 strlenx)) (* 999 (exp 10 strlenx))) 0)
               (<= (exp 10 0) (exp 10 strlenx))
               (str.in_re.raw x)
               (str.in_re.raw y)
               (chrob.len x (exp 10 strlenx))
               (chrob.len y 1000)
               x in unsupported concat
               y in unsupported concat)
  Light run:
  (and
               (= %flat_pow40 (+ 3 %re_len28))
               (= (+ (* (- 1) y (exp 10 %flat_pow40))
                  (* 999 (exp 10 %flat_pow40))) 0)
               (<= 0 %re_len28)
               (<= (* (- 1) %re_len28) 3)
               (str.in_re.raw y)
               (chrob.len y 1000)
               x in unsupported concat
               y in unsupported concat)
  sat (under str)
  (
     (define-fun x () String
      "")   (define-fun y () String
      "999")
  )
