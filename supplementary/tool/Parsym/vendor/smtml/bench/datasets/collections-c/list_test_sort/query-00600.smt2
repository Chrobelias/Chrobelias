; query-00600.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (let (($x12 (bvsle symbol_1 symbol_2)))
 (not $x12)))
(assert
 (= symbol_3 symbol_0))
(assert
 (let (($x17 (bvslt symbol_3 symbol_0)))
 (not $x17)))
(assert
 (let (($x19 (= symbol_3 symbol_1)))
 (not $x19)))
(assert
 (let (($x21 (bvslt symbol_3 symbol_1)))
 (not $x21)))
(assert
 (= symbol_2 symbol_1))
(assert
 (let (($x24 (bvslt symbol_2 symbol_1)))
 (not $x24)))
(assert
 (bvslt symbol_1 symbol_0))
(check-sat)
