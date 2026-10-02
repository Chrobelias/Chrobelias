  $ cat > neg-prefixof-self.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (not (str.prefixof y y)))
  > (check-sat)
  > EOF

  $ Chro -no-parallel neg-prefixof-self.smt2 | cut -d' ' -f1
  unsat

  $ cat > neg-suffixof-self.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (not (str.suffixof y y)))
  > (check-sat)
  > EOF

  $ Chro -no-parallel neg-suffixof-self.smt2 | cut -d' ' -f1
  unsat

  $ cat > neg-prefixof-3024.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (assert (= (str.to_int x) 2))
  > (assert (or (not (str.prefixof x x)) (= x "")))
  > (check-sat)
  > EOF

  $ Chro -no-parallel neg-prefixof-3024.smt2 | cut -d' ' -f1
  unsat

  $ cat > neg-prefixof-sat.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (not (str.prefixof x y)))
  > (assert (= y "ab"))
  > (assert (= (str.len x) 1))
  > (check-sat)
  > EOF

  $ Chro -no-parallel --check-model neg-prefixof-sat.smt2 | cut -d' ' -f1
  sat

  $ cat > neg-suffixof-sat.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (not (str.suffixof x y)))
  > (assert (= y "ab"))
  > (assert (= (str.len x) 1))
  > (assert (str.in_re x (re.range "a" "c")))
  > (check-sat)
  > EOF

  $ Chro -no-parallel --check-model neg-suffixof-sat.smt2 | cut -d' ' -f1
  sat

  $ cat > neg-prefixof-vars.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun z () String)
  > (assert (not (str.prefixof z x)))
  > (check-sat)
  > EOF

  $ Chro -no-parallel --check-model neg-prefixof-vars.smt2 | cut -d' ' -f1
  sat
