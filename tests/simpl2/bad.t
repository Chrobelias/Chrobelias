$ export CHRO_DEBUG=1
  $ export OCAMLRUNPARAM='b=0'
  $ cat > TODO1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (* x1 x2) 52))
  > (check-sat)
  > EOF
  $ Chro -bound 0 -pre-simpl -dsimpl TODO1.smt2 | sed 's/[[:space:]]*$//'

$ export OCAMLRUNPARAM='b=0'
  $ cat > TODO1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (exp x1 2) 124))
  > (check-sat)
  > EOF
  $ Chro -bound 0 -pre-simpl -dsimpl TODO1.smt2 | sed 's/[[:space:]]*$//'

