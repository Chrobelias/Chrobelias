test36
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test36.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test36 >> test36.smt2
$ cat test36.smt2
  $ timeout 2 Chro test36.smt2  || echo TIMEOUT
  sat (nfa)
  Warning: some of the eia model pieces are likely to be missed: x = (+ 
                                                                     (* 
                                                                     (* (- 8821)
                                                                     q2) (- 1))
                                                                     (* 
                                                                     (* (- 1)
                                                                     (* 2073
                                                                     q4))
                                                                     (- 1)))
  ((define-fun q4 () (_ Int) 4)
   (define-fun r1 () (_ Int) 8292)
   (define-fun r3 () (_ Int) 0)
   (define-fun x () (_ String) "123459999"))
