  $ Chro --pre-simpl --dsimpl simple-nfa.smt2 | sed 's/[[:space:]]*$//'
  sat (presimpl)
  (assert (exists (%0 %1)
          (and
            (exists (y) (= (+ (* (- 1) %0) (* (- 1) y) )  -1099) )
            (str.in.re.raw %1)
            (= %1 (chrob.from.int %0))
            )
  )
  sat (nfa)
