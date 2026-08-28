Conformance suite for exponentiation as standardized in SMT-LIB Ints
(April 2026). The standard defines `**` as a *total* function:
for n >= 0, (** m n) = m^n with (** 0 0) = 1; for n < 0 it is
(div 1 (** m (- n))), that is (** 0 n) = 0, (** m n) = (** m (- n)) when
|m| = 1, and (** m n) = 0 when |m| > 1.

Support comes in two layers: constant-constant powers fold in the frontend
and the simplifier, and everything else (variable exponents over any
constant base, variable bases under constant negative exponents) is
totalized by `SimplII.std_exp_split` -- a case split over the exponent's
sign (and parity, for negative bases) applied before the EIA pipeline.
Exponents provably nonnegative from the pow-free atoms skip the split, so
guarded formulas keep the engine's exact fragment. Related: issue257.t
(the syntax extension and the frontend folds).

== The engine fragment ==

  $ cat > a1.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (= (** 2 x) 16))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro a1.smt2
  sat (under int)
  (
     (define-fun x () Int
      4)
  )

The pre-standard `exp` alias parses to the same term.

  $ cat > alias.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-const x Int)
  > (assert (= (exp 2 x) 16))
  > (check-sat)
  > EOF
  $ Chro -no-model alias.smt2
  sat (under int)

== Constant corner cases ==

(** m 0) = 1 for every base, including 0.

  $ cat > a5.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (assert (= (** 0 0) 1))
  > (check-sat)
  > EOF
  $ Chro -no-model a5.smt2
  sat (presimpl int)

A constant negative exponent under |m| > 1 is 0 (Euclidean division of 1 by the positive power), and
its negation is unsatisfiable.

  $ cat > a3.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (assert (= (** 2 (- 3)) 0))
  > (check-sat)
  > EOF
  $ Chro -no-model a3.smt2
  sat (presimpl int)

  $ cat > a4.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (assert (not (= (** 2 (- 3)) 0)))
  > (check-sat)
  > EOF
  $ Chro -no-model a4.smt2
  unsat (presimpl int)

== Variable exponents ==

Base 1 is constant 1 on the whole domain.

  $ cat > a7.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (= (** 1 x) 1))
  > (check-sat)
  > EOF
  $ Chro -no-model a7.smt2
  sat (presimpl int)

For a negative exponent 2^x is 0 -- never 1 -- and for a nonnegative one it
is at least 1:

  $ cat > a2.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (< x 0))
  > (assert (= (** 2 x) 0))
  > (check-sat)
  > EOF
  $ Chro -no-model a2.smt2
  sat (under int)

  $ cat > a9.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (< x 0))
  > (assert (= (** 2 x) 1))
  > (check-sat)
  > EOF
  $ Chro -no-model a9.smt2
  unsat (over)

  $ cat > a14.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (<= 0 x))
  > (assert (= (** 2 x) 0))
  > (check-sat)
  > EOF
  $ Chro -no-model a14.smt2
  unsat (over)

Under the standard's Euclidean division 2^-1 is (div 1 2) = 0, so 1000 * 2^x can never
be 500 (the exact-rational reading would answer x = -1 here -- that is
deliberately NOT what the standard prescribes).

  $ cat > a15.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (= (* 1000 (** 2 x)) 500))
  > (check-sat)
  > EOF
  $ Chro -no-model a15.smt2
  unsat (over)

Base 0 is 1 at exponent 0 and 0 everywhere else.

  $ cat > a6.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (not (= x 0)))
  > (assert (= (** 0 x) 0))
  > (check-sat)
  > EOF
  $ Chro -no-model a6.smt2
  sat (under int)

Base -1 alternates with the exponent's parity on the whole domain
((** -1 n) = (** -1 (- n))):

  $ cat > a8.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (= (** (- 1) x) (- 1)))
  > (check-sat)
  > EOF
  $ Chro -no-model a8.smt2
  sat (under int)

A negative base |m| >= 2 alternates sign with the exponent's parity:

  $ cat > a10.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (= (** (- 2) x) (- 8)))
  > (check-sat)
  > EOF
  $ Chro -no-model a10.smt2
  sat (under int)

  $ cat > a11.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (= (** (- 2) x) 8))
  > (check-sat)
  > EOF
  $ Chro -no-model a11.smt2
  unsat (nfa)

== Variable bases under constant negative exponents ==

A finite case split on the base: only |b| = 1 survives with a nonzero
value, everything with |b| >= 2 collapses to 0.

  $ cat > a12.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (= (** x (- 2)) 1))
  > (check-sat)
  > EOF
  $ Chro -no-model a12.smt2
  sat (presimpl int)

  $ cat > a13.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (assert (<= 2 x))
  > (assert (= (** x (- 2)) 0))
  > (check-sat)
  > EOF
  $ Chro -no-model a13.smt2
  sat (under int)
