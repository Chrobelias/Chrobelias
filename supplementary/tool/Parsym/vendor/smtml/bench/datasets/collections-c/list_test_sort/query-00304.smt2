; query-00304.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(assert
 (let (($x12 (= symbol_3 symbol_0)))
 (not $x12)))
(assert
 (let (($x15 (= symbol_3 symbol_1)))
 (not $x15)))
(assert
 (let (($x17 (bvslt symbol_3 symbol_1)))
 (not $x17)))
(assert
 (let (($x20 (= symbol_3 symbol_2)))
 (not $x20)))
(assert
 (let (($x22 (bvslt symbol_3 symbol_2)))
 (not $x22)))
(assert
 (bvslt symbol_2 symbol_0))
(assert
 (= symbol_1 symbol_0))
(assert
 (let (($x26 (bvslt symbol_1 symbol_0)))
 (not $x26)))
(check-sat)
