trautest59
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest59.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest59 >> trautest59.smt2
$ cat trautest59.smt2
  $ timeout 2 Chro trautest59.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
