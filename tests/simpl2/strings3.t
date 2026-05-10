  $ cat strings3.smt2
  (set-logic QF_S)
  (declare-const x String)
  (declare-const y String)
  (assert (= (str.++ "999" x) (str.++ y x)))
  (check-sat)
  (get-model)

  $ Chro strings3.smt2 --dpresimpl | sed 's/[[:space:]]*$//'
  Light run:
  (and
               (= strlenx (+ 1 %re_len9))
               (= (+ (* (- 1) y (exp 10 strlenx)) (* 999 (exp 10 strlenx))) 0)
               (<= 0 %re_len9)
               (<= 0 x)
               (<= 0 y)
               (<= 1 strlenx))
  sat (under int)
  (
     (define-fun x () String
      "0")   (define-fun y () String
      "999")
  )
  $ unset CHRO_DEBUG
  $ timeout 8 Chro --dsimpl strings3.smt2
  sat (under int)
  (
     (define-fun x () String
      "0")   (define-fun y () String
      "999")
  )
