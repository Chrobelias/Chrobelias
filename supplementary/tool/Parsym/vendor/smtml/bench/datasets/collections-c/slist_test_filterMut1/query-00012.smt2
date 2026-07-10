; query-00012.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (= symbol_3 (_ bv0 32)))
(assert
 (and (distinct symbol_3 (_ bv0 32)) true))
(assert
 (let (($x15 (= symbol_2 (_ bv0 32))))
 (not $x15)))
(assert
 (let (($x18 (= symbol_1 (_ bv0 32))))
 (not $x18)))
(assert
 (let (($x21 (= symbol_0 (_ bv0 32))))
 (not $x21)))
(check-sat)
