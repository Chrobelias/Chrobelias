Basic BW tests

  $ Chro ./bw.smt2
  Not implemented comparison:
  	((re.* (re.union (re.union (re.union (str.to.re "0
  0100000000000000000000000000000000000000000000000000000000000") (str.to.re "0
  100000000000000000000000000000000000000000000000000000000000
  0")) (str.to.re "000000000000000000000000000000000000000000000000000000000000
  00")) (str.to.re "11100000000000000000000000000000000000000000000000000000000
  00
  0"))) %2 + %0 + %1)
  	(-1%0 = -5)
  Fatal error: exception File "lib/Simpl_alpha.ml", line 50, characters 6-12: Assertion failed
  Raised at Lib__Simpl_alpha.alpha_compare.helper in file "lib/Simpl_alpha.ml", line 50, characters 6-18
  Called from Base__List.dedup_and_sort.rev_merge in file "src/list.ml", line 777, characters 13-22
  Called from Base__List.dedup_and_sort.rev_sort in file "src/list.ml", line 879, characters 6-28
  Called from Base__List.dedup_and_sort.sort in file "src/list.ml", line 833, characters 19-32
  Called from Base__List.dedup_and_sort in file "src/list.ml", line 882, characters 29-41
  Called from Lib__Simpl_alpha.simplify in file "lib/Simpl_alpha.ml", line 100, characters 9-61
  Called from Lib__Simpl_alpha.simplify in file "lib/Simpl_alpha.ml", line 86, characters 40-54
  Called from Lib__Solver.Make.eval in file "lib/solver.ml", line 474, characters 40-63
  Called from Lib__Solver.Make.proof in file "lib/solver.ml", line 1175, characters 9-19
  Called from Dune__exe__Chro.check_sat in file "bin/chro.ml", line 111, characters 15-54
  Called from Dune__exe__Chro.exec in file "bin/chro.ml", line 157, characters 6-19
  Called from Stdlib__List.fold_left in file "list.ml", line 123, characters 24-34
  Called from Dune__exe__Chro in file "bin/chro.ml", line 191, characters 10-61
  [2]
