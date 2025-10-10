
$ cat baba1.smt2
  $ Chro -dpresimpl ./baba1.smt2
  (and
    (= %0 (str.len a))
    (= %0 (str.len b))
    (= %0 (+ 1 (str.to.int b)))
    (str.in_re a (re.++ (re.* (str.to.re "")) (re.++ (re.++ (re.union (re.++ (str.to.re "a") (str.to.re "B")) (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))) (re.* (re.union (re.++ (str.to.re "a") (str.to.re "B")) (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))))) (re.* (str.to.re "")))))
    (str.in_re b (re.++ (re.* (str.to.re "")) (re.++ (re.++ (re.union (re.++ (str.to.re "0") (str.to.re "2")) (re.++ (str.to.re "5") (str.to.re "2"))) (re.* (re.union (re.++ (str.to.re "0") (str.to.re "2")) (re.++ (str.to.re "5") (str.to.re "2"))))) (re.* (str.to.re ""))))))
  unsat
