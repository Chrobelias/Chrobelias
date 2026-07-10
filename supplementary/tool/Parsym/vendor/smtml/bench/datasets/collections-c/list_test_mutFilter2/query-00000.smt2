; query-00000.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let (($x12 (bvsle symbol_0 (_ bv3 32))))
 (not $x12)))
(check-sat)
