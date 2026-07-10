; query-00002.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let (($x12 (bvsle symbol_1 (_ bv3 32))))
 (not $x12)))
(assert
 (bvsle symbol_0 (_ bv3 32)))
(check-sat)
