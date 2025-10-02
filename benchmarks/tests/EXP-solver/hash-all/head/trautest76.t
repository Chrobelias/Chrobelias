trautest76
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest76.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest76 >> trautest76.smt2
$ cat trautest76.smt2
  $ timeout 2 Chro trautest76.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
