
$ cat baba3.smt2
  $ Chro --dsimpl --stop-after simpl ./baba3.smt2
  sat (under I)
  ((define-fun a () (_ String) "BabBabBabBabBabBabBabBab")
   (define-fun b () (_ String) "2")
   (define-fun q () (_ Int) 0))
  $ Chro ./baba3.smt2
  sat (under I)
  ((define-fun a () (_ String) "BabBabBabBabBabBabBabBab")
   (define-fun b () (_ String) "2")
   (define-fun q () (_ Int) 0))

