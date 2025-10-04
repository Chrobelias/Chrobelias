  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (str.len "12345") (+ 0 5)))
  > (assert (= x (str.to.int "12345")) )
  > (check-sat)
  > EOF

  $ CHRO_DEBUG=1 Chro -dpresimpl ./1.smt2
  iter(1)= (and
             (= x 12345)
             (= 5 (+ 0 5)))
  Something ready to substitute:  x -> 12345; 
  iter(2)= (and
             (= x 12345))
  iter(3)= True
  sat (presimpl)

  $ cat > 2.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= x (str.to.int "123451234123412341234123")) )
  > (check-sat)
  > EOF

  $ OCAMLRUNPARAM='b=0' Chro -dpresimpl ./2.smt2
  (= x (str.to.int "123451234123412341234123"))
  Fatal error: exception Failure("TBD: lib/me.ml 359")
  [2]
