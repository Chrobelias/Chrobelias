; query-00002.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let (($x12 (and (distinct symbol_3 symbol_1) true)))
 (not $x12)))
(assert
 (and (distinct symbol_3 symbol_0) true))
(check-sat)
