; query-00013.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let (($x12 (bvsgt symbol_3 (_ bv0 32))))
 (not $x12)))
(assert
 (let (($x12 (bvsgt symbol_3 (_ bv0 32))))
 (let ((?x15 (ite $x12 (_ bv1 32) (_ bv0 32))))
 (and (distinct ?x15 (_ bv0 32)) true))))
(assert
 (bvsgt symbol_2 (_ bv0 32)))
(assert
 (bvsgt symbol_1 (_ bv0 32)))
(assert
 (bvsgt symbol_0 (_ bv0 32)))
(check-sat)
