((_ re.loop l r) e) denotes e^l | ... | e^r. The parser used to add r optional
copies after the l mandatory ones, so a fourth digit was accepted below and
the string underapproximation returned a model that violates the constraint.

  $ cat > re-loop.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (assert (str.in_re x (re.++ (str.to_re "58") ((_ re.loop 1 3) (re.range "4" "9")))))
  > (assert (>= (str.len x) 6))
  > (check-sat)
  > EOF

  $ Chro -no-parallel re-loop.smt2 | head -1
  unsat (lengths)

  $ cat > re-loop-sat.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (assert (str.in_re x (re.++ (str.to_re "58") ((_ re.loop 1 3) (re.range "4" "9")))))
  > (assert (>= (str.len x) 5))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro -no-parallel re-loop-sat.smt2
  sat (under int)
  (
     (define-fun x () String
      "58444")
  )
