; query-00114.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (= symbol_1 symbol_2))
(assert
 (bvslt symbol_2 symbol_1))
(assert
 (let (($x15 (bvslt symbol_2 symbol_0)))
 (not $x15)))
(assert
 (let (($x17 (bvslt symbol_1 symbol_0)))
 (not $x17)))
(assert
 (and (distinct symbol_1 symbol_2) true))
(assert
 (and (distinct symbol_0 symbol_2) true))
(assert
 (and (distinct symbol_0 symbol_1) true))
(check-sat)
