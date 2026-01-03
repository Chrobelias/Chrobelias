
$ cat baba1.smt2
  $ Chro --dpresimpl ./baba1.smt2
  (and
    (= (+ b (* (- 2) %re_len1)) 1)
    (<= 0 %re_len1)
    (<= (+ 1 b) (exp 10 (+ 1 b)))
    (<= (* (- 1) b) 1)
    (str.in_re.raw b)
    (chrob.len b (exp 10 (+ 1 b))))
  (and
    (= (+ b (* (- 2) %re_len2)) 2)
    (<= 0 %re_len2)
    (<= (+ 1 b) (exp 10 (+ 1 b)))
    (<= (* (- 1) b) 1)
    (str.in_re.raw b)
    (chrob.len b (exp 10 (+ 1 b))))
  unsat (nfa)
  no model
