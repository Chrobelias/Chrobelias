  $ cat > 1.smt2 <<-EOF
  > (set-info :smt-lib-version 2.6)
  > (set-logic ALL)
  > (declare-fun x_0 () String)
  > (declare-fun x_1 () String)
  > (assert (>= (str.to_int x_0) 0))
  > (assert (>= (str.to_int x_1) 0))
  > (assert (str.in_re x_0 (re.* (str.to_re "123"))))
  > (assert (str.in_re x_1 (re.* (str.to_re "321"))))
  > (assert (= 1 (+ (* 3 (str.to_int x_0)) (* (- 1) (str.to_int x_1)))))
  > (check-sat)

  $ Chro 1.smt2 --no-str-bv
  unsat (nfa)
