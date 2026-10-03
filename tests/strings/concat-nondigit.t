  $ cat > nondigit-head.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (assert (not (= x (str.++ "a" x x))))
  > (assert (>= (str.to_int x) 0))
  > (assert (>= (str.len x) 6))
  > (check-sat)
  > EOF

  $ Chro -no-parallel nondigit-head.smt2 | cut -d' ' -f1
  unknown
