  $ cat > 1.smt2 <<-EOF
  > (set-info :smt-lib-version 2.6)
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (declare-const m String)
  > (assert (= (str.++ y x) m))
  > (assert (> (str.to_int x) (str.to_int m)))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro 1.smt2
  sat (under int)
  (
     (define-fun m () String
      " 0")
     (define-fun x () String
      "0")
     (define-fun y () String
      " ")
  )
