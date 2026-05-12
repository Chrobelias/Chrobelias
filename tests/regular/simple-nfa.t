  $ Chro --dsimpl simple-nfa.smt2 | sed 's/[[:space:]]*$//'
  (assert (chrob.len %1 pow2(strlena)))
  (assert (<= (* (- 1) pow2(strlena))  -10) )
  (assert (= %1  1099) )
  
  sat (nfa)
  sat (under int)
