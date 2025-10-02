trautest51
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest51.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest51 >> trautest51.smt2
$ cat trautest51.smt2
  $ timeout 2 Chro trautest51.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
