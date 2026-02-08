
$ cat baba2.smt2
  $ Chro  --dpresimpl ./baba2.smt2
  (and
    (= %flat_pow4 (+ 1 b))
    (= (+ b (* (- 2) %re_len1)) 1)
    (<= 0 %re_len1)
    (<= (* (- 1) b) 1)
    (str.in_re.raw b)
    (chrob.len b (exp 10 %flat_pow4)))
  sat (nfa)
  (
     (define-fun a () String
      "Ba")
     (define-fun b () String
      "01")
     (define-fun q () Int
      2)
  )

