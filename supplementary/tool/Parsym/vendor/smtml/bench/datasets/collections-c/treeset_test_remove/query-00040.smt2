; query-00040.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let ((?x14 (bvadd (_ bv1049664 32) (_ bv0 32))))
 (let ((?x12 (bvadd (_ bv1049688 32) (_ bv0 32))))
 (let (($x15 (and (distinct ?x12 ?x14) true)))
 (not $x15)))))
(assert
 (let (($x19 (bvslt symbol_2 symbol_1)))
 (not $x19)))
(assert
 (let (($x22 (bvslt symbol_2 symbol_0)))
 (not $x22)))
(assert
 (let (($x24 (bvslt symbol_1 symbol_0)))
 (not $x24)))
(assert
 (and (distinct symbol_1 symbol_2) true))
(assert
 (and (distinct symbol_0 symbol_2) true))
(assert
 (and (distinct symbol_0 symbol_1) true))
(check-sat)
