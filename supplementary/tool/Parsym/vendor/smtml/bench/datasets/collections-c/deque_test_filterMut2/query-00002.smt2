; query-00002.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (let (($x12 (bvsgt symbol_4 (_ bv3 32))))
 (not $x12)))
(assert
 (bvsgt symbol_3 (_ bv3 32)))
(check-sat)
