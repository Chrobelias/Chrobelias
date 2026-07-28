  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (str.len "12345") (+ 0 5)))
  > (assert (= x (str.to.int "12345")) )
  > (check-sat)
  > EOF

  $ CHRO_DEBUG=simpl Chro --dpresimpl ./1.smt2
  [+simpl]
    iter(1)= (= (+ x (* (- 1) (str.to.int "12345"))) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        x -> 12345;
        
  [+simpl]
    iter(2)= (= (+ (- 12345) x) 0)
  [+simpl]
    iter(3)= True
  [+simpl]
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
