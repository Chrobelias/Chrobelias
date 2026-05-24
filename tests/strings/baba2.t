
$ cat baba2.smt2
  $ Chro  --dpresimpl ./baba2.smt2
  Lightweight run:
  (and
                     (= strlena strlenb)
                     (= strlena (+ 1 b))
                     (= strlena (+ 2 (* 2 %re_len1)))
                     (<= 0 %re_len1)
                     (<= 0 b)
                     (<= 0 strlena)
                     (<= 1 strlenb)
                     (str.in_re.raw b)
                     (chrob.len b (exp 10 strlenb)))
  Lightweight run:
  (and
                     (= strlena strlenb)
                     (= strlena (+ 1 b))
                     (= strlena (+ 3 (* 2 %re_len2)))
                     (<= 0 %re_len2)
                     (<= 0 b)
                     (<= 0 strlena)
                     (<= 1 strlenb)
                     (str.in_re.raw b)
                     (chrob.len b (exp 10 strlenb)))
  (and
    (= strlena strlenb)
    (= strlena (+ 1 b))
    (= strlena (+ 2 (* 2 %re_len3)))
    (<= 0 %re_len3)
    (<= 0 b)
    (<= 0 strlena)
    (<= 1 strlenb)
    (str.in_re.raw b)
    (chrob.len b (exp 10 strlenb)))
  sat (nfa)
  (
     (define-fun a () String
      "Ba")
     (define-fun b () String
      "01")
     (define-fun q () Int
      2)
  )

