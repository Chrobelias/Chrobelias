
$ cat baba2.smt2
  $ Chro  -dpresimpl ./baba2.smt2
  (and
    (= q (str.len a))
    (= q (str.len b))
    (= q (+ 1 (str.to.int b)))
    (str.in_re a (re.++ (re.* (str.to.re "")) (re.++ (re.++ (re.union (re.++ (str.to.re "a") (str.to.re "B")) (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))) (re.* (re.union (re.++ (str.to.re "a") (str.to.re "B")) (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))))) (re.* (str.to.re "")))))
    (str.in_re b (re.++ (re.* (str.to.re "")) (re.++ (re.++ (re.union (str.to.re "1") (str.to.re "0")) (re.* (re.union (str.to.re "1") (str.to.re "0")))) (re.* (str.to.re ""))))))
  sat ; nfa
  Warning: some of the eia model pieces are likely to be missed: q = %0
  ((define-fun a () (_ String) "Ba") (define-fun b () (_ String) "01"))

