  $ cat > test.smt2 <<-EOF
  > (set-logic QF_S)
  > (set-info :status sat)
  > 
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.len x) 2))
  > (assert (= x y))
  > (assert (str.in_re y (re.+ (re.range "\n" "|"))))
  > (assert (str.contains "']1" x))
  > (check-sat)
  > EOF
  $ Chro test.smt2
