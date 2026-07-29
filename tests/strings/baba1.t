
$ cat baba1.smt2
  $ Chro --dpresimpl ./baba1.smt2
  (and
    (= (+ (- 2) %0flat_pow3 (* (- 2) %re_len1)) 0)
    (= (+ 1 (* (- 1) b) (* 2 %re_len1)) 0)
    (<= (+ (- 2) (* (- 2) %re_len1)) 0)
    (<= (+ (- 1) (* (- 2) %re_len1)) 0)
    (<= (* (- 1) %re_len1) 0)
    (<= (* (- 1) b) 0)
    (str.in_re.raw b)
    (chrob.len b (exp 10 %0flat_pow3)))
  (and
    (= (+ (- 3) %0flat_pow4 (* (- 2) %re_len2)) 0)
    (= (+ 2 (* (- 1) b) (* 2 %re_len2)) 0)
    (<= (+ (- 3) (* (- 2) %re_len2)) 0)
    (<= (+ (- 2) (* (- 2) %re_len2)) 0)
    (<= (* (- 1) %re_len2) 0)
    (<= (* (- 1) b) 0)
    (str.in_re.raw b)
    (chrob.len b (exp 10 %0flat_pow4)))
  unsat (nfa)
  no model
