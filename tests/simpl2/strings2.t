$ export CHRO_DEBUG=1
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "123" x) (str.++ y x)))
  > (assert (= y "321"))
  > (check-sat)
  > EOF

  $ Chro -pre-simpl -dpresimpl -dsimpl -stop-after simpl 1.smt2 | sed 's/[[:space:]]*$//'
  (and
    (= %0 (str.from_int eeb5))
    (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
    (= eeb2 (str.len x))
    (= eeb5 (+ eeb8 (* 123 (exp 10 eeb2)))))
  unknown (nfa; unable to multiply var by var: (pow2(eeb2) )  with (eeb3 )
  )

  $ Chro 1.smt2  -flat 0 -amin 0 -amax 0 | sed 's/[[:space:]]*$//'
  sat (under II)
