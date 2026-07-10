; query-00015.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (let (($x12 (bvsgt symbol_2 (_ bv3 32))))
 (not $x12)))
(assert
 (let (($x12 (bvsgt symbol_2 (_ bv3 32))))
 (let ((?x16 (ite $x12 (_ bv1 32) (_ bv0 32))))
 (let (($x17 (and (distinct ?x16 (_ bv0 32)) true)))
 (let ((?x18 (ite $x17 (_ bv1 32) (_ bv0 32))))
 (let ((?x20 (bvxor ?x18 (_ bv4294967295 32))))
 (let ((?x21 (bvand ?x20 (_ bv1 32))))
 (and (distinct ?x21 (_ bv0 32)) true))))))))
(assert
 (let (($x24 (bvsgt symbol_1 (_ bv3 32))))
 (not $x24)))
(assert
 (let (($x27 (bvsgt symbol_0 (_ bv3 32))))
 (not $x27)))
(assert
 (bvsgt symbol_5 (_ bv3 32)))
(assert
 (bvsgt symbol_4 (_ bv3 32)))
(assert
 (bvsgt symbol_3 (_ bv3 32)))
(check-sat)
