
$ cat baba3.smt2
  $ Chro -dsimpl ./baba3.smt2 -stop-after simpl
  (assert (exists (%2 %4 a b)
          (and
            (= %2 (str.len b))(= %4 (str.len a))(= (+ (* (- 1) %1) %3 )  23)
            (= (+ (* (- 1) %2) pow2(%1) )  1)
            (= (+ (* (- 1) %4) pow2(%3) )  1)
            (str.in.re a (re.++ (re.++ (re.union (re.++ (str.to.re "b") (re.++ (str.to.re "a") (str.to.re "B"))) (re.++ (str.to.re "a") (re.++ (str.to.re "b") (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))))) (re.* (re.union (re.++ (str.to.re "b") (re.++ (str.to.re "a") (str.to.re "B"))) (re.++ (str.to.re "a") (re.++ (str.to.re "b") (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))))))) (re.* (str.to.re ""))))(str.in.re b (re.++ (re.++ (re.union (str.to.re "3") (str.to.re "2")) (re.* (re.union (str.to.re "3") (str.to.re "2")))) (re.* (str.to.re "")))))
  )
  $ Chro ./baba3.smt2
  sat (nfa)
  ((define-fun a () (_ String) "BabBabBabLyubaLyubaLyuba")
   (define-fun b () (_ String) "2")
   (define-fun q () (_ Int) 24))

