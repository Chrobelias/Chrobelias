
$ cat baba1.smt2
  $ Chro --dpresimpl ./baba1.smt2
  (and
    (= %flat_pow3 (+ 1 b))
    (= (+ b (* (- 2) %re_len1)) 1)
    (<= 0 %re_len1)
    (<= (* (- 1) b) 1)
    (str.in_re.raw b)
    (chrob.len b (exp 10 %flat_pow3)))
  (and
    (= %flat_pow4 (+ 1 b))
    (= (+ b (* (- 2) %re_len2)) 2)
    (<= 0 %re_len2)
    (<= (* (- 1) b) 1)
    (str.in_re.raw b)
    (chrob.len b (exp 10 %flat_pow4)))
  unsat (nfa)
  no model
