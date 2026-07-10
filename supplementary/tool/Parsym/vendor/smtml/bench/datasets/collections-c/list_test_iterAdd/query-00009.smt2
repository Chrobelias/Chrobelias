; query-00009.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_8 () (_ BitVec 32))
(assert
 (= symbol_0 symbol_2))
(assert
 (and (distinct symbol_3 symbol_1) true))
(assert
 (and (distinct symbol_3 symbol_0) true))
(assert
 (and (distinct symbol_2 symbol_3) true))
(assert
 (and (distinct symbol_2 symbol_1) true))
(assert
 (and (distinct symbol_2 symbol_0) true))
(assert
 (and (distinct symbol_8 symbol_3) true))
(check-sat)
