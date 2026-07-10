; query-00004.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (bvsle symbol_5 (_ bv3 32)))
(assert
 (let (($x14 (bvsle symbol_4 (_ bv3 32))))
 (not $x14)))
(assert
 (let (($x17 (bvsle symbol_3 (_ bv3 32))))
 (not $x17)))
(check-sat)
