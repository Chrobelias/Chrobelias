test86
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test86.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test86 >> test86.smt2
$ cat test86.smt2
  $ timeout 2 Chro test86.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
