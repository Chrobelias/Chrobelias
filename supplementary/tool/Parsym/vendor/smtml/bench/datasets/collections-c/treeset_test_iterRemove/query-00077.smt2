; query-00077.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(assert
 (let (($x12 (= symbol_2 symbol_0)))
 (not $x12)))
(assert
 (let (($x14 (bvslt symbol_2 symbol_0)))
 (not $x14)))
(assert
 (bvslt symbol_1 symbol_0))
(assert
 (and (distinct symbol_1 symbol_2) true))
(assert
 (and (distinct symbol_0 symbol_2) true))
(assert
 (and (distinct symbol_0 symbol_1) true))
(check-sat)
