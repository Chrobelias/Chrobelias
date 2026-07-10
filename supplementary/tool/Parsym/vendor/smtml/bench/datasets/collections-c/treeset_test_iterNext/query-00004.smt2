; query-00004.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let ((?x14 (bvadd (_ bv1049664 32) (_ bv0 32))))
 (let ((?x12 (bvadd (_ bv1049688 32) (_ bv0 32))))
 (let (($x15 (and (distinct ?x12 ?x14) true)))
 (not $x15)))))
(assert
 (bvslt symbol_2 symbol_3))
(assert
 (bvslt symbol_1 symbol_2))
(assert
 (bvslt symbol_0 symbol_1))
(check-sat)
