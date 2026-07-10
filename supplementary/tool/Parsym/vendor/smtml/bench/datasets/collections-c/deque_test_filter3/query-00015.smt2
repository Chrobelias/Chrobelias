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
 (bvsgt symbol_2 (_ bv5 32)))
(assert
 (let (($x12 (bvsgt symbol_2 (_ bv5 32))))
 (let ((?x15 (ite $x12 (_ bv1 32) (_ bv0 32))))
 (let (($x16 (and (distinct ?x15 (_ bv0 32)) true)))
 (let ((?x17 (ite $x16 (_ bv1 32) (_ bv0 32))))
 (let ((?x19 (bvxor ?x17 (_ bv4294967295 32))))
 (let ((?x20 (bvand ?x19 (_ bv1 32))))
 (and (distinct ?x20 (_ bv0 32)) true))))))))
(assert
 (let (($x23 (bvsgt symbol_1 (_ bv5 32))))
 (not $x23)))
(assert
 (let (($x26 (bvsgt symbol_0 (_ bv5 32))))
 (not $x26)))
(assert
 (bvsgt symbol_5 (_ bv5 32)))
(assert
 (let (($x31 (bvsgt symbol_4 (_ bv5 32))))
 (not $x31)))
(assert
 (let (($x34 (bvsgt symbol_3 (_ bv5 32))))
 (not $x34)))
(check-sat)
