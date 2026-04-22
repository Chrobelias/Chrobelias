  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (str.len "12345") (+ 0 5)))
  > (assert (= x (str.to.int "12345")) )
  > (check-sat)
  > EOF

  $ CHRO_DEBUG=1 Chro --dpresimpl ./1.smt2
  Basic simplifications:
  
  iter(1)= (= (+ (- 12345) x) 0)
  Alphabet with extra char: #
  
  Something ready to substitute
        x -> 12345;
        
  iter(3)= True
  fixed-point
  
  sat (presimpl int)

  $ cat > 2.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x Int)
  > (assert (= x (str.to.int "123451234123412341234123")) )
  > (check-sat)
  > EOF

  $ OCAMLRUNPARAM='b=0' Chro --dpresimpl ./2.smt2
  sat (presimpl int)
