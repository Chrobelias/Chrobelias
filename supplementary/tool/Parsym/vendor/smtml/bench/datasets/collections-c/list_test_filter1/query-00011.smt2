; query-00011.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (= symbol_2 (_ bv0 32)))
(assert
 (and (distinct symbol_3 (_ bv0 32)) true))
(assert
 (let (($x12 (= symbol_2 (_ bv0 32))))
 (not $x12)))
(assert
 (let (($x17 (= symbol_1 (_ bv0 32))))
 (not $x17)))
(assert
 (let (($x20 (= symbol_0 (_ bv0 32))))
 (not $x20)))
(check-sat)
