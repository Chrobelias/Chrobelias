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

  $ cat > neg-contains-concat.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (= x "1"))
  > (assert (not (str.contains (str.++ x y) "1")))
  > (check-sat)
  > EOF

  $ Chro -no-parallel neg-contains-concat.smt2 | cut -d' ' -f1
  unsat

  $ cat > neg-contains-suffix.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (str.suffixof "1" x))
  > (assert (not (str.contains (str.++ x y) "1")))
  > (check-sat)
  > EOF

  $ Chro -no-parallel neg-contains-suffix.smt2 | cut -d' ' -f1
  unsat

  $ cat > fuzz-2143.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (declare-fun z () String)
  > (assert (not (= z "00")))
  > (assert (and (not (str.contains x "0a")) (not (str.contains (str.++ x y) "1"))))
  > (assert (or (not (str.in_re (str.++ x z z) (re.union (re.* re.allchar) (re.++ (str.to_re "a") (re.union (str.to_re "a") re.allchar))))) (str.suffixof "1" x)))
  > (assert (not (>= (str.len x) 2)))
  > (check-sat)
  > EOF

  $ Chro -no-parallel fuzz-2143.smt2 | cut -d' ' -f1
  unsat

  $ cat > under-all-1033.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (declare-fun z () String)
  > (assert (not (and (not (str.suffixof "a" y)) (str.in_re x (str.to_re "a")))))
  > (assert (not (and (= y y) (str.in_re (str.++ x z) (re.* (re.union (re.* (re.range "0" "1")) (re.* re.allchar)))))))
  > (assert (or (not (str.in_re x (re.* (str.to_re "1")))) (not (str.in_re x (re.union (re.+ (str.to_re "ba")) (re.range "a" "c"))))))
  > (check-sat)
  > EOF

  $ Chro -no-parallel -under-all -budget 4 under-all-1033.smt2 | cut -d' ' -f1
  unsat
