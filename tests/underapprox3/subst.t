$ cat subst-3.smt2

  $ Chro ./subst.smt2
  sat (under I)

$ export CHRO_DEBUG=1
  $ Chro ./subst-2.smt2
  unsat

  $ Chro ./subst-3.smt2
  sat (under I)
