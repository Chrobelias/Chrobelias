; query-00389.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(assert
 (= symbol_3 symbol_2))
(assert
 (let (($x13 (bvslt symbol_3 symbol_2)))
 (not $x13)))
(assert
 (bvslt symbol_2 symbol_0))
(assert
 (let (($x18 (= symbol_1 symbol_0)))
 (not $x18)))
(assert
 (let (($x20 (bvslt symbol_1 symbol_0)))
 (not $x20)))
(check-sat)
