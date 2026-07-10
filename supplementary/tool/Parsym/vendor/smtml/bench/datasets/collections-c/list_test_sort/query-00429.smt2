; query-00429.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(assert
 (= symbol_3 symbol_2))
(assert
 (= symbol_3 symbol_0))
(assert
 (let (($x15 (bvslt symbol_3 symbol_0)))
 (not $x15)))
(assert
 (= symbol_2 symbol_0))
(assert
 (let (($x18 (bvslt symbol_2 symbol_0)))
 (not $x18)))
(assert
 (let (($x21 (= symbol_1 symbol_0)))
 (not $x21)))
(assert
 (let (($x23 (bvslt symbol_1 symbol_0)))
 (not $x23)))
(check-sat)
