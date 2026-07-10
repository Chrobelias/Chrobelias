; query-00017.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(assert
 (bvsle symbol_3 (_ bv3 32)))
(assert
 (let (($x14 (bvsle symbol_2 (_ bv3 32))))
 (let ((?x17 (ite $x14 (_ bv1 32) (_ bv0 32))))
 (and (distinct ?x17 (_ bv0 32)) true))))
(assert
 (bvsle symbol_1 (_ bv3 32)))
(assert
 (bvsle symbol_0 (_ bv3 32)))
(assert
 (let (($x24 (bvsle symbol_5 (_ bv3 32))))
 (not $x24)))
(assert
 (let (($x27 (bvsle symbol_4 (_ bv3 32))))
 (not $x27)))
(assert
 (let (($x12 (bvsle symbol_3 (_ bv3 32))))
 (not $x12)))
(check-sat)
