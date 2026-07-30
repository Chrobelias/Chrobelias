Performance regression vs c0da168 (#245).

The example from the issue. Beyond the verdict and the model, what mattered
here was the time: c0da168 solved it in ~0.16s, `main` needed ~0.52s. The
arithmetization sequence is lazy again and is no longer forced past the first
`Sat`, which brings it back to ~0.12s.

  $ cat > slow.smt2 <<-EOF
  > (set-logic QF_S)
  > (set-option :produce-models true)
  > (declare-fun x () String)
  > (assert (str.in_re x (re.++ (str.to_re "12345") (re.+ (str.to_re "82")) (re.+ (str.to_re "26")))))
  > (assert (= (mod (mod (str.to_int x) 29) 11) 0))
  > (assert (< (str.len x) 100))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro --info slow.smt2
  sat (nfa)
  (
     (define-fun x () String
      "1234582822626262626262626262626262626262626262626262626262626262626262626262626")
  )

The short-circuit itself — once one arithmetization answers `Sat` the rest of
the lazy sequence is no longer forced — shows up as one fewer simplifier round
in `tests/simpl2/exp-test27.t`.
