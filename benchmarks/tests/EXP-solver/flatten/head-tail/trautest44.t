trautest44
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest44.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest44 >> trautest44.smt2
$ cat trautest44.smt2
  $ timeout 2 Chro trautest44.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
