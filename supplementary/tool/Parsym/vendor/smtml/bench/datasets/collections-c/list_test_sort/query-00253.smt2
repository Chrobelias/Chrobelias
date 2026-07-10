; query-00253.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(assert
 (= symbol_3 symbol_0))
(assert
 (let (($x13 (bvslt symbol_3 symbol_0)))
 (not $x13)))
(assert
 (let (($x16 (= symbol_3 symbol_2)))
 (not $x16)))
(assert
 (let (($x18 (bvslt symbol_3 symbol_2)))
 (not $x18)))
(assert
 (bvslt symbol_2 symbol_0))
(assert
 (let (($x22 (= symbol_3 symbol_1)))
 (not $x22)))
(assert
 (let (($x24 (bvslt symbol_3 symbol_1)))
 (not $x24)))
(assert
 (let (($x26 (= symbol_2 symbol_1)))
 (not $x26)))
(assert
 (let (($x28 (bvslt symbol_2 symbol_1)))
 (not $x28)))
(assert
 (bvslt symbol_1 symbol_0))
(check-sat)
