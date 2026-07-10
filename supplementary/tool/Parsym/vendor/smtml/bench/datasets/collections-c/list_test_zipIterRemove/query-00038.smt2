; query-00038.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_6 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let (($x12 (and (distinct symbol_4 symbol_6) true)))
 (not $x12)))
(assert
 (and (distinct symbol_4 symbol_5) true))
(assert
 (and (distinct symbol_3 symbol_6) true))
(assert
 (and (distinct symbol_3 symbol_5) true))
(assert
 (and (distinct symbol_3 symbol_4) true))
(assert
 (and (distinct symbol_2 symbol_6) true))
(assert
 (and (distinct symbol_2 symbol_5) true))
(assert
 (and (distinct symbol_2 symbol_4) true))
(assert
 (and (distinct symbol_2 symbol_3) true))
(assert
 (and (distinct symbol_1 symbol_6) true))
(assert
 (and (distinct symbol_1 symbol_5) true))
(assert
 (and (distinct symbol_1 symbol_4) true))
(assert
 (and (distinct symbol_1 symbol_3) true))
(assert
 (and (distinct symbol_1 symbol_2) true))
(assert
 (and (distinct symbol_0 symbol_6) true))
(assert
 (and (distinct symbol_0 symbol_5) true))
(assert
 (and (distinct symbol_0 symbol_4) true))
(assert
 (and (distinct symbol_0 symbol_3) true))
(assert
 (and (distinct symbol_0 symbol_2) true))
(assert
 (and (distinct symbol_0 symbol_1) true))
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
