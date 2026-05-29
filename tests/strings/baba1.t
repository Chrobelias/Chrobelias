
$ cat baba1.smt2
  $ Chro --dpresimpl ./baba1.smt2
  Lightweight run:
  (and
                     (= (+ (- 2) (* (- 2) %re_len1) strlenb) 0)
                     (= (+ 1 (* (- 1) b) (* 2 %re_len1)) 0)
                     (<= (+ (- 1) (* (- 1) %re_len1)) 0)
                     (<= (+ 1 (* (- 1) strlenb)) 0)
                     (<= (* (- 1) %re_len1) 0)
                     (<= (* (- 1) b) 0)
                     (str.in_re.raw b)
                     (chrob.len b (exp 10 strlenb)))
  Lightweight run:
  (and
                     (= (+ (- 3) (* (- 2) %re_len2) strlenb) 0)
                     (= (+ 2 (* (- 1) b) (* 2 %re_len2)) 0)
                     (<= (+ (- 3) (* (- 2) %re_len2)) 0)
                     (<= (+ 1 (* (- 1) strlenb)) 0)
                     (<= (* (- 1) %re_len2) 0)
                     (<= (* (- 1) b) 0)
                     (str.in_re.raw b)
                     (chrob.len b (exp 10 strlenb)))
  (and
    (= (+ (- 2) (* (- 2) %re_len3) strlenb) 0)
    (= (+ 1 (* (- 1) b) (* 2 %re_len3)) 0)
    (<= (+ (- 1) (* (- 1) %re_len3)) 0)
    (<= (+ 1 (* (- 1) strlenb)) 0)
    (<= (* (- 1) %re_len3) 0)
    (<= (* (- 1) b) 0)
    (str.in_re.raw b)
    (chrob.len b (exp 10 strlenb)))
  (and
    (= (+ (- 3) (* (- 2) %re_len4) strlenb) 0)
    (= (+ 2 (* (- 1) b) (* 2 %re_len4)) 0)
    (<= (+ (- 3) (* (- 2) %re_len4)) 0)
    (<= (+ 1 (* (- 1) strlenb)) 0)
    (<= (* (- 1) %re_len4) 0)
    (<= (* (- 1) b) 0)
    (str.in_re.raw b)
    (chrob.len b (exp 10 strlenb)))
  unsat (nfa)
  no model
