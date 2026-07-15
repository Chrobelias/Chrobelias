  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (str.len "12345") (+ 0 5)))
  > (assert (= x (str.to.int "12345")) )
  > (check-sat)
  > EOF

  $ CHRO_DEBUG=1 Chro --dpresimpl ./1.smt2
  Base now is 2
  
  iter(1)= (and
             (= x 12345)
             (= 5 (+ 0 5)))
  Alphabet with extra char: 0
  
  Something ready to substitute
        x -> 12345;
        
  iter(2)= True
  fixed-point
  
  sat (presimpl str)

  $ cat > 2.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x Int)
  > (assert (= x (str.to.int "123451234123412341234123")) )
  > (check-sat)
  > EOF

  $ OCAMLRUNPARAM='b=0' Chro --dpresimpl ./2.smt2
  sat (presimpl str)
