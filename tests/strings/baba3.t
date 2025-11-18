
$ cat baba3.smt2
  $ Chro -dsimpl ./baba3.smt2 -stop-after simpl
  (assert (exists (q)
          (and
            (exists (b)
            (and
              (exists (%1)
              (and
                (= (+ %1 (* (- 1) pow2(%2)) )  -1) 
                (= %1 (chrob.len b))
                )
              
              (str.in.re b (re.++ (re.++ (re.union (str.to.re "3") (str.to.re "2")) (re.* (re.union (str.to.re "3") (str.to.re "2")))) (re.* (str.to.re ""))))
              )
            
            (exists (a)
            (and
              (exists (%3)
              (and
                (= (+ %3 (* (- 1) pow2(%4)) )  -1) 
                (= %3 (chrob.len a))
                )
              
              (str.in.re a (re.++ (re.++ (re.union (re.++ (str.to.re "b") (re.++ (str.to.re "a") (str.to.re "B"))) (re.++ (str.to.re "a") (re.++ (str.to.re "b") (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))))) (re.* (re.union (re.++ (str.to.re "b") (re.++ (str.to.re "a") (str.to.re "B"))) (re.++ (str.to.re "a") (re.++ (str.to.re "b") (re.++ (str.to.re "u") (re.++ (str.to.re "y") (str.to.re "L")))))))) (re.* (str.to.re ""))))
              )
            
            (exists (%0)
            (and
              (= (+ %0 (* (- 1) %2) )  0) 
              (= (+ (* (- 1) %0) q )  23) 
              )
            
            (= (+ (* (- 1) %4) q )  0) 
            )
  )
  $ Chro ./baba3.smt2
  sat (nfa)
  ((define-fun a () (_ String) "BabBabBabBabBabBabBabBab")
   (define-fun b () (_ String) "3")
   (define-fun q () (_ String) "24"))

