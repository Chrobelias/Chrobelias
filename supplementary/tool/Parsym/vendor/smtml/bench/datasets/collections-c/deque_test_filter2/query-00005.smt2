; query-00005.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (bvsgt symbol_5 (_ bv3 32)))
(assert
 (bvsgt symbol_4 (_ bv3 32)))
(assert
 (bvsgt symbol_3 (_ bv3 32)))
(check-sat)
