  $ cat > prefix.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (declare-fun z () String)
  > (assert (= (str.++ "a" x) (str.++ y z)))
  > (assert (str.in_re y (re.+ (str.to_re "b"))))
  > (assert (str.prefixof "a" (str.++ y z)))
  > (check-sat)
  > EOF

  $ Chro -no-parallel -under-all -budget 4 prefix.smt2 | sed 's/ *$//'
  unknown

  $ cat > prefix-core.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun y () String)
  > (assert (str.prefixof "a" (str.++ y "0")))
  > (assert (str.in_re y (re.+ (str.to_re "b"))))
  > (check-sat)
  > EOF

  $ Chro -no-parallel prefix-core.smt2
  unsat (presimpl int)

  $ cat > suffix.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (declare-fun z () String)
  > (assert (= (str.++ x "a") (str.++ y z)))
  > (assert (str.in_re z (re.+ (str.to_re "b"))))
  > (assert (str.suffixof "a" (str.++ y z)))
  > (check-sat)
  > EOF

  $ Chro -no-parallel suffix.smt2 | sed 's/ *$//'
  unknown

  $ cat > suffix-core.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun y () String)
  > (assert (str.suffixof "a" (str.++ "0" y)))
  > (assert (str.in_re y (re.+ (str.to_re "b"))))
  > (check-sat)
  > EOF

  $ Chro -no-parallel suffix-core.smt2
  unsat (presimpl int)

  $ cat > wildcard-candidate.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (declare-fun z () String)
  > (assert (= (str.++ "a" x) (str.++ y z)))
  > (assert (str.in_re y (re.++ (str.to_re "a") (str.to_re "c"))))
  > (assert (str.prefixof "a" (str.++ y z)))
  > (assert (not (str.contains x "c")))
  > (check-sat)
  > EOF

  $ Chro -no-parallel -under-all -budget 0.2 wildcard-candidate.smt2 | sed 's/ *$//'
  unknown

  $ cat > prefix-sat.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (declare-fun z () String)
  > (assert (= (str.++ "a" x) (str.++ y z)))
  > (assert (str.in_re y (re.+ (str.to_re "a"))))
  > (assert (str.prefixof "a" (str.++ y z)))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro -no-parallel --check-model prefix-sat.smt2
  sat (under int)
  (
     (define-fun x () String
      "a")
     (define-fun y () String
      "aa")
     (define-fun z () String
      "")
  )

  $ cat > prefix-core-sat.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun y () String)
  > (assert (str.prefixof "ab" (str.++ y "0")))
  > (assert (not (= y "ab")))
  > (assert (= (str.len y) 3))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro -no-parallel --check-model prefix-core-sat.smt2
  sat (presimpl int)
  (
     (define-fun y () String
      "abb")
  )
