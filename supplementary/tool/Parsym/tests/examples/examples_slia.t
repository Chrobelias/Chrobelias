Example with regular and LIA constrints with lazy computations
  $ ParSym example.smt2 -lazy --depth 2 --seed 40
  sat

Example with regular and LIA constrints TO = 5 sec
  $ timeout 3 ParSym example.smt2 --depth 2
  sat

Example with LIA constrints with lazy computations
  $ ParSym example_int.smt2 -lazy --depth 2
  sat

Example with LIA constrints TO = 5 sec
  $ timeout 3 ParSym example_int.smt2 --depth 2
  timeout
  [124]


