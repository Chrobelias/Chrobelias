; query-00004.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (= symbol_2 (_ bv0 32)))
(assert
 (let (($x14 (= symbol_1 (_ bv0 32))))
 (not $x14)))
(assert
 (let (($x17 (= symbol_0 (_ bv0 32))))
 (not $x17)))
(check-sat)
