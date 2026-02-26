  $ cat strings3.smt2
  (set-logic QF_S)
  (declare-const x String)
  (declare-const y String)
  (assert (= (str.++ "999" x) (str.++ y x)))
  (check-sat)
  (get-model)

  $ Chro strings3.smt2 --dpresimpl | sed 's/[[:space:]]*$//'
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
