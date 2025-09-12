Basic BW tests

  $ OCAMLRUNPARAM='b=0' Chro ./bw.smt2
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
  [2]
