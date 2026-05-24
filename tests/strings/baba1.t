
$ cat baba1.smt2
  $ Chro --dpresimpl ./baba1.smt2
  Lightweight run:
  (and
                     (= strlena (+ 1 b))
                     (= strlena (+ 2 (* 2 %re_len1)))
                     (= strlenb strlena)
                     (<= 0 %re_len1)
                     (<= 0 b)
                     (<= 0 strlena)
                     (<= 1 strlenb)
                     (str.in_re.raw b)
                     (chrob.len b (exp 10 strlenb)))
  Lightweight run:
  (and
                     (= strlena (+ 1 b))
                     (= strlena (+ 3 (* 2 %re_len2)))
                     (= strlenb strlena)
                     (<= 0 %re_len2)
                     (<= 0 b)
                     (<= 0 strlena)
                     (<= 1 strlenb)
                     (str.in_re.raw b)
                     (chrob.len b (exp 10 strlenb)))
  (and
    (= strlena (+ 1 b))
    (= strlena (+ 2 (* 2 %re_len3)))
    (= strlenb strlena)
    (<= 0 %re_len3)
    (<= 0 b)
    (<= 0 strlena)
    (<= 1 strlenb)
    (str.in_re.raw b)
    (chrob.len b (exp 10 strlenb)))
  (and
    (= strlena (+ 1 b))
    (= strlena (+ 3 (* 2 %re_len4)))
    (= strlenb strlena)
    (<= 0 %re_len4)
    (<= 0 b)
    (<= 0 strlena)
    (<= 1 strlenb)
    (str.in_re.raw b)
    (chrob.len b (exp 10 strlenb)))
  unsat (nfa)
  no model
