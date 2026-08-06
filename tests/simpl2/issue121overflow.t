
  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (>= x (exp 2 1000)))
  > (check-sat)
  > EOF
  $ Chro -no-over -bound 0 --dsimpl testS1.smt2 | sed 's/[[:space:]]*$//'
  sat (under int)
  $ Chro -no-over -bound -1 --dsimpl testS1.smt2 | sed 's/[[:space:]]*$//'
  sat (simpl)

