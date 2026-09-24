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
  > (declare-const b Bool)
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

  $ cat > declfun.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-fun b () Bool)
  > (assert b)
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model declfun.smt2
  sat (under int)
  (
     (define-fun b () Bool
      true)
  )

  $ cat > implies.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const b Bool)
  > (declare-const x Int)
  > (assert (=> b (> x 5)))
  > (assert b)
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model implies.smt2
  sat (under int)
  (
     (define-fun b () Bool
      true)
     (define-fun x () Int
      6)
  )

  $ cat > disj.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const b Bool)
  > (declare-const x Int)
  > (assert (or b (> x 10)))
  > (assert (not b))
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model disj.smt2
  sat (under int)
  (
     (define-fun b () Bool
      false)
     (define-fun x () Int
      11)
  )

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
      false)
  )

  $ cat > distinct.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const a Bool)
  > (declare-const b Bool)
  > (assert (distinct a b))
  > (assert a)
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model distinct.smt2
  sat (under int)
  (
     (define-fun a () Bool
      true)
     (define-fun b () Bool
      false)
  )

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

  $ cat > withmod.smt2 <<-SMT
  > (set-logic ALL)
  > (declare-const b Bool)
  > (declare-const x Int)
  > (assert (=> b (= (mod x 7) 3)))
  > (assert b)
  > (assert (<= 0 x))
  > (assert (<= x 10))
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model withmod.smt2
  sat (under int)
  (
     (define-fun b () Bool
      true)
     (define-fun x () Int
      3)
  )
