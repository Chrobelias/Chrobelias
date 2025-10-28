$ export CHRO_DEBUG=1
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "123" x) (str.++ y x)))
  > (assert (= y "321"))
  > (check-sat)
  > EOF

  $ CHRO_DEBUG=1 Chro -pre-simpl -dpresimpl -dsimpl -stop-after simpl 1.smt2 | sed 's/[[:space:]]*$//'
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
    (= eeb7 123)
    (= eeb2 eeb2)
    (= eeb1 (+ (* eeb3 (exp 10 eeb2)) eeb4))
    (= eeb4 (str.to.int x))
    (= eeb3 (str.to.int y))
    (= y "321")
    (= %1 %0))
  
  iter(1)= (and
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
             (= eeb7 123)
             (= eeb2 eeb2)
             (= eeb1 (+ (* eeb3 (exp 10 eeb2)) eeb4))
             (= eeb4 (str.to.int x))
             (= eeb3 (str.to.int y))
             (= y "321")
             (= %1 %0))
  Something ready to substitute
        %1 -> %0;
        eeb6 -> eeb2;
        eeb7 -> 123;
        y -> "321";
        %0 -> (str.from_int eeb1);
        eeb2 -> (str.len x);
        eeb3 -> (str.to.int y);
        eeb4 -> (str.to.int x);
        eeb8 -> (str.to.int x);
  
  iter(2)= (and
             (= %1 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 (str.len x)))
  iter(3)= (and
             (= %0 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb5 (+ eeb8 (* 123 (exp 10 eeb2)))))
  (and
    (= %0 (str.from_int eeb5))
    (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
    (= eeb2 (str.len x))
    (= eeb5 (+ eeb8 (* 123 (exp 10 eeb2)))))
  unknown (nfa; unable to multiply var by var: (pow2(eeb2) )  with (eeb3 )
  )

  $ Chro 1.smt2  -flat 0 -amin 0 -amax 0 | sed 's/[[:space:]]*$//'
  sat (under II)
