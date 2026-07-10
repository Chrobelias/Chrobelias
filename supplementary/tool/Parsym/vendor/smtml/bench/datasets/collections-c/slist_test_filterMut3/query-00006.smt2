; query-00006.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(assert
 (bvsgt symbol_0 (_ bv0 32)))
(assert
 (let (($x14 (bvsgt symbol_3 (_ bv0 32))))
 (let ((?x16 (ite $x14 (_ bv1 32) (_ bv0 32))))
 (and (distinct ?x16 (_ bv0 32)) true))))
(assert
 (bvsgt symbol_2 (_ bv0 32)))
(assert
 (bvsgt symbol_1 (_ bv0 32)))
(assert
 (bvsgt symbol_0 (_ bv0 32)))
(check-sat)
