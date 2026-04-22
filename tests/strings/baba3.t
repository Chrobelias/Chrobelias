
$ cat baba3.smt2
  $ Chro --dsimpl --stop-after simpl ./baba3.smt2
  sat (under int)
  (
     (define-fun a () String
      "BabBabBabBabBabLyubaLyuba")
     (define-fun b () String
      "22")
     (define-fun q () Int
      25)
  )
  $ Chro ./baba3.smt2
  sat (under int)
  (
     (define-fun a () String
      "BabBabBabBabBabLyubaLyuba")
     (define-fun b () String
      "22")
     (define-fun q () Int
      25)
  )

