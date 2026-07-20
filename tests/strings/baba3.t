
$ cat baba3.smt2
  $ Chro --dsimpl --stop-after simpl ./baba3.smt2
  sat (under int)
  (
     (define-fun a () String
      "BabBabBabBabBabBabBabBab")
     (define-fun b () String
      "2")
  )
  $ Chro ./baba3.smt2
  sat (under int)
  (
     (define-fun a () String
      "BabBabBabBabBabBabBabBab")
     (define-fun b () String
      "2")
  )

