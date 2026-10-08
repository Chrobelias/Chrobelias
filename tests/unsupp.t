  $ cat > test1.smt2 <<-EOF
  > (set-logic ALL)
  > 
  > (declare-const x Int)
  > (declare-const y Int)
  > 
  > (assert (= (some.strange x y) 28))
  > (assert (= (+ (** 2 x) x) 11))
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
  > (assert (= (+ (** 2 x) x) 12))
  > 
  > (check-sat)
  > EOF
  $ Chro test2.smt2 -no-over -bound -1
  unsat (nfa)

A formula the NFA Solver rejects: the answer keeps the rejection message.

  $ cat > rejected.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () String)
  > (declare-fun n () Int)
  > (declare-fun y () Int)
  > (assert (>= n 10))
  > (assert (= y (exp 2 n)))
  > (assert (<= (str.len x) y))
  > (assert (not (str.in_re x (re.* (str.to_re "a")))))
  > (check-sat)
  > EOF
  $ Chro -no-parallel rejected.smt2 | head -1 | sed 's/[[:space:]]*$//'
  unknown ((nfa) Lengths should have been rewritten into chrob.len, found (str.len x) in
