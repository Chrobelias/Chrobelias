  $ cat > pos.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const b Bool)
  > (assert b)
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model pos.smt2
  sat (under int)
  (
     (define-fun b () Bool
      true)
  )

  $ cat > neg.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-fun b () Bool)
  > (assert (not b))
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model neg.smt2
  sat (under int)
  (
     (define-fun b () Bool
      false)
  )

  $ cat > contra.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const b Bool)
  > (assert b)
  > (assert (not b))
  > (check-sat)
  > SMT
  $ Chro --check-model contra.smt2
  unsat (nia)

  $ cat > eq.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const a Bool)
  > (declare-const b Bool)
  > (assert (= a b))
  > (assert a)
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model eq.smt2
  sat (under int)
  (
     (define-fun a () Bool
      true)
     (define-fun b () Bool
      true)
  )

  $ cat > eq_unsat.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const a Bool)
  > (declare-const b Bool)
  > (assert (= a b))
  > (assert a)
  > (assert (not b))
  > (check-sat)
  > SMT
  $ Chro --check-model eq_unsat.smt2
  unsat (nia)

  $ cat > eq_negated_unsat.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const a Bool)
  > (declare-const b Bool)
  > (assert (= (not a) b))
  > (assert a)
  > (assert b)
  > (check-sat)
  > SMT
  $ Chro --check-model eq_negated_unsat.smt2
  unsat (nia)

  $ cat > distinct_unsat.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const a Bool)
  > (declare-const b Bool)
  > (assert (distinct a b))
  > (assert a)
  > (assert b)
  > (check-sat)
  > SMT
  $ Chro --check-model distinct_unsat.smt2
  unsat (nia)

  $ cat > xor.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const a Bool)
  > (declare-const b Bool)
  > (assert (xor a b))
  > (assert a)
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model xor.smt2
  sat (under int)
  (
     (define-fun a () Bool
      true)
     (define-fun b () Bool
      false)
  )

  $ cat > ite.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const b Bool)
  > (declare-const x Int)
  > (assert (= x (ite b 1 2)))
  > (assert (not b))
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model ite.smt2
  sat (under int)
  (
     (define-fun b () Bool
      false)
     (define-fun x () Int
      2)
  )

  $ cat > mixed.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const b Bool)
  > (declare-const x Int)
  > (assert (or b (> x 10)))
  > (assert (not b))
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model mixed.smt2
  sat (under int)
  (
     (define-fun b () Bool
      false)
     (define-fun x () Int
      11)
  )

  $ cat > unused.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const b Bool)
  > (declare-const x Int)
  > (assert (= x 1))
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model unused.smt2
  sat (presimpl int)
  (
     (define-fun b () Bool
      false)
     (define-fun x () Int
      1)
  )

  $ cat > select_regime.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const p Bool)
  > (declare-const q Bool)
  > (declare-const r Bool)
  > (declare-const x Int)
  > (assert (or p q r))
  > (assert (not (and p q)))
  > (assert (not (and q r)))
  > (assert (not (and p r)))
  > (assert (=> p (and (= (mod x 7) 3) (<= 0 x) (<= x 2))))
  > (assert (=> q (and (= (mod x 5) 4) (<= 10 x) (<= x 12))))
  > (assert (=> r (and (= (mod x 7) 3) (<= (- 5) x) (<= x (- 1)))))
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model select_regime.smt2
  sat (under int)
  (
     (define-fun p () Bool
      false)
     (define-fun q () Bool
      false)
     (define-fun r () Bool
      true)
     (define-fun x () Int
      -4)
  )

  $ cat > guarded_exp.smt2 <<-SMT
  > (set-logic QF_EIA)
  > (declare-const b Bool)
  > (declare-const x Int)
  > (assert (<= 0 x))
  > (assert (or (and b (= (** 2 x) 1024)) (and (not b) (= (** 2 x) 33))))
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model guarded_exp.smt2
  sat (under int)
  (
     (define-fun b () Bool
      true)
     (define-fun x () Int
      10)
  )

  $ cat > all_branches_refuted.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const p Bool)
  > (declare-const q Bool)
  > (declare-const x Int)
  > (assert (or p q))
  > (assert (=> p (and (= (mod x 4) 1) (= (mod x 6) 2))))
  > (assert (=> q (and (< x 0) (> x 0))))
  > (check-sat)
  > SMT
  $ Chro --check-model all_branches_refuted.smt2
  unsat (nia)

  $ cat > ite_eq_unsat.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const p Bool)
  > (declare-const a Bool)
  > (declare-const b Bool)
  > (assert (= (ite p a b) (ite p b a)))
  > (assert p)
  > (assert a)
  > (assert (not b))
  > (check-sat)
  > SMT
  $ Chro --check-model ite_eq_unsat.smt2
  unsat (nia)
