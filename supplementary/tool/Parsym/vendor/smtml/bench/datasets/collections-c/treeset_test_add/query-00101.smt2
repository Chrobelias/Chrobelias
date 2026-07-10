; query-00101.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let ((?x14 (bvadd (_ bv1049664 32) (_ bv0 32))))
 (let ((?x12 (bvadd (_ bv1049712 32) (_ bv0 32))))
 (let (($x15 (= ?x12 ?x14)))
 (not $x15)))))
(assert
 (bvslt symbol_2 symbol_1))
(assert
 (let (($x21 (bvslt symbol_2 symbol_0)))
 (not $x21)))
(assert
 (let (($x23 (bvslt symbol_1 symbol_0)))
 (not $x23)))
(assert
 (and (distinct symbol_1 symbol_2) true))
(assert
 (and (distinct symbol_0 symbol_2) true))
(assert
 (and (distinct symbol_0 symbol_1) true))
(check-sat)
