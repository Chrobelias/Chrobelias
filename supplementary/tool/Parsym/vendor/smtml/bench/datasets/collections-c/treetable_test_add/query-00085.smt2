; query-00085.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (= symbol_2 symbol_0))
(assert
 (let (($x13 (bvslt symbol_2 symbol_0)))
 (not $x13)))
(assert
 (= symbol_1 symbol_0))
(assert
 (let (($x17 (bvslt symbol_1 symbol_0)))
 (not $x17)))
(assert
 (bvslt symbol_4 symbol_5))
(assert
 (bvslt symbol_3 symbol_4))
(check-sat)
