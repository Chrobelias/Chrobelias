trautest17
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest17.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest17 >> trautest17.smt2
$ cat trautest17.smt2
  $ timeout 2 Chro trautest17.smt2  || echo TIMEOUT
  sat (nfa)
  Warning: some of the eia model pieces are likely to be missed: x = (+ 
                                                                     (* 
                                                                     (* (- 109)
                                                                     q2) (- 1))
                                                                     (* 
                                                                     (* (- 1)
                                                                     (* 6 q4))
                                                                     (- 1)))
  ((define-fun q4 () (_ Int) 9)
   (define-fun r1 () (_ Int) 54)
   (define-fun r3 () (_ Int) 0)
   (define-fun x () (_ String) "123459999"))
