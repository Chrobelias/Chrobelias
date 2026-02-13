$ export CHRO_DEBUG=1
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "123" x) (str.++ y x)))
  > (assert (= y "321"))
  > (check-sat)
  > EOF

  $ CHRO_DEBUG=1 Chro --dpresimpl --dsimpl --stop-after simpl 1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= y "321")
             (= (str.++ "123" x) (str.++ y x)))
  Something ready to substitute
        y -> "321";
  
  iter(2)= (= (str.++ "123" x) (str.++ y x))
  iter(3)= (not True)
  fixed-point
  
  unsat (presimpl str)

  $ Chro 1.smt2 | sed 's/[[:space:]]*$//'
  unsat (presimpl str)
