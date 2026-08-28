  $ cp ../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn14.koat_27.smt2 input.smt2
  $ export OCAMLRUNPARAM='b=0'
  $ Chro input.smt2 | sed 's/[[:space:]]*$//'
  sat (nia)
$ time -f "%U"

  $ timeout 60 Chro input.smt2  -bound 0
  sat (nia)

$ time -f "%U"
It's luck that Z3 gives an answer. Just try
(assert (<= 1000 it140))
  $ timeout 60 Chro -bound 1 input.smt2
  sat (nia)
