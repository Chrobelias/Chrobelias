The --bool-comb mode decides a formula by traversing the NFAs of its conjuncts
simultaneously instead of intersecting them. It has to agree with the default
intersection-based procedure.

  $ cat > conj.smt2 <<-EOF
  > (set-logic QF_LIA)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= (+ x y) 10))
  > (assert (= (- x y) 4))
  > (assert (<= z x))
  > (assert (>= z 0))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro -no-over -bound -1 conj.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)
  (
     (define-fun x () Int
      7)
     (define-fun y () Int
      3)
     (define-fun z () Int
      0)
  )

  $ Chro -no-over -bound -1 --bool-comb conj.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)
  (
     (define-fun x () Int
      7)
     (define-fun y () Int
      3)
     (define-fun z () Int
      0)
  )

Each conjunct becomes one atom of the skeleton, and its own NFA; nothing gets
intersected.

  $ CHRO_DEBUG=solver Chro -no-over -bound -1 --bool-comb conj.smt2 | grep -E "skeleton|Nfa for a|Intersecting"
    Boolean skeleton: (and a0 a1 a2)
    Nfa for a0 ((1y + 1z <= 10)) has 9 nodes
    Nfa for a1 ((-1z <= 0)) has 2 nodes
    Nfa for a2 ((1y = 3)) has 4 nodes

An unsatisfiable conjunction: the traversal has to exhaust the product.

  $ cat > unsat.smt2 <<-EOF
  > (set-logic QF_LIA)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= (+ (* 6 x) (* 10 y) (* 15 z)) 7))
  > (assert (<= 0 x))
  > (assert (<= 0 y))
  > (assert (<= 0 z))
  > (check-sat)
  > EOF

  $ Chro -no-over -bound -1 unsat.smt2
  unsat (nfa)

  $ Chro -no-over -bound -1 --bool-comb unsat.smt2
  unsat (nfa)

A disjunction stays a single leaf by default, so the skeleton keeps one atom for
it and the automaton behind that atom is built the usual way, with a union.

  $ cat > disj.smt2 <<-EOF
  > (set-logic QF_LIA)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (assert (or (= (+ x y) 7) (= (+ x y) 9)))
  > (assert (<= 1 y))
  > (assert (<= y 2))
  > (check-sat)
  > (get-model)
  > EOF

  $ CHRO_DEBUG=solver Chro -no-over -bound -1 --bool-comb disj.smt2 | grep -E "skeleton"
    Boolean skeleton: (and a0 a1 a2)

  $ Chro -no-over -bound -1 --bool-comb disj.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)
  (
     (define-fun x () Int
      5)
     (define-fun y () Int
      2)
  )

With --bool-comb-or the disjunction reaches the skeleton as well. Here the search
comes up empty even though the formula is satisfiable — one of the two automata
under the disjunction cannot read the witness — so the answer is recomputed by
intersecting, and stays correct.

  $ CHRO_DEBUG=solver Chro -no-over -bound -1 --bool-comb-or disj.smt2 | grep -E "skeleton|inconclusive"
    Boolean skeleton: (and (or a0 a1) a2 a3)
    Boolean combination search was inconclusive, intersecting instead

  $ Chro -no-over -bound -1 --bool-comb-or disj.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)
  (
     (define-fun x () Int
      6)
     (define-fun y () Int
      1)
  )

What the mode is for: ten congruences over a shared variable. Their product is
far too large to build, yet x = 1 satisfies all of them at once, and the
traversal walks straight to it.

  $ cat > congr.smt2 <<-EOF
  > (set-logic QF_LIA)
  > (declare-fun x () Int)
  > (declare-fun k0 () Int)
  > (declare-fun k1 () Int)
  > (declare-fun k2 () Int)
  > (declare-fun k3 () Int)
  > (declare-fun k4 () Int)
  > (declare-fun k5 () Int)
  > (declare-fun k6 () Int)
  > (declare-fun k7 () Int)
  > (declare-fun k8 () Int)
  > (declare-fun k9 () Int)
  > (assert (<= 1 x))
  > (assert (= (- x (* 101 k0)) 1))
  > (assert (= (- x (* 103 k1)) 1))
  > (assert (= (- x (* 107 k2)) 1))
  > (assert (= (- x (* 109 k3)) 1))
  > (assert (= (- x (* 113 k4)) 1))
  > (assert (= (- x (* 127 k5)) 1))
  > (assert (= (- x (* 131 k6)) 1))
  > (assert (= (- x (* 137 k7)) 1))
  > (assert (= (- x (* 139 k8)) 1))
  > (assert (= (- x (* 149 k9)) 1))
  > (check-sat)
  > EOF

  $ CHRO_NFA_SIZE=20000 Chro -no-over -bound -1 congr.smt2
  unknown (too big nfa during the computations)

  $ CHRO_NFA_SIZE=20000 Chro -no-over -bound -1 --bool-comb congr.smt2
  sat (nfa)

A negation never reaches the skeleton: the negated subformula becomes a leaf of
its own, and is compiled by inverting its automaton as usual.

  $ cat > neg.smt2 <<-EOF
  > (set-logic QF_LIA)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (assert (not (= (+ x y) 7)))
  > (assert (= (- x y) 1))
  > (assert (<= 0 x))
  > (assert (<= x 9))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro -no-over -bound -1 --bool-comb neg.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)
  (
     (define-fun x () Int
      2)
     (define-fun y () Int
      1)
  )
