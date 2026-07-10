; query-00005.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (bvsge symbol_2 (_ bv3 32)))
(assert
 (let (($x14 (bvsge symbol_1 (_ bv3 32))))
 (not $x14)))
(assert
 (let (($x17 (bvsge symbol_0 (_ bv3 32))))
 (not $x17)))
(check-sat)
