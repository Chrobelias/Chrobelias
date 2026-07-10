; query-00638.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(assert
 (let (($x12 (bvsle symbol_2 symbol_0)))
 (not $x12)))
(assert
 (bvslt symbol_3 symbol_2))
(assert
 (bvslt symbol_2 symbol_0))
(assert
 (let (($x18 (= symbol_3 symbol_1)))
 (not $x18)))
(assert
 (let (($x20 (bvslt symbol_3 symbol_1)))
 (not $x20)))
(assert
 (let (($x22 (= symbol_2 symbol_1)))
 (not $x22)))
(assert
 (let (($x24 (bvslt symbol_2 symbol_1)))
 (not $x24)))
(assert
 (bvslt symbol_1 symbol_0))
(check-sat)
