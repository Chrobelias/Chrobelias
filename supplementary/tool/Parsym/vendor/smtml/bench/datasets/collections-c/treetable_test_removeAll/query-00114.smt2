; query-00114.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let ((?x14 (bvadd (_ bv1049644 32) (_ bv0 32))))
 (let ((?x12 (bvadd (_ bv1049692 32) (_ bv0 32))))
 (let (($x15 (= ?x12 ?x14)))
 (not $x15)))))
(assert
 (= symbol_2 symbol_1))
(assert
 (let (($x20 (bvslt symbol_2 symbol_1)))
 (not $x20)))
(assert
 (let (($x23 (= symbol_2 symbol_0)))
 (not $x23)))
(assert
 (let (($x25 (bvslt symbol_2 symbol_0)))
 (not $x25)))
(assert
 (let (($x27 (= symbol_1 symbol_0)))
 (not $x27)))
(assert
 (let (($x29 (bvslt symbol_1 symbol_0)))
 (not $x29)))
(check-sat)
