  $ cat > neg-concat-all.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (str.in_re x (re.* (re.union (str.to_re "0") (str.to_re "1")))))
  > (assert (str.in_re y (re.* (re.union (str.to_re "0") (str.to_re "1")))))
  > (assert (not (str.in_re (str.++ x y) (re.* (re.union (str.to_re "0") (str.to_re "1"))))))
  > (check-sat)
  > EOF

  $ Chro -no-parallel neg-concat-all.smt2 | cut -d' ' -f1
  unsat

  $ cat > neg-concat-prefix.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (str.in_re x (str.to_re "1")))
  > (assert (str.in_re y (re.* (re.union (str.to_re "0") (str.to_re "1")))))
  > (assert (not (str.in_re (str.++ x y) (re.++ (str.to_re "1") (re.* (re.union (str.to_re "0") (str.to_re "1")))))))
  > (check-sat)
  > EOF

  $ Chro -no-parallel neg-concat-prefix.smt2 | cut -d' ' -f1
  unsat

  $ cat > neg-const-concat.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (str.in_re y (re.* (re.union (str.to_re "0") (str.to_re "1")))))
  > (assert (not (str.in_re (str.++ "1" y) (re.++ (str.to_re "1") (re.* (re.union (str.to_re "0") (str.to_re "1")))))))
  > (check-sat)
  > EOF

  $ Chro -no-parallel neg-const-concat.smt2 | cut -d' ' -f1
  unsat

  $ cat > neg-concat-const.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (str.in_re y (re.* (re.union (str.to_re "0") (str.to_re "1")))))
  > (assert (not (str.in_re (str.++ y "1") (re.++ (re.* (re.union (str.to_re "0") (str.to_re "1"))) (str.to_re "1")))))
  > (check-sat)
  > EOF

  $ Chro -no-parallel neg-concat-const.smt2 | cut -d' ' -f1
  unsat

  $ cat > neg-concat-const-var.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (= x "1"))
  > (assert (not (str.in_re (str.++ x y) (re.++ (str.to_re "1") re.all))))
  > (check-sat)
  > EOF

  $ Chro -no-parallel neg-concat-const-var.smt2 | cut -d' ' -f1
  unsat
