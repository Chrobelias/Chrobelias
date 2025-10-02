trautest52
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest52.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest52 >> trautest52.smt2
$ cat trautest52.smt2
  $ timeout 2 Chro trautest52.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
