  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= (+ z y) 52))
  > (assert (= (+ z x) 32))
  > (assert (< 111111 (+ (exp 2 x) (exp 2 y)) ))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over -bound -1 --dsimpl --stop-after pre-simpl testS1.smt2 | sed 's/[[:space:]]*$//'
