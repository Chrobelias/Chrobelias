
$ cat baba2.smt2
  $ Chro  --dpresimpl ./baba2.smt2
  (and
    (= (+ b (* (- 2) %re_len1)) 1)
    (<= 0 %re_len1)
    (<= (* (- 1) b) 1)
    (str.in_re.raw b)
    (chrob.len b (exp 10 (+ 1 b))))
  sat (nfa)
  ((define-fun a () (_ String) "Ba") (define-fun b () (_ String) "01"))

