
$ cat baba2.smt2
  $ Chro  --dpresimpl ./baba2.smt2
  Lightweight run:
  (and
                     (= (+ (- 1) (* (- 2) %re_len1) b) 0)
                     (= (+ 1 b (* (- 1) strlenb)) 0)
                     (<= (+ (- 1) (* (- 1) %re_len1)) 0)
                     (<= (+ 1 (* (- 1) strlenb)) 0)
                     (<= (* (- 1) %re_len1) 0)
                     (<= (* (- 1) b) 0)
                     (str.in_re.raw b)
                     (chrob.len b (exp 10 strlenb)))
  Lightweight run:
  (and
                     (= (+ (- 2) (* (- 2) %re_len2) b) 0)
                     (= (+ 1 b (* (- 1) strlenb)) 0)
                     (<= (+ (- 3) (* (- 2) %re_len2)) 0)
                     (<= (+ 1 (* (- 1) strlenb)) 0)
                     (<= (* (- 1) %re_len2) 0)
                     (<= (* (- 1) b) 0)
                     (str.in_re.raw b)
                     (chrob.len b (exp 10 strlenb)))
  (and
    (= (+ (- 1) (* (- 2) %re_len3) b) 0)
    (= (+ 1 b (* (- 1) strlenb)) 0)
    (<= (+ (- 1) (* (- 1) %re_len3)) 0)
    (<= (+ 1 (* (- 1) strlenb)) 0)
    (<= (* (- 1) %re_len3) 0)
    (<= (* (- 1) b) 0)
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

