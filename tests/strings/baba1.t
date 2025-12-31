
$ cat baba1.smt2
  $ Chro --dpresimpl ./baba1.smt2
  (and
    (<= 0 %re_len1)
    (<= (+ 2 (* 2 %re_len1)) (exp 10 (+ 2 (* 2 %re_len1))))
    (<= (* (- 2) %re_len1) 2)
    (str.in_re.raw (+ 1 (* 2 %re_len1)))
    (chrob.len (+ 1 (* 2 %re_len1)) (exp 10 (+ 2 (* 2 %re_len1)))))
  (and
    (<= 0 %re_len2)
    (<= (+ 3 (* 2 %re_len2)) (exp 10 (+ 3 (* 2 %re_len2))))
    (<= (* (- 2) %re_len2) 3)
    (str.in_re.raw (+ 2 (* 2 %re_len2)))
    (chrob.len (+ 2 (* 2 %re_len2)) (exp 10 (+ 3 (* 2 %re_len2)))))
  unsat (nfa)
