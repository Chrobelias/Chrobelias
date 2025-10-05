test61
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test61.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test61 >> test61.smt2
$ cat test61.smt2
  $ timeout 2 Chro test61.smt2  || echo TIMEOUT
  sat (nfa)
  Warning: some of the eia model pieces are likely to be missed: x = (+ 
                                                                     (* 
                                                                     (* (- 80329)
                                                                     q2) (- 1))
                                                                     (* 
                                                                     (* (- 1)
                                                                     (* 10503
                                                                     q4))
                                                                     (- 1)))
  ((define-fun q4 () (_ Int) 7)
   (define-fun r1 () (_ Int) 73521)
   (define-fun r3 () (_ Int) 0)
   (define-fun x () (_ String) "123459999"))
