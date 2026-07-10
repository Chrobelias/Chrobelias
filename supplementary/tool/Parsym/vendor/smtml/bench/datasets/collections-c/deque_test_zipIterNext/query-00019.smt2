; query-00019.smtml
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
 (= ?x22 (_ bv0 32)))))))
(assert
 (let ((?x25 ((_ extract 7 0) symbol_4)))
 (let ((?x26 ((_ zero_extend 24) ?x25)))
 (let ((?x27 (bvshl ?x26 (_ bv24 32))))
 (let ((?x28 (bvashr ?x27 (_ bv24 32))))
 (= ?x28 (_ bv0 32)))))))
(assert
 (let ((?x31 ((_ extract 7 0) symbol_0)))
 (let ((?x32 ((_ zero_extend 24) ?x31)))
 (let ((?x33 (bvshl ?x32 (_ bv24 32))))
 (let ((?x34 (bvashr ?x33 (_ bv24 32))))
 (let (($x35 (= ?x34 (_ bv0 32))))
 (not $x35)))))))
(assert
 (and (distinct symbol_1 symbol_3) true))
(assert
 (and (distinct symbol_1 symbol_2) true))
(assert
 (and (distinct symbol_1 symbol_0) true))
(check-sat)
