trautest86
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest86.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest86 >> trautest86.smt2
$ cat trautest86.smt2
  $ timeout 2 Chro trautest86.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
