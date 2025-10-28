$ export CHRO_DEBUG=1
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "999" x) (str.++ y x)))
  > (check-sat)
  > ;(get-model)
  > EOF

  $ Chro 1.smt2 -flat 0 -amin 0 -amax 0 | sed 's/[[:space:]]*$//'
  sat (under II)
