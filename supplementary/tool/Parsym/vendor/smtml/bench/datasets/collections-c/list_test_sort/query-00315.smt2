; query-00315.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (bvslt symbol_2 symbol_1))
(assert
 (let (($x15 (= symbol_3 symbol_0)))
 (not $x15)))
(assert
 (let (($x17 (bvslt symbol_3 symbol_0)))
 (not $x17)))
(assert
 (= symbol_2 symbol_0))
(assert
 (let (($x20 (bvslt symbol_2 symbol_0)))
 (not $x20)))
(assert
 (= symbol_1 symbol_0))
(assert
 (let (($x23 (bvslt symbol_1 symbol_0)))
 (not $x23)))
(check-sat)
