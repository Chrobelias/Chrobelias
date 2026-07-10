; query-00010.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let (($x12 (bvsgt symbol_2 (_ bv3 32))))
 (not $x12)))
(assert
 (bvsgt symbol_3 (_ bv3 32)))
(assert
 (bvsle symbol_2 (_ bv3 32)))
(assert
 (bvsle symbol_1 (_ bv3 32)))
(assert
 (bvsle symbol_0 (_ bv3 32)))
(check-sat)
