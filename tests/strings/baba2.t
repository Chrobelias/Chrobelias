
$ cat baba2.smt2
  $ Chro  -dpresimpl ./baba2.smt2
  (and
    (and
      (= q %1)
      (= q %3)
      (= q (+ 1 (str.to.int b)))
      (str.in_re a (re.++ (re.++ (re.union (re.++ (str.to.re "a") (str.to.re "B")) (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))) (re.* (re.union (re.++ (str.to.re "a") (str.to.re "B")) (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))))) (re.* (str.to.re ""))))
      (str.in_re b (re.++ (re.++ (re.union (str.to.re "1") (str.to.re "0")) (re.* (re.union (str.to.re "1") (str.to.re "0")))) (re.* (str.to.re "")))))
    (= %2 (+ (exp 10 %3) (- 1)))
    (= %0 (+ (exp 10 %1) (- 1)))
    (= %2 (chrob.len b))
    (= %0 (chrob.len a)))
  sat (nfa)
  ((define-fun a () (_ String) "Ba")
   (define-fun b () (_ String) "01")
   (define-fun q () (_ String) "2"))

