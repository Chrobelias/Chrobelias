; query-00120.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (let (($x12 (= symbol_2 symbol_0)))
 (not $x12)))
(assert
 (= symbol_2 symbol_0))
(assert
 (let (($x14 (bvslt symbol_2 symbol_0)))
 (not $x14)))
(assert
 (let (($x17 (= symbol_1 symbol_0)))
 (not $x17)))
(assert
 (let (($x19 (bvslt symbol_1 symbol_0)))
 (not $x19)))
(assert
 (bvslt symbol_4 symbol_5))
(assert
 (bvslt symbol_3 symbol_4))
(check-sat)
