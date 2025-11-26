test75
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test75.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test75 >> test75.smt2
$ cat test75.smt2
  $ timeout 2 Chro test75.smt2  || echo TIMEOUT
  sat (nfa)
  Warning: some of the eia model pieces are likely to be missed: x = (+ 
                                                                     (* 
                                                                     (* (- 96553)
                                                                     q2) (- 1))
                                                                     (* 
                                                                     (* (- 1)
                                                                     (* 71218
                                                                     q4))
                                                                     (- 1)))
  ((define-fun q4 () (_ Int) 1)
   (define-fun r1 () (_ Int) 71218)
   (define-fun r3 () (_ Int) 0)
   (define-fun x () (_ String) "123459999"))
