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
             (= %1 (str.from_int eeb5))
             (= %0 (str.from_int eeb1))
             (= eeb6 eeb2)
             (= eeb5 (+ (* eeb7 (exp 10 eeb6)) eeb8))
             (= eeb8 (str.to.int x))
             (= eeb7 999)
             (= eeb2 eeb2)
             (= eeb1 (+ (* eeb3 (exp 10 eeb2)) eeb4))
             (= eeb4 (str.to.int x))
             (= eeb3 (str.to.int y))
             (= %1 %0))
  Something ready to substitute
        %1 -> %0
        eeb6 -> eeb2
        eeb7 -> 999
  
  iter(2)= (and
             (= %0 (str.from_int eeb1))
             (= %1 %0)
             (= %1 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb3 (str.to.int y))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 eeb2)
             (= eeb6 (str.len x))
             (= eeb7 999)
             (= eeb8 (str.to.int x)))
  iter(3)= (and
             (= %0 (str.from_int eeb1))
             (= %0 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb3 (str.to.int y))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* 999 (exp 10 eeb2))))
             (= eeb8 (str.to.int x)))
  unknown (nfa; unable to multiply var by var: (pow2(eeb2) )  with (eeb3 )
  )
