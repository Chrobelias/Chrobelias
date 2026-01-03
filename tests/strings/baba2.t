
$ cat baba2.smt2
  $ Chro  --dpresimpl ./baba2.smt2
  (and
    (<= (exp 10 0) (exp 10 %re_len1))
    (<= (+ 2 (* 2 %re_len1)) (exp 10 (+ 2 (* 2 %re_len1))))
    (<= (* (- 2) %re_len1) 2)
    (str.in_re.raw (+ 1 (* 2 %re_len1)))
    (chrob.len (+ 1 (* 2 %re_len1)) (exp 10 (+ 2 (* 2 %re_len1)))))
  sat (nfa)
  ((define-fun a () (_ String) "Ba") (define-fun b () (_ String) "01"))

