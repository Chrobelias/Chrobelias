
$ cat baba2.smt2
  $ Chro  -dpresimpl ./baba2.smt2
  (and
    (= q (str.len a))
    (= q (str.len b))
    (= q (+ 1 (str.to.int b)))
    (str.in_re a (re.++ (re.++ (re.union (re.++ (str.to.re "a") (str.to.re "B")) (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))) (re.* (re.union (re.++ (str.to.re "a") (str.to.re "B")) (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))))) (re.* (str.to.re ""))))
    (str.in_re b (re.++ (re.++ (re.union (str.to.re "1") (str.to.re "0")) (re.* (re.union (str.to.re "1") (str.to.re "0")))) (re.* (str.to.re "")))))
  sat (nfa)
  %25 = 01; %26 = 002; %27 = 99; %28 = 002; %29 = 99; a = Ba; b = 01; q = 02; 

