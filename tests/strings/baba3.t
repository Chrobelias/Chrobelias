
$ cat baba3.smt2
  $ Chro --dsimpl --stop-after simpl ./baba3.smt2
  sat (under I)
  (
     (define-fun a () String
      "BabBabBabBabBabBabBabBab")
     (define-fun b () String
      "2")
     (define-fun q () Int
      0)
  )
  $ Chro ./baba3.smt2
  sat (under I)
  (
     (define-fun a () String
      "BabBabBabBabBabBabBabBab")
     (define-fun b () String
      "2")
     (define-fun q () Int
      0)
  )

