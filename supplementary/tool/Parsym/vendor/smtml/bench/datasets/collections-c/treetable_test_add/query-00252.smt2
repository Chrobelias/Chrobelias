; query-00252.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (= symbol_2 symbol_1))
(assert
 (let (($x13 (bvslt symbol_2 symbol_1)))
 (not $x13)))
(assert
 (bvslt symbol_2 symbol_0))
(assert
 (bvslt symbol_1 symbol_0))
(assert
 (bvslt symbol_4 symbol_5))
(assert
 (bvslt symbol_3 symbol_4))
(check-sat)
