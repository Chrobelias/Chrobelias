  $ cat > inter-word.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (str.in_re x (re.inter (str.to_re "ab") (str.to_re "b"))))
  > (check-sat)
  > EOF

  $ Chro -no-parallel inter-word.smt2 | cut -d' ' -f1
  unsat

  $ cat > inter-eps.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (str.in_re x (re.inter (str.to_re "") (str.to_re "a"))))
  > (check-sat)
  > EOF

  $ Chro -no-parallel inter-eps.smt2 | cut -d' ' -f1
  unsat

  $ cat > inter-plus.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (str.in_re x (re.inter (re.+ (str.to_re "ab")) (str.to_re "b"))))
  > (check-sat)
  > EOF

  $ Chro -no-parallel inter-plus.smt2 | cut -d' ' -f1
  unsat

  $ cat > inter-toint.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (str.in_re x (re.inter (str.to_re "12") (str.to_re "2"))))
  > (assert (= (str.to_int x) 2))
  > (check-sat)
  > EOF

  $ Chro -no-parallel inter-toint.smt2 | cut -d' ' -f1
  unsat

  $ cat > inter-concat.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (str.in_re (str.++ x y) (re.++ (re.inter (str.to_re "ab") (str.to_re "b")) (re.* (str.to_re "c")))))
  > (assert (>= (str.len y) 1))
  > (check-sat)
  > EOF

  $ Chro -no-parallel inter-concat.smt2 | cut -d' ' -f1
  unsat
