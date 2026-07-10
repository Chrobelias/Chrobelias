; query-00011.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let ((?x14 (bvadd (_ bv1049704 32) (_ bv0 32))))
 (let ((?x12 (bvadd (_ bv1049696 32) (_ bv0 32))))
 (= ?x12 ?x14))))
(assert
 (and (distinct symbol_2 symbol_3) true))
(assert
 (and (distinct symbol_2 symbol_1) true))
(assert
 (and (distinct symbol_2 symbol_0) true))
(check-sat)
