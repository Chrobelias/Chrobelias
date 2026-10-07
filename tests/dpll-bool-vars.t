  $ cat > bool-str.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun b () Bool)
  > (assert (or b (= x "a")))
  > (assert (not (= x "a")))
  > (check-sat)
  > EOF

  $ Chro -no-parallel bool-str.smt2 | cut -d' ' -f1
  sat
