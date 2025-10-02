trautest57
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest57.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest57 >> trautest57.smt2
$ cat trautest57.smt2
  $ timeout 2 Chro trautest57.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
