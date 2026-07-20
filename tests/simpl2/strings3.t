  $ cat strings3.smt2
  (set-logic QF_S)
  (declare-const x String)
  (declare-const y String)
  (assert (= (str.++ "999" x) (str.++ y x)))
  (check-sat)
  (get-model)

  $ Chro strings3.smt2 --dpresimpl | sed 's/[[:space:]]*$//'
  sat (presimpl str)
  (
     (define-fun x () String
      "")
     (define-fun y () String
      "999")
  )
  $ unset CHRO_DEBUG
  $ timeout 8 Chro --dsimpl strings3.smt2
  sat (presimpl str)
  (
     (define-fun x () String
      "")
     (define-fun y () String
      "999")
  )
