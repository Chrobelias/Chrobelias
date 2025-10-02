trautest56
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest56.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest56 >> trautest56.smt2
$ cat trautest56.smt2
  $ timeout 2 Chro trautest56.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
