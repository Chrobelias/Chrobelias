
$ cat baba1.smt2
  $ Chro --dpresimpl ./baba1.smt2
  (and
    (= (+ (- 1) strlena (* (- 1) b)) 0)
    (<= (* (- 1) strlena) 0)
    (= (+ (* (- 1) strlena) strlenb) 0)
    (<= (* (- 1) strlena) 0)
    (chrob.len b (exp 10 strlenb))
    (<= (* (- 1) strlenb) 0)
    (<= (* (- 1) b) 0)
    (or
      (and
        (<= (* (- 1) %re_len1) 0)
        (= (+ (- 2) strlena (* (- 2) %re_len1)) 0))
      (and
        (<= (* (- 1) %re_len2) 0)
        (= (+ (- 3) strlena (* (- 2) %re_len2)) 0)))
    (str.in_re.raw b))
  (and
    (= (+ (- 1) strlena (* (- 1) b)) 0)
    (<= (* (- 1) strlena) 0)
    (= (+ (* (- 1) strlena) strlenb) 0)
    (<= (* (- 1) strlena) 0)
    (chrob.len b (exp 10 strlenb))
    (<= (* (- 1) strlenb) 0)
    (<= (+ 1 b) 0)
    (or
      (and
        (<= (* (- 1) %re_len3) 0)
        (= (+ (- 2) strlena (* (- 2) %re_len3)) 0))
      (and
        (<= (* (- 1) %re_len4) 0)
        (= (+ (- 3) strlena (* (- 2) %re_len4)) 0)))
    (str.in_re.raw b))
  unsat (nfa)
  no model
