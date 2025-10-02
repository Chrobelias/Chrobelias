trautest87
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest87.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest87 >> trautest87.smt2
$ cat trautest87.smt2
  $ timeout 2 Chro trautest87.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
