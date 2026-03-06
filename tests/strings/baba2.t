
$ cat baba2.smt2
  $ Chro  --dpresimpl ./baba2.smt2
  Light run:
  (and
               (= strlenb (+ 1 b))
               (= strlenb (+ 2 (* 2 %re_len1)))
               (<= 0 %re_len1)
               (<= 0 strlenb)
               (str.in_re.raw b)
               (chrob.len b (exp 10 strlenb)))
  Light run:
  (and
               (= strlenb (+ 1 b))
               (= strlenb (+ 3 (* 2 %re_len2)))
               (<= 0 %re_len2)
               (<= 0 strlenb)
               (str.in_re.raw b)
               (chrob.len b (exp 10 strlenb)))
  (and
    (= strlenb (+ 1 b))
    (= strlenb (+ 2 (* 2 %re_len5)))
    (<= 0 %re_len5)
    (<= 0 strlenb)
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

