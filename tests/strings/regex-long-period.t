  $ cat > len.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (assert (str.in_re x (re.+ (str.to_re "aaaaaaaaaaaaaaaaaaaaaaa"))))
  > (assert (= (str.len x) 402))
  > (check-sat)
  > EOF

  $ Chro -no-parallel len.smt2 | cut -d' ' -f1
  unsat

  $ cat > to-int.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (str.in_re x (re.+ (str.to_re "aaaaaaaaaaaaaaaaaaaaaaa"))))
  > (assert (str.in_re y (re.+ (re.range "0" "9"))))
  > (assert (= (str.len x) (str.to_int y)))
  > (assert (< 400 (str.to_int y)))
  > (assert (< (str.to_int y) 404))
  > (check-sat)
  > EOF

  $ Chro -no-parallel to-int.smt2 | cut -d' ' -f1
  unsat
