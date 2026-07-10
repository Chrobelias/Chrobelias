; query-00014.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (let (($x12 (= symbol_2 symbol_1)))
 (not $x12)))
(assert
 (let (($x14 (bvslt symbol_2 symbol_1)))
 (not $x14)))
(assert
 (let (($x18 (= symbol_3 symbol_0)))
 (not $x18)))
(assert
 (let (($x20 (bvslt symbol_3 symbol_0)))
 (not $x20)))
(assert
 (let (($x22 (= symbol_2 symbol_0)))
 (not $x22)))
(assert
 (let (($x24 (bvslt symbol_2 symbol_0)))
 (not $x24)))
(assert
 (let (($x26 (= symbol_1 symbol_0)))
 (not $x26)))
(assert
 (let (($x28 (bvslt symbol_1 symbol_0)))
 (not $x28)))
(check-sat)
