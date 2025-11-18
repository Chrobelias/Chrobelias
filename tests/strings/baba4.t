
$ cat baba4.smt2
  $ Chro -dsimpl ./baba4.smt2 -stop-after simpl
  (assert (exists (b)
          (and
            (exists (a)
            (and
              (exists (%2)
              (and
                (= (+ %2 (* (- 1) pow2(%3)) )  -1) 
                (= %2 (chrob.len a))
                )
              
              (str.in.re a (re.++ (re.++ (str.to.re "a") (str.to.re "B")) (re.* (str.to.re ""))))
              )
            
            (exists (%4)
            (and
              (= (+ %4 (* (- 1) pow2(%5)) )  -1) 
              (= %4 (chrob.len b))
              )
            
            (exists (%0)
            (and
              (= (+ %0 (* (- 1) %3) )  0) 
              (= (+ %0 (* (- 1) %5) )  0) 
              )
            
            (str.in.re b (re.++ (re.++ (str.to.re "0") (str.to.re "2")) (re.* (str.to.re ""))))
            )
  )
$ export CHRO_DEBUG=1
  $ Chro ./baba4.smt2
  ((define-fun a () (_ String) "Ba") (define-fun b () (_ String) "20"))
