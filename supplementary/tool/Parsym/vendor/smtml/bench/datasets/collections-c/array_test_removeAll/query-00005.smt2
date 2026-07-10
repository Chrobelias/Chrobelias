; query-00005.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (bvslt (_ bv2 32) symbol_0))
(assert
 (bvslt symbol_0 (_ bv16 32)))
(assert
 (bvsgt symbol_0 (_ bv2 32)))
(check-sat)
