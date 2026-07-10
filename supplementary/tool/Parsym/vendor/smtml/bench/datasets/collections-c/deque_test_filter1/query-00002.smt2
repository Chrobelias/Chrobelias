; query-00002.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (bvsle symbol_4 (_ bv3 32)))
(assert
 (let (($x14 (bvsle symbol_3 (_ bv3 32))))
 (not $x14)))
(check-sat)
