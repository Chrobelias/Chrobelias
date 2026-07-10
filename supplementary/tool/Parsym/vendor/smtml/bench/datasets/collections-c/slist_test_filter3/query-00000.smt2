; query-00000.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let (($x12 (bvsgt symbol_0 (_ bv0 32))))
 (not $x12)))
(check-sat)
