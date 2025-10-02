trautest92
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest92.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest92 >> trautest92.smt2
$ cat trautest92.smt2
  $ timeout 2 Chro trautest92.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
