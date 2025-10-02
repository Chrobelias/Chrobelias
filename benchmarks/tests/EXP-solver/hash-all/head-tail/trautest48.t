trautest48
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest48.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest48 >> trautest48.smt2
$ cat trautest48.smt2
  $ timeout 2 Chro trautest48.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
