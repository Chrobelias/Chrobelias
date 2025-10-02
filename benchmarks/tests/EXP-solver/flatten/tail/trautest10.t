trautest10
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest10.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest10 >> trautest10.smt2
$ cat trautest10.smt2
  $ timeout 2 Chro trautest10.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
