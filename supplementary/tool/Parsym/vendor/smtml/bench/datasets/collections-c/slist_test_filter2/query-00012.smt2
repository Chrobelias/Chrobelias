; query-00012.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let (($x12 (bvsge symbol_3 (_ bv3 32))))
 (not $x12)))
(assert
 (let (($x12 (bvsge symbol_3 (_ bv3 32))))
 (let ((?x16 (ite $x12 (_ bv1 32) (_ bv0 32))))
 (and (distinct ?x16 (_ bv0 32)) true))))
(assert
 (bvsge symbol_2 (_ bv3 32)))
(assert
 (let (($x21 (bvsge symbol_1 (_ bv3 32))))
 (not $x21)))
(assert
 (let (($x24 (bvsge symbol_0 (_ bv3 32))))
 (not $x24)))
(check-sat)
