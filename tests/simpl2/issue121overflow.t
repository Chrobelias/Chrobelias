
  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (>= x (exp 2 1000)))
  > (check-sat)
  > EOF
  $ Chro -no-over-approx -bound 0 -pre-simpl -dsimpl testS1.smt2 | sed 's/[[:space:]]*$//'
  sat (underapprox1)
  $ Chro -no-over-approx -bound -1 -pre-simpl -dsimpl testS1.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists () (and
                       )
  )
  sat (nfa)

