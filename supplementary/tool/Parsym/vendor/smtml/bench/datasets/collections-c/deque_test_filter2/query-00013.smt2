; query-00013.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (bvsgt symbol_1 (_ bv3 32)))
(assert
 (let (($x14 (bvsgt symbol_2 (_ bv3 32))))
 (let ((?x17 (ite $x14 (_ bv1 32) (_ bv0 32))))
 (let (($x18 (and (distinct ?x17 (_ bv0 32)) true)))
 (let ((?x19 (ite $x18 (_ bv1 32) (_ bv0 32))))
 (let ((?x21 (bvxor ?x19 (_ bv4294967295 32))))
 (let ((?x22 (bvand ?x21 (_ bv1 32))))
 (and (distinct ?x22 (_ bv0 32)) true))))))))
(assert
 (let (($x12 (bvsgt symbol_1 (_ bv3 32))))
 (not $x12)))
(assert
 (let (($x26 (bvsgt symbol_0 (_ bv3 32))))
 (not $x26)))
(assert
 (bvsgt symbol_5 (_ bv3 32)))
(assert
 (bvsgt symbol_4 (_ bv3 32)))
(assert
 (bvsgt symbol_3 (_ bv3 32)))
(check-sat)
