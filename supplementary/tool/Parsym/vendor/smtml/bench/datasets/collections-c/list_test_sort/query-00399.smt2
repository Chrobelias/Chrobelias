; query-00399.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(assert
 (bvslt symbol_3 symbol_1))
(assert
 (= symbol_3 symbol_0))
(assert
 (let (($x15 (bvslt symbol_3 symbol_0)))
 (not $x15)))
(assert
 (let (($x18 (= symbol_3 symbol_2)))
 (not $x18)))
(assert
 (let (($x20 (bvslt symbol_3 symbol_2)))
 (not $x20)))
(assert
 (bvslt symbol_2 symbol_0))
(assert
 (let (($x23 (= symbol_1 symbol_0)))
 (not $x23)))
(assert
 (let (($x25 (bvslt symbol_1 symbol_0)))
 (not $x25)))
(check-sat)
