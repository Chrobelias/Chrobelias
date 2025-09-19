Basic BW tests

  $ OCAMLRUNPARAM='b=0' Chro ./bw.smt2
  Not implemented comparison:
  	((re.* (re.union (re.union (re.union (str.to.re "0
  0000000000000000000000000000000000000000000000000000000000000") (str.to.re "1
  100000000000000000000000000000000000000000000000000000000000
  0")) (str.to.re "101000000000000000000000000000000000000000000000000000000000
  00")) (str.to.re "11100000000000000000000000000000000000000000000000000000000
  00
  0"))) %5 + %3 + %4)
  	(-1%3 = -5)
  Fatal error: exception File "lib/Simpl_alpha.ml", line 50, characters 6-12: Assertion failed
  [2]
