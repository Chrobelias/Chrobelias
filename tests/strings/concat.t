  $ cat > test1.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun C () String)
  > (declare-fun J () String)
  > (assert (= (str.++ J C) (str.++ "b" J "d") ))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro test1.smt2
  sat (presimpl str)
  (
     (define-fun C () String
      "bd")
     (define-fun J () String
      "")
  )

  $ cat > test2.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun C () String)
  > (declare-fun D () String)
  > (declare-fun J () String)
  > (assert (= (str.++ "bffaefb" D "fbaeaefd") (str.++ J "ffaef" C) ))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro test2.smt2
  sat (presimpl str)
  (
     (define-fun C () String
      "baeaefd")
     (define-fun D () String
      "ffae")
     (define-fun J () String
      "bffaefb")
  )

  $ cat > test3.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun C () String)
  > (declare-fun D () String)
  > (declare-fun J () String)
  > (assert (= (str.++  "bffaefb" J D "fbaeaefd")  (str.++  J "ffaef" C) ))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro test3.smt2
  sat (presimpl str)
  (
     (define-fun C () String
      "bbfbaeaefd")
     (define-fun D () String
      "")
     (define-fun J () String
      "b")
  )

  $ cat > test4.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun J () String)
  > (assert (= (str.++  "bf" J)  (str.++  J "f")))
  > (check-sat)
  > EOF
  $ Chro test4.smt2
  unsat (presimpl str)

  $ cat > test5.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun J () String)
  > (assert (= (str.++  "bf" J)  (str.++  J "ff")))
  > (check-sat)
  > EOF
  $ Chro test5.smt2
  unsat (presimpl str)

  $ cat > test6.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun J () String)
  > (assert (= (str.++  "ff" J J)  (str.++  J "ffff")))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro test6.smt2
  sat (under str)
  (
     (define-fun J () String
      "ff")
  )

  $ cat > test7.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun J () String)
  > (assert (= (str.++  "f" J J)  (str.++  J "fff")))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro test7.smt2
  sat (under str)
  (
     (define-fun J () String
      "ff")
  )

  $ cat > test8.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun J () String)
  > (assert (= (str.++  "f" J J)  (str.++  J J "f")))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro test8.smt2
  sat (under str)
  (
     (define-fun J () String
      "")
  )

  $ cat > test9.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun J () String)
  > (assert (= (str.++  "0" J)  (str.++  J "0")))
  > (assert (> (str.len J) 1))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro test9.smt2
  sat (under int)
  (
     (define-fun J () String
      "00")
  )
