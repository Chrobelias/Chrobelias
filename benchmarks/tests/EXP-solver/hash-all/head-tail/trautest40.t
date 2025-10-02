trautest40
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest40.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest40 >> trautest40.smt2
$ cat trautest40.smt2
  $ timeout 2 Chro trautest40.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
