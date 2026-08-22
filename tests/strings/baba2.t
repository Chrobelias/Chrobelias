
$ cat baba2.smt2
  $ Chro  --dpresimpl ./baba2.smt2
  (and
    (= (+ (- 1) (* (- 2) %re_len1) b) 0)
    (= (+ 1 b (* (- 1) strlenb)) 0)
    (<= (+ (- 2) (* (- 2) %re_len1)) 0)
    (<= (+ 1 (* (- 1) strlenb)) 0)
    (<= (* (- 1) %re_len1) 0)
    (<= (* (- 1) b) 0)
    (str.in_re.raw b)
    (chrob.len b (** 10 strlenb)))
  sat (nfa)
  (
     (define-fun a () String
      "Ba")
     (define-fun b () String
      "01")
     (define-fun q () Int
      2)
  )

