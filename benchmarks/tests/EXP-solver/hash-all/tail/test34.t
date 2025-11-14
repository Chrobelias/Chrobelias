test34
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test34.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test34 >> test34.smt2
$ cat test34.smt2
  $ timeout 2 Chro test34.smt2  || echo TIMEOUT
  sat (nfa)
  Warning: some of the eia model pieces are likely to be missed: x = (+ 
                                                                     (* 
                                                                     (* (- 4201)
                                                                     q2) (- 1))
                                                                     (* 
                                                                     (* (- 1)
                                                                     (* 2617
                                                                     q4))
                                                                     (- 1)))
  ((define-fun q4 () (_ Int) 1)
   (define-fun r1 () (_ Int) 2617)
   (define-fun r3 () (_ Int) 0)
   (define-fun x () (_ String) "123459999"))
