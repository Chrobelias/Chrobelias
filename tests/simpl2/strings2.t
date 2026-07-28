$ export CHRO_DEBUG=simpl
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "123" x) (str.++ y x)))
  > (assert (= y "321"))
  > (check-sat)
  > EOF

  $ CHRO_DEBUG=simpl Chro --dpresimpl --dsimpl --stop-after simpl 1.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    iter(1)= (and
             (= y "321")
             (= (str.++ "123" x) (str.++ y x)))
  [+simpl]
    Alphabet with extra char: 0 1 2 3
  
  [+simpl]
    Something ready to substitute
        y -> "123";
  
  [+simpl]
    iter(2)= (and
             (= "123" y)
             (= y "321"))
  [+simpl]
    iter(3)= (not True)
  [+simpl]
    fixed-point
  
  [+simpl]
    contradicting clause: (= y "321")
  [+simpl]
    contradicting env:  y -> "123";
  [+simpl]
    short env:  y -> "123";
  
  [+simpl]
    unsat core: (= y "321")
  
  unsat (presimpl str)

  $ Chro 1.smt2 | sed 's/[[:space:]]*$//'
  unsat (presimpl str)
