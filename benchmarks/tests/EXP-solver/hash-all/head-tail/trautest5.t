trautest5
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest5.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest5 >> trautest5.smt2
$ cat trautest5.smt2
  $ timeout 2 Chro trautest5.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
