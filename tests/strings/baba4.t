
$ cat baba4.smt2
  $ Chro --dsimpl --stop-after simpl ./baba4.smt2
  sat (presimpl)
  ((define-fun a () (_ String) "Ba") (define-fun b () (_ String) "20"))
$ export CHRO_DEBUG=1
  $ Chro ./baba4.smt2
  sat (presimpl)
  ((define-fun a () (_ String) "Ba") (define-fun b () (_ String) "20"))
