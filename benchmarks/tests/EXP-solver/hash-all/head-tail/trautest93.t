trautest93
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest93.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest93 >> trautest93.smt2
$ cat trautest93.smt2
  $ timeout 2 Chro trautest93.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
