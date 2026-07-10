; query-00025.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_6 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(assert
 (let ((?x11 ((_ extract 7 0) symbol_6)))
 (let ((?x12 ((_ zero_extend 24) ?x11)))
 (let ((?x14 (bvshl ?x12 (_ bv24 32))))
 (let ((?x15 (bvashr ?x14 (_ bv24 32))))
 (= ?x15 (_ bv0 32)))))))
(assert
 (let ((?x19 ((_ extract 7 0) symbol_2)))
 (let ((?x20 ((_ zero_extend 24) ?x19)))
 (let ((?x21 (bvshl ?x20 (_ bv24 32))))
 (let ((?x22 (bvashr ?x21 (_ bv24 32))))
 (let (($x23 (= ?x22 (_ bv0 32))))
 (not $x23)))))))
(assert
 (let ((?x26 ((_ extract 7 0) symbol_4)))
 (let ((?x27 ((_ zero_extend 24) ?x26)))
 (let ((?x28 (bvshl ?x27 (_ bv24 32))))
 (let ((?x29 (bvashr ?x28 (_ bv24 32))))
 (= ?x29 (_ bv0 32)))))))
(assert
 (let ((?x32 ((_ extract 7 0) symbol_0)))
 (let ((?x33 ((_ zero_extend 24) ?x32)))
 (let ((?x34 (bvshl ?x33 (_ bv24 32))))
 (let ((?x35 (bvashr ?x34 (_ bv24 32))))
 (= ?x35 (_ bv0 32)))))))
(assert
 (and (distinct symbol_1 symbol_3) true))
(assert
 (and (distinct symbol_1 symbol_2) true))
(assert
 (and (distinct symbol_1 symbol_0) true))
(check-sat)
