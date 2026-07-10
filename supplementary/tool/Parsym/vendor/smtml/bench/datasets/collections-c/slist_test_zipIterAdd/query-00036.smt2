; query-00036.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_6 () (_ BitVec 32))
(declare-fun symbol_8 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_7 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_10 () (_ BitVec 32))
(declare-fun symbol_9 () (_ BitVec 32))
(assert
 (let ((?x17 ((_ extract 7 0) symbol_6)))
 (let ((?x18 ((_ zero_extend 24) ?x17)))
 (let ((?x19 (bvshl ?x18 (_ bv24 32))))
 (let ((?x20 (bvashr ?x19 (_ bv24 32))))
 (let ((?x11 ((_ extract 7 0) symbol_8)))
 (let ((?x12 ((_ zero_extend 24) ?x11)))
 (let ((?x14 (bvshl ?x12 (_ bv24 32))))
 (let ((?x15 (bvashr ?x14 (_ bv24 32))))
 (let (($x21 (and (distinct ?x15 ?x20) true)))
 (not $x21)))))))))))
(assert
 (let ((?x17 ((_ extract 7 0) symbol_6)))
 (let ((?x18 ((_ zero_extend 24) ?x17)))
 (let ((?x19 (bvshl ?x18 (_ bv24 32))))
 (let ((?x20 (bvashr ?x19 (_ bv24 32))))
 (let ((?x24 ((_ extract 7 0) symbol_5)))
 (let ((?x25 ((_ zero_extend 24) ?x24)))
 (let ((?x26 (bvshl ?x25 (_ bv24 32))))
 (let ((?x27 (bvashr ?x26 (_ bv24 32))))
 (let (($x28 (and (distinct ?x27 ?x20) true)))
 (not $x28)))))))))))
(assert
 (let ((?x17 ((_ extract 7 0) symbol_6)))
 (let ((?x18 ((_ zero_extend 24) ?x17)))
 (let ((?x19 (bvshl ?x18 (_ bv24 32))))
 (let ((?x20 (bvashr ?x19 (_ bv24 32))))
 (let ((?x31 ((_ extract 7 0) symbol_4)))
 (let ((?x32 ((_ zero_extend 24) ?x31)))
 (let ((?x33 (bvshl ?x32 (_ bv24 32))))
 (let ((?x34 (bvashr ?x33 (_ bv24 32))))
 (let (($x35 (and (distinct ?x34 ?x20) true)))
 (not $x35)))))))))))
(assert
 (and (distinct symbol_8 symbol_6) true))
(assert
 (and (distinct symbol_8 symbol_5) true))
(assert
 (and (distinct symbol_8 symbol_4) true))
(assert
 (and (distinct symbol_2 symbol_3) true))
(assert
 (and (distinct symbol_2 symbol_0) true))
(assert
 (and (distinct symbol_7 symbol_3) true))
(assert
 (and (distinct symbol_7 symbol_2) true))
(assert
 (and (distinct symbol_7 symbol_1) true))
(assert
 (and (distinct symbol_7 symbol_0) true))
(assert
 (and (distinct symbol_1 symbol_3) true))
(assert
 (and (distinct symbol_1 symbol_2) true))
(assert
 (and (distinct symbol_1 symbol_0) true))
(assert
 (bvslt symbol_10 (_ bv127 32)))
(assert
 (bvsgt symbol_10 (_ bv0 32)))
(assert
 (bvslt symbol_9 (_ bv127 32)))
(assert
 (bvsgt symbol_9 (_ bv0 32)))
(assert
 (bvslt symbol_8 (_ bv127 32)))
(assert
 (bvsgt symbol_8 (_ bv0 32)))
(assert
 (bvslt symbol_7 (_ bv127 32)))
(assert
 (bvsgt symbol_7 (_ bv0 32)))
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
