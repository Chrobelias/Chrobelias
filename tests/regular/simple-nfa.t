  $ Chro --pre-simpl --dsimpl simple-nfa.smt2 | sed 's/[[:space:]]*$//'
  sat (presimpl int)
  (assert (exists (%0)
          (and
            (exists (y) (= (+ (* (- 1) %0) (* (- 1) y) )  -1099) )
            (str.in.re.raw %0)
            )
  )
  sat (nfa)
