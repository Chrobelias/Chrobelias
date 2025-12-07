  $ cat strings3.smt2
  (set-logic QF_S)
  (declare-const x String)
  (declare-const y String)
  (assert (= (str.++ "999" x) (str.++ y x)))
  (check-sat)

  $ Chro strings3.smt2 | sed 's/[[:space:]]*$//'
  After strlen lowering:
  (and
    (= eeb8 (str.to.int x))
    (= eeb6 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb3 (str.to.int y))
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
  
  unknown (nfa; unable to multiply var by var: (pow2(eeb2) )  with (eeb3 )
  )
  $ unset CHRO_DEBUG
  $ timeout 6 Chro -dsimpl strings3.smt2 -flat 0 -amin 0 -amax 0 | sed 's/[[:space:]]*$//'
  (assert (exists (%3) (= (+ (* (- 1) %3) pow2(%2) )  1) )
  )
  sat (under II)
