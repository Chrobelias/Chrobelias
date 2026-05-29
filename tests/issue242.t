  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun A () String)
  > (declare-fun B () Int)
  > (declare-fun E () Int)
  > (assert (str.in.re A (re.+ (str.to.re "1"))))
  > (assert (= 0 (+ (* 2 (str.to_int A)) (* (- 1) B) (* 3 E))))
  > (assert (= 0 (+ (* 1 (str.to_int A)) (* (- 3) B) (* 4 E))))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro 1.smt2
  sat (under int)
  (
     (define-fun A () String
      "1")
     (define-fun B () Int
      -1)
     (define-fun E () Int
      -1)
  )
