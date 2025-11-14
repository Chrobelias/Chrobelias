  $ cp ../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn14.koat_27.smt2 input.smt2
  $ export OCAMLRUNPARAM='b=0'
  $ Chro input.smt2 | sed 's/[[:space:]]*$//'
  sat (under I)
$ time -f "%U"

  $ timeout 5 Chro input.smt2  -bound 0
  sat (under I)

$ time -f "%U"
It's luck that Z3 gives an answer. Just try
(assert (<= 1000 it140))
  $ timeout 2 Chro -bound 1 --no-pre-simpl --no-alpha --no-mono input.smt2
  sat (under I)
