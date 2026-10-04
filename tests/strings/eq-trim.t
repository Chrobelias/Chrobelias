  $ cat > suffix.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun w () String)
  > (assert (= "ab" (str.++ w "b")))
  > (check-sat)
  > EOF

  $ Chro -no-parallel suffix.smt2 | cut -d' ' -f1
  sat

  $ cat > suffix-neq.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun w () String)
  > (assert (= "ab" (str.++ w "c")))
  > (check-sat)
  > EOF

  $ Chro -no-parallel suffix-neq.smt2 | cut -d' ' -f1
  unsat
