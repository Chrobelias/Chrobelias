
$ Chro -dsimpl -stop-after simpl NIA2334test1.smt2 | sed 's/[[:space:]]*$//'
  $ Chro --dsimpl --stop-after simpl NIA2334test1.smt2 | sed 's/[[:space:]]*$//'
  sat (under I)
  ((define-fun x1 () (_ Int) 16)
   (define-fun x2 () (_ Int) 0)
   (define-fun x3 () (_ Int) 15)
   (define-fun x4 () (_ Int) 7)
   (define-fun x5 () (_ Int) 41))
hangs
$ Chro -over-approx NIA2334test1.smt2 | sed 's/[[:space:]]*$//'
