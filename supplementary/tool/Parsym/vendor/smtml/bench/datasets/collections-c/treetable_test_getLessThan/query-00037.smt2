; query-00037.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (bvslt symbol_1 symbol_2))
(assert
 (bvslt symbol_2 symbol_3))
(assert
 (bvslt symbol_1 symbol_2))
(assert
 (bvslt symbol_0 symbol_1))
(check-sat)
