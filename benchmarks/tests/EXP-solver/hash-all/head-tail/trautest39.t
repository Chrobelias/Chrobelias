trautest39
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest39.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest39 >> trautest39.smt2
$ cat trautest39.smt2
  $ timeout 2 Chro trautest39.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
