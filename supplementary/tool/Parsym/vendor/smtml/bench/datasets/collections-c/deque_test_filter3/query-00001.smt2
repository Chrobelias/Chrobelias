; query-00001.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (let (($x12 (bvsgt symbol_3 (_ bv5 32))))
 (not $x12)))
(check-sat)
