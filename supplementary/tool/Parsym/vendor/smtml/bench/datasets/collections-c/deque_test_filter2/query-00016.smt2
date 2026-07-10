; query-00016.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(assert
 (let (($x12 (bvsgt symbol_3 (_ bv3 32))))
 (not $x12)))
(assert
 (let (($x15 (bvsgt symbol_2 (_ bv3 32))))
 (let ((?x18 (ite $x15 (_ bv1 32) (_ bv0 32))))
 (let (($x19 (and (distinct ?x18 (_ bv0 32)) true)))
 (let ((?x20 (ite $x19 (_ bv1 32) (_ bv0 32))))
 (let ((?x22 (bvxor ?x20 (_ bv4294967295 32))))
 (let ((?x23 (bvand ?x22 (_ bv1 32))))
 (and (distinct ?x23 (_ bv0 32)) true))))))))
(assert
 (let (($x26 (bvsgt symbol_1 (_ bv3 32))))
 (not $x26)))
(assert
 (let (($x29 (bvsgt symbol_0 (_ bv3 32))))
 (not $x29)))
(assert
 (bvsgt symbol_5 (_ bv3 32)))
(assert
 (bvsgt symbol_4 (_ bv3 32)))
(assert
 (bvsgt symbol_3 (_ bv3 32)))
(check-sat)
