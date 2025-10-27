test59
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test59.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test59 >> test59.smt2
$ cat test59.smt2
  $ timeout 2 Chro test59.smt2  || echo TIMEOUT
  sat (nfa)
  Warning: some of the eia model pieces are likely to be missed: x = (+ 
                                                                     (* 
                                                                     (* (- 49639)
                                                                     q2) (- 1))
                                                                     (* 
                                                                     (* (- 1)
                                                                     (* 41549
                                                                     q4))
                                                                     (- 1)))
  ((define-fun q4 () (_ Int) 1)
   (define-fun r1 () (_ Int) 41549)
   (define-fun r3 () (_ Int) 0)
   (define-fun x () (_ String) "123459999"))
