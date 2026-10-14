The only order of this system is 2**t >= 2**w >= t >= 2**v >= w >= v. At the
level of 2**w the next term is t, whose power is already eliminated; the split
must be made at the 1 of 2**v, not at the leading digit of w. The model
v = 2, w = 3, t = 5 shows the system is satisfiable. -bound -1 switches off
the integer under-approximation, so the NFA Solver decides it.

  $ cat > log-successor.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-fun t () Int)
  > (declare-fun w () Int)
  > (declare-fun v () Int)
  > (assert (>= v 0))
  > (assert (>= w v))
  > (assert (> (** 2 v) w))
  > (assert (> t (** 2 v)))
  > (assert (> (** 2 w) t))
  > (assert (> (** 2 t) (* 4 t)))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro -no-parallel -bound -1 log-successor.smt2
  sat (nfa)
  (
     (define-fun t () Int
      6)
     (define-fun v () Int
      2)
     (define-fun w () Int
      3)
  )

  $ Chro -no-parallel -bound -1 -no-model log-successor.smt2 | head -1
  sat (nfa)
