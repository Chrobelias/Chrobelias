
$ Chro -dsimpl -stop-after simpl NIA2334test1.smt2 | sed 's/[[:space:]]*$//'
  $ Chro --dsimpl --stop-after simpl NIA2334test1.smt2 | sed 's/[[:space:]]*$//'
  sat (under int)
hangs
$ Chro -over-approx NIA2334test1.smt2 | sed 's/[[:space:]]*$//'
