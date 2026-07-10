; query-00009.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (bvsge symbol_1 (_ bv3 32)))
(assert
 (let (($x14 (bvsge symbol_3 (_ bv3 32))))
 (let ((?x17 (ite $x14 (_ bv1 32) (_ bv0 32))))
 (and (distinct ?x17 (_ bv0 32)) true))))
(assert
 (bvsge symbol_2 (_ bv3 32)))
(assert
 (let (($x12 (bvsge symbol_1 (_ bv3 32))))
 (not $x12)))
(assert
 (let (($x23 (bvsge symbol_0 (_ bv3 32))))
 (not $x23)))
(check-sat)
