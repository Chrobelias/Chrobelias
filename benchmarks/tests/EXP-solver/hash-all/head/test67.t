test67
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test67.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test67 >> test67.smt2
$ cat test67.smt2
  $ timeout 2 Chro test67.smt2  || echo TIMEOUT
  sat (nfa)
  Warning: some of the eia model pieces are likely to be missed: x = (+ 
                                                                     (* 
                                                                     (* (- 75707)
                                                                     q2) (- 1))
                                                                     (* 
                                                                     (* (- 1)
                                                                     (* 31285
                                                                     q4))
                                                                     (- 1)))
  ((define-fun q4 () (_ Int) 2)
   (define-fun r1 () (_ Int) 62570)
   (define-fun r3 () (_ Int) 0)
   (define-fun x () (_ String) "123459999"))
