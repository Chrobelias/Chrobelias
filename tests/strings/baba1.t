
$ cat baba1.smt2
  $ Chro --dpresimpl ./baba1.smt2
  Light run:
  (and
               (= strlenb (+ 1 b))
               (= (+ b (* (- 2) %re_len1)) 1)
               (<= 0 %re_len1)
               (<= 0 strlenb)
               (<= (* (- 1) b) 1)
               (str.in_re.raw b)
               (chrob.len b (exp 10 strlenb)))
  Light run:
  (and
               (= strlenb (+ 1 b))
               (= (+ b (* (- 2) %re_len2)) 2)
               (<= 0 %re_len2)
               (<= 0 strlenb)
               (<= (* (- 1) b) 1)
               (str.in_re.raw b)
               (chrob.len b (exp 10 strlenb)))
  (and
    (= strlenb (+ 1 b))
    (= (+ b (* (- 2) %re_len5)) 1)
    (<= 0 %re_len5)
    (<= 0 strlenb)
    (<= (* (- 1) b) 1)
    (str.in_re.raw b)
    (chrob.len b (exp 10 strlenb)))
  (and
    (= strlenb (+ 1 b))
    (= (+ b (* (- 2) %re_len6)) 2)
    (<= 0 %re_len6)
    (<= 0 strlenb)
    (<= (* (- 1) b) 1)
    (str.in_re.raw b)
    (chrob.len b (exp 10 strlenb)))
  unsat (nfa)
  no model
