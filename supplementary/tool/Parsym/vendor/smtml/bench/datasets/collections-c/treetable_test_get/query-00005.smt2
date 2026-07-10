; query-00005.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(assert
 (= symbol_1 symbol_0))
(assert
 (let (($x13 (bvslt symbol_1 symbol_0)))
 (not $x13)))
(assert
 (and (distinct symbol_0 symbol_1) true))
(check-sat)
