
$ cat baba1.smt2
  $ Chro -dpresimpl ./baba1.smt2
  (and
    (and
      (= %0 %3)
      (= %0 %5)
      (= %0 (+ 1 (str.to.int b)))
      (str.in_re a (re.++ (re.++ (re.union (re.++ (str.to.re "a") (str.to.re "B")) (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))) (re.* (re.union (re.++ (str.to.re "a") (str.to.re "B")) (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))))) (re.* (str.to.re ""))))
      (str.in_re b (re.++ (re.++ (re.union (re.++ (str.to.re "0") (str.to.re "2")) (re.++ (str.to.re "5") (str.to.re "2"))) (re.* (re.union (re.++ (str.to.re "0") (str.to.re "2")) (re.++ (str.to.re "5") (str.to.re "2"))))) (re.* (str.to.re "")))))
    (= %4 (+ (exp 10 %5) (- 1)))
    (= %2 (+ (exp 10 %3) (- 1)))
    (= %4 (chrob.len b))
    (= %2 (chrob.len a)))
  unsat
