trautest64
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest64.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest64 >> trautest64.smt2
$ cat trautest64.smt2
  $ timeout 2 Chro trautest64.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
