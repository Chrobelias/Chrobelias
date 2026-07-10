; query-00018.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (and (distinct symbol_3 symbol_5) true))
(assert
 (and (distinct symbol_3 symbol_4) true))
(assert
 (and (distinct symbol_3 symbol_2) true))
(assert
 (and (distinct symbol_3 symbol_1) true))
(assert
 (and (distinct symbol_3 symbol_0) true))
(check-sat)
