; query-00499.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let (($x12 (bvsle symbol_2 symbol_3)))
 (not $x12)))
(assert
 (bvslt symbol_3 symbol_1))
(assert
 (let (($x16 (= symbol_3 symbol_2)))
 (not $x16)))
(assert
 (let (($x18 (bvslt symbol_3 symbol_2)))
 (not $x18)))
(assert
 (bvslt symbol_2 symbol_1))
(assert
 (let (($x22 (= symbol_3 symbol_0)))
 (not $x22)))
(assert
 (let (($x24 (bvslt symbol_3 symbol_0)))
 (not $x24)))
(assert
 (let (($x26 (= symbol_2 symbol_0)))
 (not $x26)))
(assert
 (let (($x28 (bvslt symbol_2 symbol_0)))
 (not $x28)))
(assert
 (let (($x30 (= symbol_1 symbol_0)))
 (not $x30)))
(assert
 (let (($x32 (bvslt symbol_1 symbol_0)))
 (not $x32)))
(check-sat)
