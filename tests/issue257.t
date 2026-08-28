SMT-LIB Ints (April 2026) standardizes exponentiation as the total function
`**`; the historical `exp` spelling stays as an alias. Constant-constant
powers fold in the frontend, and the shapes outside the engine's partial
Pow relation (negative exponents, bases outside [2..]) are totalized by
`SimplII.std_exp_split` -- the full conformance battery lives in
standard-exp.t.

  $ cat > basic.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (= (** 2 x) 16))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro basic.smt2
  sat (under int)
  (
     (define-fun x () Int
      4)
  )

The pre-standard alias parses to the same term.

  $ cat > alias.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-const x Int)
  > (assert (= (exp 2 x) 16))
  > (check-sat)
  > EOF
  $ Chro -no-model alias.smt2
  sat (under int)

`(** m 0)` is 1 for every base, including 0 -- this fold agrees with the
standard.

  $ cat > zerozero.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (assert (= (** 0 0) 1))
  > (check-sat)
  > EOF
  $ Chro -no-model zerozero.smt2
  sat (presimpl int)

A negative constant exponent folds to 0 per the standard's Euclidean
division.

  $ cat > negexp.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (assert (= (** 2 (- 3)) 0))
  > (check-sat)
  > EOF
  $ Chro -q -no-model negexp.smt2
  sat (presimpl int)

A negative constant base goes through |base| with a parity sign split.

  $ cat > negbase.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (= (** (- 2) x) (- 8)))
  > (check-sat)
  > EOF
  $ Chro -q -no-model negbase.smt2
  sat (under int)

Regression for `Ir.simpl_ineq`: single-variable bounds must be collected only
from the top-level conjunctive spine. Collecting `x = 1` out of the dead arm
used to refute this satisfiable formula.

  $ cat > orbounds.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-const x Int)
  > (assert (<= x 0))
  > (assert (or (= x 1) (= x 0)))
  > (check-sat)
  > EOF
  $ Chro -no-model -bound -1 orbounds.smt2
  sat (nfa)

Regression for the simplifier's constant fold of `mod`: SMT-LIB `mod` is
Euclidean, so `(mod -3 2)` is 1, never -1.

  $ cat > eucl.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (mod (- 3) 2) 1))
  > (check-sat)
  > EOF
  $ Chro -no-model eucl.smt2
  sat (presimpl int)

  $ cat > eucl2.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (mod (- 3) 2) (- 1)))
  > (check-sat)
  > EOF
  $ Chro -no-model eucl2.smt2
  unsat (presimpl int)

Regression for the NFA model decode/encode of negative values: Msb integer
words are sign-symbol-first two's complement, and the decode used to read
the sign symbol as a value bit (x = -4 printed as 4) while the encode
emitted |n| behind a 0 sign. The range pins the model to exactly -4.

  $ cat > negmodel.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-const x Int)
  > (assert (= (mod x 7) 3))
  > (assert (<= x (- 1)))
  > (assert (<= (- 5) x))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro -bound -1 -no-mod-eq negmodel.smt2
  sat (simpl)
  (
     (define-fun x () Int
      -4)
  )
