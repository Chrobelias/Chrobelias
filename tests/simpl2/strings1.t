  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "999" x) (str.++ y x)))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro 1.smt2 --dpresimpl | sed 's/[[:space:]]*$//'
  Lightweight run:
  (and
                     (= (+ (* (- 1) y (exp 10 strlenx))
                        (* 999 (exp 10 strlenx))) 0)
                     (<= 0 x)
                     (<= 0 y)
                     (<= (exp 10 1) (exp 10 strlenx))
                     (str.in_re.raw x)
                     (str.in_re.raw y))
  Lightweight run:
  (and
                     (<= 0 %re_len29)
                     (<= 0 y)
                     (str.in_re.raw y)
                     str var x in unsupported concat)
  Lightweight run:
  (and
                     (= (+ (* (- 1) y (exp 10 strlenx))
                        (* 999 (exp 10 strlenx))) 0)
                     (<= 0 x)
                     (<= 0 y)
                     (<= (exp 10 1) (exp 10 strlenx))
                     (str.in_re.raw x)
                     (str.in_re.raw y))
  Lightweight run:
  (and
                     (<= 0 %re_len69)
                     (<= 0 y)
                     (<= (* (- 1) %re_len69) 2)
                     (str.in_re.raw y)
                     str var x in unsupported concat)
  Lightweight run:
  (and
                     (= (+ (* (- 1) y (exp 10 strlenx))
                        (* 999 (exp 10 strlenx))) 0)
                     (<= 0 x)
                     (<= 0 y)
                     (<= (exp 10 1) (exp 10 strlenx))
                     (str.in_re.raw x)
                     (str.in_re.raw y))
  Lightweight run:
  (and
                     (<= 0 %re_len108)
                     (<= 0 y)
                     (<= (* (- 1) %re_len108) 3)
                     (str.in_re.raw y)
                     str var x in unsupported concat)
  sat (under str)
  (
     (define-fun x () String
      "")   (define-fun y () String
      "999")
  )
