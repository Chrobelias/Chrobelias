; query-00003.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_6 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (and (distinct symbol_1 symbol_2) true))
(assert
 (and (distinct symbol_1 symbol_0) true))
(assert
 (bvslt symbol_6 (_ bv127 32)))
(assert
 (bvsgt symbol_6 (_ bv0 32)))
(assert
 (bvslt symbol_5 (_ bv127 32)))
(assert
 (bvsgt symbol_5 (_ bv0 32)))
(assert
 (bvslt symbol_4 (_ bv127 32)))
(assert
 (bvsgt symbol_4 (_ bv0 32)))
(assert
 (bvslt symbol_3 (_ bv127 32)))
(assert
 (bvsgt symbol_3 (_ bv0 32)))
(assert
 (bvslt symbol_2 (_ bv127 32)))
(assert
 (bvsgt symbol_2 (_ bv0 32)))
(assert
 (bvslt symbol_1 (_ bv127 32)))
(assert
 (bvsgt symbol_1 (_ bv0 32)))
(assert
 (bvslt symbol_0 (_ bv127 32)))
(assert
 (bvsgt symbol_0 (_ bv0 32)))
(check-sat)
