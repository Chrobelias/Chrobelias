; query-00271.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(assert
 (bvslt symbol_0 symbol_2))
(assert
 (bvslt symbol_3 symbol_0))
(assert
 (let (($x15 (= symbol_2 symbol_0)))
 (not $x15)))
(assert
 (let (($x17 (bvslt symbol_2 symbol_0)))
 (not $x17)))
(assert
 (let (($x20 (= symbol_3 symbol_1)))
 (not $x20)))
(assert
 (let (($x22 (bvslt symbol_3 symbol_1)))
 (not $x22)))
(assert
 (let (($x24 (= symbol_2 symbol_1)))
 (not $x24)))
(assert
 (let (($x26 (bvslt symbol_2 symbol_1)))
 (not $x26)))
(assert
 (bvslt symbol_1 symbol_0))
(check-sat)
