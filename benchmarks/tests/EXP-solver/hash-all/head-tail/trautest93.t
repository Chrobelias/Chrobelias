trautest93
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest93.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest93 >> trautest93.smt2
$ cat trautest93.smt2
  $ timeout 2 Chro trautest93.smt2  || echo TIMEOUT
  sat (nfa)
  Warning: some of the eia model pieces are likely to be missed: x = (+ 
                                                                     (* 
                                                                     (* (- 226549)
                                                                     q2) (- 1))
                                                                     (* 
                                                                     (* (- 1)
                                                                     (* 182302
                                                                     q4))
                                                                     (- 1)))
  ((define-fun q4 () (_ Int) 1)
   (define-fun r1 () (_ Int) 182302)
   (define-fun r3 () (_ Int) 0)
   (define-fun x () (_ String) "123459999"))
