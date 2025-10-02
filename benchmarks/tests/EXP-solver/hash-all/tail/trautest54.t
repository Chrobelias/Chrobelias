trautest54
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest54.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest54 >> trautest54.smt2
$ cat trautest54.smt2
  $ timeout 2 Chro trautest54.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
