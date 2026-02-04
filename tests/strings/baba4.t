
$ cat baba4.smt2
  $ Chro --dsimpl --stop-after simpl ./baba4.smt2
  sat (presimpl)
  (
     (define-fun a () String
      "Ba")   (define-fun b () String
      "20")
  )
$ export CHRO_DEBUG=1
  $ Chro ./baba4.smt2
  sat (presimpl)
  (
     (define-fun a () String
      "Ba")   (define-fun b () String
      "20")
  )
