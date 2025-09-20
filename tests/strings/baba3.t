
$ cat baba3.smt2
  $ Chro -dsimpl ./baba3.smt2 -stop-after simpl
  (assert (exists (q b a %4 %2 %0)
          (and
            (= (+ %0 (* (- 1) %1) )  0)
            (= %2 (str.len b))(= (+ (* (- 1) %2) pow2(%1) )  1)
            (= (+ (* (- 1) %3) q )  0)
            (= %4 (str.len a))(= (+ (* (- 1) %4) pow2(%3) )  1)
            (= (+ (* (- 1) %0) q )  23)
            (str.in.re a (re.++ (re.++ (re.union (re.++ (str.to.re "b") (re.++ (str.to.re "a") (str.to.re "B"))) (re.++ (str.to.re "a") (re.++ (str.to.re "b") (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))))) (re.* (re.union (re.++ (str.to.re "b") (re.++ (str.to.re "a") (str.to.re "B"))) (re.++ (str.to.re "a") (re.++ (str.to.re "b") (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))))))) (re.* (str.to.re ""))))(str.in.re b (re.++ (re.++ (re.union (str.to.re "3") (str.to.re "2")) (re.* (re.union (str.to.re "3") (str.to.re "2")))) (re.* (str.to.re "")))))
  )
  $ Chro ./baba3.smt2
  sat (nfa)
  ((define-fun %22 () (_ String) "000000000000000000000001")
   (define-fun %23 () (_ String) "0000000000000000000000001")
   (define-fun %24 () (_ String) "000000000000000000000009")
   (define-fun %25 () (_ String) "0000000000000000000000024")
   (define-fun %26 () (_ String) "999999999999999999999999")
   (define-fun a () (_ String) "BabBabBabLyubaLyubaLyuba")
   (define-fun b () (_ String) "2")
   (define-fun q () (_ String) "000000000000000000000024"))

