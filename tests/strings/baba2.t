
$ cat baba2.smt2
  $ Chro  --dpresimpl ./baba2.smt2
  (and
    (= (+ 1 b) strlenb)
    (= (+ b (* (- 2) %re_len1)) 1)
    (<= 0 %re_len1)
    (<= (exp 10 0) (exp 10 strlenb))
    (<= (+ 1 b) (exp 10 strlenb))
    (<= (* (- 1) b) 1)
    (str.in_re.raw b)
    (chrob.len b (exp 10 strlenb)))
  sat (nfa)
  ((define-fun a () (_ String) "Ba") (define-fun b () (_ String) "01"))

