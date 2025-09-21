Basic QF_S tests

  $ Chro ./qf-s.smt2
  sat (nfa)
  ((define-fun a () (_ String) "abc"))
  sat (nfa)
  sat (nfa)
  unsat
  sat (nfa)
  unsat
  unsat
  sat (nfa)
  sat (nfa)
  unsat
  sat (nfa)
  unsat
  sat (nfa)
  ((define-fun %33 () (_ Int) 12) (define-fun a () (_ String) "100100100100"))
  ((define-fun a () (_ String) "LyuBaBaBaBaBaBaBaBaBaBa")
   (define-fun x () (_ Int) 23))
  ((define-fun a () (_ String) "Ba") (define-fun b () (_ String) "20"))
  ((define-fun a () (_ String) "LyuBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBa")
   (define-fun b () (_ String) "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100")
   (define-fun q () (_ Int) 101))
  ((define-fun a () (_ String) "BabBabBabLyubaLyubaLyuba")
   (define-fun b () (_ String) "2")
   (define-fun q () (_ Int) 24))
  ((define-fun a () (_ String) "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"))
