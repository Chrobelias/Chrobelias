; query-00180.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(assert
 (bvslt symbol_2 symbol_0))
(assert
 (let (($x14 (bvslt symbol_2 symbol_1)))
 (not $x14)))
(assert
 (bvslt symbol_2 symbol_0))
(assert
 (bvslt symbol_1 symbol_0))
(assert
 (and (distinct symbol_2 symbol_1) true))
(assert
 (and (distinct symbol_2 symbol_0) true))
(check-sat)
