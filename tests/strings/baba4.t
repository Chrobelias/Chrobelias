
$ cat baba4.smt2
  $ Chro -dsimpl ./baba4.smt2 -stop-after simpl
  (assert (exists (b)
          (and
            (exists (a)
            (and
              (exists (%3)
              (and
                (= %3 (chrob.len a))
                (= (+ (* (- 1) %3) pow2(%4) )  1) 
                )
              
              (str.in.re a (re.++ (re.++ (str.to.re "a") (str.to.re "B")) (re.* (str.to.re ""))))
              )
            
            (exists (%5)
            (and
              (= %5 (chrob.len b))
              (= (+ (* (- 1) %5) pow2(%4) )  1) 
              )
            
            (str.in.re b (re.++ (re.++ (str.to.re "0") (str.to.re "2")) (re.* (str.to.re ""))))
            )
  )
$ export CHRO_DEBUG=1
  $ Chro ./baba4.smt2
  Warning: some of the eia model pieces are likely to be missed: %0 = %2
  ; Can't join models. Something may be missing
  ((define-fun a () (_ String) "Ba") (define-fun b () (_ String) "20"))
