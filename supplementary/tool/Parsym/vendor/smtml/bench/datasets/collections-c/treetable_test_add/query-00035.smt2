; query-00035.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (bvslt symbol_0 symbol_1))
(assert
 (let (($x14 (= symbol_2 symbol_1)))
 (not $x14)))
(assert
 (let (($x16 (bvslt symbol_2 symbol_1)))
 (not $x16)))
(assert
 (let (($x18 (= symbol_2 symbol_0)))
 (not $x18)))
(assert
 (let (($x20 (bvslt symbol_2 symbol_0)))
 (not $x20)))
(assert
 (let (($x22 (= symbol_1 symbol_0)))
 (not $x22)))
(assert
 (let (($x24 (bvslt symbol_1 symbol_0)))
 (not $x24)))
(assert
 (bvslt symbol_4 symbol_5))
(assert
 (bvslt symbol_3 symbol_4))
(check-sat)
