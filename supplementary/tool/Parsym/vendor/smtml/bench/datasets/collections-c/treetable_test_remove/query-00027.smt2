; query-00027.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let ((?x14 (bvadd (_ bv1049644 32) (_ bv0 32))))
 (let ((?x12 (bvadd (_ bv1049692 32) (_ bv0 32))))
 (= ?x12 ?x14))))
(assert
 (let (($x18 (bvslt symbol_2 symbol_1)))
 (not $x18)))
(assert
 (let (($x21 (bvslt symbol_2 symbol_0)))
 (not $x21)))
(assert
 (let (($x23 (= symbol_1 symbol_0)))
 (not $x23)))
(assert
 (let (($x25 (bvslt symbol_1 symbol_0)))
 (not $x25)))
(assert
 (and (distinct symbol_2 symbol_1) true))
(assert
 (and (distinct symbol_2 symbol_0) true))
(check-sat)
