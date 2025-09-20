Basic QF_S tests

  $ Chro ./qf-s.smt2
  sat (nfa)
  ((define-fun x () (_ String) "abc"))
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
  ((define-fun %40 () (_ String) "0000000000012")
   (define-fun %41 () (_ String) "999999999999")
   (define-fun x () (_ String) "100100100100"))
  ((define-fun %45 () (_ String) "000000000000000000000023")
   (define-fun %46 () (_ String) "99999999999999999999999")
   (define-fun x () (_ String) "LyuBaBaBaBaBaBaBaBaBaBa"))
  ((define-fun %50 () (_ String) "02")(define-fun %51 () (_ String) "02")
   (define-fun %52 () (_ String) "002")(define-fun %53 () (_ String) "99")
   (define-fun %54 () (_ String) "002")(define-fun %55 () (_ String) "99")
   (define-fun a () (_ String) "Ba")(define-fun b () (_ String) "20"))
  (
   (define-fun %58 () (_ String) "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101")
   (define-fun %59 () (_ String) "99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
   (define-fun %60 () (_ String) "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101")
   (define-fun %61 () (_ String) "99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
   (define-fun %62 () (_ String) "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100")
   (define-fun a () (_ String) "LyuBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBa")
   (define-fun b () (_ String) "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100")
   (define-fun q () (_ String) "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101"))
  ((define-fun %82 () (_ String) "000000000000000000000001")
   (define-fun %83 () (_ String) "0000000000000000000000001")
   (define-fun %84 () (_ String) "000000000000000000000009")
   (define-fun %85 () (_ String) "0000000000000000000000024")
   (define-fun %86 () (_ String) "999999999999999999999999")
   (define-fun a () (_ String) "BabBabBabLyubaLyubaLyuba")
   (define-fun b () (_ String) "2")
   (define-fun q () (_ String) "000000000000000000000024"))
