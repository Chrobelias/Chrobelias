test44
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test44.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test44 >> test44.smt2
$ cat test44.smt2
  $ timeout 2 Chro test44.smt2  || echo TIMEOUT
  sat (nfa)
  Warning: some of the eia model pieces are likely to be missed: x = (+ 
                                                                     (* 
                                                                     (* (- 9901)
                                                                     q2) (- 1))
                                                                     (* 
                                                                     (* (- 1)
                                                                     (* 3368
                                                                     q4))
                                                                     (- 1)))
  ((define-fun q4 () (_ Int) 2)
   (define-fun r1 () (_ Int) 6736)
   (define-fun r3 () (_ Int) 0)
   (define-fun x () (_ String) "123459999"))
