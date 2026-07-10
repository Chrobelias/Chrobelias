; query-00001.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (let (($x12 (and (distinct symbol_3 symbol_2) true)))
 (not $x12)))
(check-sat)
