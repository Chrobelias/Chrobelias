; query-00044.smtml
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
 (let (($x17 (= ?x15 (_ bv0 32))))
 (not $x17)))))))
(assert
 (let ((?x20 ((_ extract 7 0) symbol_2)))
 (let ((?x21 ((_ zero_extend 24) ?x20)))
 (let ((?x22 (bvshl ?x21 (_ bv24 32))))
 (let ((?x23 (bvashr ?x22 (_ bv24 32))))
 (let (($x24 (= ?x23 (_ bv0 32))))
 (not $x24)))))))
(assert
 (let ((?x27 ((_ extract 7 0) symbol_4)))
 (let ((?x28 ((_ zero_extend 24) ?x27)))
 (let ((?x29 (bvshl ?x28 (_ bv24 32))))
 (let ((?x30 (bvashr ?x29 (_ bv24 32))))
 (let (($x31 (= ?x30 (_ bv0 32))))
 (not $x31)))))))
(assert
 (let ((?x34 ((_ extract 7 0) symbol_0)))
 (let ((?x35 ((_ zero_extend 24) ?x34)))
 (let ((?x36 (bvshl ?x35 (_ bv24 32))))
 (let ((?x37 (bvashr ?x36 (_ bv24 32))))
 (let (($x38 (= ?x37 (_ bv0 32))))
 (not $x38)))))))
(assert
 (and (distinct symbol_1 symbol_3) true))
(assert
 (and (distinct symbol_1 symbol_2) true))
(assert
 (and (distinct symbol_1 symbol_0) true))
(check-sat)
