trautest69
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest69.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest69 >> trautest69.smt2
$ cat trautest69.smt2
  $ timeout 2 Chro trautest69.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
