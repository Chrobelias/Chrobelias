; query-00017.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (and (distinct symbol_2 symbol_4) true))
(assert
 (and (distinct symbol_2 symbol_3) true))
(assert
 (and (distinct symbol_1 symbol_4) true))
(assert
 (and (distinct symbol_1 symbol_3) true))
(assert
 (and (distinct symbol_1 symbol_2) true))
(assert
 (and (distinct symbol_0 symbol_4) true))
(assert
 (and (distinct symbol_0 symbol_3) true))
(assert
 (and (distinct symbol_0 symbol_2) true))
(assert
 (and (distinct symbol_0 symbol_1) true))
(check-sat)
