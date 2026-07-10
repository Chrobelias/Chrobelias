; query-00070.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(assert
 (let ((?x14 (bvadd (_ bv1049644 32) (_ bv0 32))))
 (let ((?x12 (bvadd (_ bv1049692 32) (_ bv0 32))))
 (let (($x15 (= ?x12 ?x14)))
 (not $x15)))))
(assert
 (let ((?x18 ((_ extract 7 0) symbol_4)))
 (let ((?x19 ((_ zero_extend 24) ?x18)))
 (let ((?x21 (bvshl ?x19 (_ bv24 32))))
 (let ((?x22 (bvashr ?x21 (_ bv24 32))))
 (let (($x23 (= ?x22 (_ bv0 32))))
 (not $x23)))))))
(assert
 (let ((?x26 ((_ extract 7 0) symbol_3)))
 (let ((?x27 ((_ zero_extend 24) ?x26)))
 (let ((?x28 (bvshl ?x27 (_ bv24 32))))
 (let ((?x29 (bvashr ?x28 (_ bv24 32))))
 (let (($x30 (= ?x29 (_ bv0 32))))
 (not $x30)))))))
(assert
 (let (($x34 (bvslt symbol_1 symbol_0)))
 (not $x34)))
(assert
 (and (distinct symbol_0 symbol_1) true))
(check-sat)
