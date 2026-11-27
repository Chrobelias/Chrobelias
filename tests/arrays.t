  $ cat > store.smt2 <<-SMT
  > (set-logic QF_ALIA)
  > (declare-fun a () (Array Int Int))
  > (declare-fun i () Int)
  > (declare-fun j () Int)
  > (assert (= (select (store a i 5) j) 7))
  > (assert (= i j))
  > (check-sat)
  > SMT
  $ Chro store.smt2
  unsat (presimpl int)

  $ cat > congruence.smt2 <<-SMT
  > (set-logic QF_ALIA)
  > (declare-fun a () (Array Int Int))
  > (declare-fun i () Int)
  > (declare-fun j () Int)
  > (assert (= (select a i) 1))
  > (assert (= (select a j) 2))
  > (assert (<= i j))
  > (assert (<= j i))
  > (check-sat)
  > SMT
  $ Chro congruence.smt2
  unsat (nia)

  $ cat > model.smt2 <<-SMT
  > (set-logic QF_ALIA)
  > (declare-fun a () (Array Int Int))
  > (declare-fun b () (Array Int Int))
  > (declare-fun c () Bool)
  > (declare-fun i () Int)
  > (assert (let ((x (store a 3 7))) (= (select (ite c x b) i) 7)))
  > (assert (not (= i 3)))
  > (assert (= (select b i) 0))
  > (check-sat)
  > (get-model)
  > SMT
  $ Chro --check-model model.smt2
  sat (under int)
  (
     (define-fun a!1 () Int
      7)
     (define-fun b!0 () Int
      0)
     (define-fun c () Bool
      true)
     (define-fun i () Int
      2)
  )

  $ cat > ext.smt2 <<-SMT
  > (set-logic QF_ALIA)
  > (declare-fun a () (Array Int Int))
  > (declare-fun b () (Array Int Int))
  > (assert (= a b))
  > (check-sat)
  > SMT
  $ Chro ext.smt2
  unknown
  (unsupported: b)
