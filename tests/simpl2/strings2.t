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
  Alphabet with extra char: 0 1 2 3
  
  Something ready to substitute
        y -> "123";
  
  iter(2)= (and
             (= "123" y)
             (= y "321"))
  iter(3)= (not True)
  fixed-point
  
  unsat (presimpl str)

  $ Chro 1.smt2 | sed 's/[[:space:]]*$//'
  unsat (presimpl str)
