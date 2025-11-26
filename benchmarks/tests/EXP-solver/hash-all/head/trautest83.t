trautest83
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest83.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest83 >> trautest83.smt2
$ cat trautest83.smt2
  $ timeout 2 Chro trautest83.smt2  || echo TIMEOUT
  sat (nfa)
  Warning: some of the eia model pieces are likely to be missed: x = (+ 
                                                                     (* 
                                                                     (* (- 419623)
                                                                     q2) (- 1))
                                                                     (* 
                                                                     (* (- 1)
                                                                     (* 179891
                                                                     q4))
                                                                     (- 1)))
  ((define-fun q4 () (_ Int) 2)
   (define-fun r1 () (_ Int) 359782)
   (define-fun r3 () (_ Int) 0)
   (define-fun x () (_ String) "123459999"))
