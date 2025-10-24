  $ export CHRO_DEBUG=1
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "999" x) (str.++ y x)))
  > (check-sat)
  > EOF

  $ Chro 1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= eeb6 (str.len x))
             (= eeb2 (str.len x))
             (= eeb6 eeb2)
             (= eeb5 (+ (* eeb7 (exp 10 eeb6)) eeb8))
             (= eeb8 (str.to.int x))
             (= eeb7 (str.to.int y))
             (= eeb2 eeb2)
             (= eeb1 (+ (* eeb3 (exp 10 eeb2)) eeb4))
             (= eeb4 (str.to.int x))
             (= eeb3 999)
             (= (str.from_int eeb1) (str.from_int eeb5)))
  Something ready to substitute:  eeb3 -> 999; eeb6 -> eeb2;
  iter(2)= (and
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb3 999)
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 eeb2)
             (= eeb6 (str.len x))
             (= eeb7 (str.to.int y))
             (= eeb8 (str.to.int x))
             (= eeb1 eeb5))
  Something ready to substitute:  eeb1 ->s eeb5; eeb3 -> 999; eeb6 -> eeb2;
  iter(3)= (and
             (= eeb1 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb2))))
             (= eeb7 (str.to.int y))
             (= eeb8 (str.to.int x))
             (= eeb1 eeb5))
  iter(4)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 999 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb2))))
             (= eeb7 (str.to.int y))
             (= eeb8 (str.to.int x)))
  unknown (nfa; unable to multiply var by var: (pow2(eeb2) )  with (eeb7 )
  )
