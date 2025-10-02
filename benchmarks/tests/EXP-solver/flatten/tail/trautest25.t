trautest25
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest25.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest25 >> trautest25.smt2
$ cat trautest25.smt2
  $ timeout 2 Chro trautest25.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
