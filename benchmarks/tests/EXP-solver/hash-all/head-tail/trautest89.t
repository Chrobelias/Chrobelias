trautest89
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest89.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest89 >> trautest89.smt2
$ cat trautest89.smt2
  $ timeout 2 Chro trautest89.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
