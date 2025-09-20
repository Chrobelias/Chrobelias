
$ cat baba2.smt2
  $ Chro  -dpresimpl ./baba2.smt2
  (and
    (= q (str.len a))
    (= q (str.len b))
    (= q (+ 1 (str.to.int b)))
    (str.in_re a (re.++ (re.++ (re.union (re.++ (str.to.re "a") (str.to.re "B")) (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))) (re.* (re.union (re.++ (str.to.re "a") (str.to.re "B")) (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))))) (re.* (str.to.re ""))))
    (str.in_re b (re.++ (re.++ (re.union (str.to.re "1") (str.to.re "0")) (re.* (re.union (str.to.re "1") (str.to.re "0")))) (re.* (str.to.re "")))))
  sat (nfa)
  (and
    (= q (str.len a))
    (= q (str.len b))
    (= q (+ 1 (str.to.int b)))
    (str.in_re a (re.++ (re.++ (re.union (re.++ (str.to.re "a") (str.to.re "B")) (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))) (re.* (re.union (re.++ (str.to.re "a") (str.to.re "B")) (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))))) (re.* (str.to.re ""))))
    (str.in_re b (re.++ (re.++ (re.union (str.to.re "1") (str.to.re "0")) (re.* (re.union (str.to.re "1") (str.to.re "0")))) (re.* (str.to.re "")))))
  (
   (define-fun %24 () (_ String) "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101")
   (define-fun %25 () (_ String) "99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
   (define-fun %26 () (_ String) "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101")
   (define-fun %27 () (_ String) "99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")
   (define-fun %28 () (_ String) "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100")
   (define-fun a () (_ String) "LyuBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBaBa")
   (define-fun b () (_ String) "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100")
   (define-fun q () (_ String) "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101"))

