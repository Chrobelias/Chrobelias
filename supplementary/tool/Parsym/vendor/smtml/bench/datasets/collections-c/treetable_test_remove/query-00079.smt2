; query-00079.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(assert
 (let ((?x14 (bvadd (_ bv1049692 32) (_ bv0 32))))
 (let ((?x12 (bvadd (_ bv1049716 32) (_ bv0 32))))
 (let (($x15 (= ?x12 ?x14)))
 (not $x15)))))
(assert
 (let (($x19 (bvslt symbol_2 symbol_0)))
 (not $x19)))
(assert
 (bvslt symbol_1 symbol_0))
(assert
 (and (distinct symbol_2 symbol_1) true))
(assert
 (and (distinct symbol_2 symbol_0) true))
(check-sat)
