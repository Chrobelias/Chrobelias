Test on LIA with Buchi-V predicate (symbolic)
  $ ParSym example_buchi.smt2
  sat

Test on LIA with Buchi-V predicate (parametric)
  $ timeout 5 ParSym example_buchi.smt2 -par
  timeout
  [124]

Test on LIA with Buchi-V predicate from Intro (symbolic) in bases 2--10
  $ ParSym example_intro.smt2 -bmin 2 -bmax 10
  sat

Test on LIA with Buchi-V predicate from Intro (symbolic) in bases 200--210
  $ ParSym example_intro.smt2 -bmin 200 -bmax 210
  sat

Test on LIA with Buchi-V predicate from Intro (parametric) in bases 2--10
  $ ParSym example_intro.smt2 -bmin 2 -bmax 10 -par
  sat

Test on LIA with Buchi-V predicate from Intro (parametric) in bases 200--210
  $ ParSym example_intro.smt2 -bmin 200 -bmax 210 -par
  sat
