Regression tests for the wrong verdicts found while reviewing #250.

Each of these was answered correctly (or crashed) before the PR and started
returning the opposite verdict during it, so they are pinned here.

SMT-LIB `(str.contains s t)` means "t occurs in s". The constant fold in
`Ast.eia` had the two arguments the other way round.

  $ cat > contains.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (assert (str.contains "abc" "b"))
  > (check-sat)
  > EOF

  $ Chro --info contains.smt2
  sat (presimpl int)

  $ cat > contains-neg.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (assert (str.contains "abc" "d"))
  > (check-sat)
  > EOF

  $ Chro --info contains-neg.smt2
  unsat (presimpl int)

`(str.substr s m n)` is "" for a non-positive length, not the rest of the
string. A negative offset used to escape as an uncaught `Invalid_argument`
raised from inside the exception handler. (A huge offset used to raise
`Z.Overflow` out of `Z.to_int`; that one cannot be reached from the frontend,
because Dolmen rejects an out-of-int literal while parsing.)

  $ cat > substr-neg-len.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (assert (= (str.substr "abcde" 1 (- 1)) "bcde"))
  > (check-sat)
  > EOF

  $ Chro --info substr-neg-len.smt2
  unsat (presimpl str)

  $ cat > substr-neg-offset.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (assert (= (str.substr "abcde" (- 1) 2) ""))
  > (check-sat)
  > EOF

  $ Chro --info substr-neg-offset.smt2
  sat (presimpl str)

The length is clamped to what is left of the string. The string goes through a
variable here, because smtml evaluates an all-literal `str.substr` itself while
parsing.

  $ cat > substr-clamp.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-const s String)
  > (assert (= s "hello"))
  > (assert (= (str.substr s 3 100) "lo"))
  > (check-sat)
  > EOF

  $ Chro --info substr-clamp.smt2
  sat (presimpl str)

  $ cat > substr-clamp-unsat.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-const s String)
  > (assert (= s "hello"))
  > (assert (= (str.substr s 3 100) "l"))
  > (check-sat)
  > EOF

  $ Chro --info substr-clamp-unsat.smt2
  unsat (presimpl str)

`check_card` counted terms it does not recognise (here `str.from_int`) as
contributing zero characters, which made `eq_str` "prove" a contradiction.

  $ cat > from-int.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-const x Int)
  > (assert (= (str.from_int x) "5"))
  > (check-sat)
  > EOF

  $ Chro --info from-int.smt2
  sat (presimpl int)

An out-of-range `str.at` is "", so this is satisfiable. Encoding `str.at s i`
as `s = z1.y.z2 /\ |z1| = i /\ |y| = 1` alone forced `i` into range.

  $ cat > at-out-of-range.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-const s String)
  > (assert (= (str.len s) 2))
  > (assert (= (str.at s 5) ""))
  > (check-sat)
  > EOF

  $ Chro --info at-out-of-range.smt2
  sat (presimpl int)

An out-of-range `str.at` is only "", so demanding a character stays unsat.

  $ cat > at-out-of-range-unsat.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-const s String)
  > (assert (= (str.len s) 2))
  > (assert (= (str.at s 5) "a"))
  > (check-sat)
  > EOF

  $ Chro --info at-out-of-range-unsat.smt2
  unsat (presimpl str)

In-range `str.at` still works.

  $ cat > at-in-range.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (assert (= (str.at "abc" 1) "b"))
  > (check-sat)
  > EOF

  $ Chro --info at-in-range.smt2
  sat (presimpl int)

`b ** x = b ** y -> x = y` needs `b ** _` to be injective, which fails for the
bases 0 and 1 (and for a variable base that can take those values).

  $ cat > pow-base-one.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (** 1 0) (** 1 5)))
  > (check-sat)
  > EOF

  $ Chro --info pow-base-one.smt2
  sat (presimpl int)

  $ cat > pow-base-zero.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (** 0 1) (** 0 5)))
  > (check-sat)
  > EOF

  $ Chro --info pow-base-zero.smt2
  sat (presimpl int)

The fold is still applied for a constant base of absolute value at least 2.

  $ cat > pow-base-two.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (** 2 3) (** 2 5)))
  > (check-sat)
  > EOF

  $ Chro --info pow-base-two.smt2
  unsat (presimpl int)
