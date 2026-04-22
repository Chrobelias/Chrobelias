
$ cat baba2.smt2
  $ Chro  --dpresimpl ./baba2.smt2
  (and
    (= (+ 1 (* (- 1) strlena) b) 0)
    (<= (* (- 1) strlena) 0)
    (= (+ 1 (* (- 1) strlenb) b) 0)
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
  sat (nfa)
  (
     (define-fun a () String
      "Ba")
     (define-fun b () String
      "01")
     (define-fun q () Int
      2)
  )

