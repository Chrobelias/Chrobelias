; query-00510.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(assert
 (let (($x12 (bvsle symbol_0 symbol_3)))
 (not $x12)))
(assert
 (bvslt symbol_3 symbol_1))
(assert
 (= symbol_2 symbol_1))
(assert
 (let (($x18 (bvslt symbol_2 symbol_1)))
 (not $x18)))
(assert
 (let (($x20 (= symbol_3 symbol_0)))
 (not $x20)))
(assert
 (let (($x22 (bvslt symbol_3 symbol_0)))
 (not $x22)))
(assert
 (let (($x24 (= symbol_2 symbol_0)))
 (not $x24)))
(assert
 (let (($x26 (bvslt symbol_2 symbol_0)))
 (not $x26)))
(assert
 (let (($x28 (= symbol_1 symbol_0)))
 (not $x28)))
(assert
 (let (($x30 (bvslt symbol_1 symbol_0)))
 (not $x30)))
(check-sat)
