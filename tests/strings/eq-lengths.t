  $ cat > leading-zeros.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (declare-fun u () String)
  > (declare-fun v () String)
  > (assert (= (str.++ x y) (str.++ u v)))
  > (assert (= (str.len u) 1))
  > (assert (= (str.len x) 1))
  > (assert (not (= (str.to_int u) (str.to_int x))))
  > (assert (>= (str.to_int x) 0))
  > (assert (>= (str.to_int y) 0))
  > (assert (>= (str.to_int u) 0))
  > (assert (>= (str.to_int v) 0))
  > (check-sat)
  > EOF

  $ Chro -no-parallel leading-zeros.smt2 | cut -d' ' -f1
  unsat
