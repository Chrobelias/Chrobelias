trautest13
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest13.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest13 >> trautest13.smt2
$ cat trautest13.smt2
  $ timeout 2 Chro trautest13.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
