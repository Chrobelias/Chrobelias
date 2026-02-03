  $ cat > test1.smt2 <<-EOF
  > (set-logic ALL)
  > 
  > (declare-const x Int)
  > (declare-const y Int)
  > 
  > (assert (= (some.strange x y) 28))
  > (assert (= (+ (exp 2 x) x) 11))
  > 
  > (check-sat)
  > EOF
  $ Chro test1.smt2 -no-over -bound -1
  unknown (nfa)

  $ cat > test2.smt2 <<-EOF
  > (set-logic ALL)
  > 
  > (declare-const x Int)
  > (declare-const y Int)
  > 
  > (assert (= (some.strange x y) 28))
  > (assert (= (+ (exp 2 x) x) 12))
  > 
  > (check-sat)
  > EOF
  $ Chro test2.smt2 -no-over -bound -1
  unsat (nfa)
