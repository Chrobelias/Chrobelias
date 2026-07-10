; query-00012.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let (($x12 (= symbol_3 (_ bv0 32))))
 (not $x12)))
(assert
 (and (distinct symbol_3 (_ bv0 32)) true))
(assert
 (let (($x16 (= symbol_2 (_ bv0 32))))
 (not $x16)))
(assert
 (let (($x19 (= symbol_1 (_ bv0 32))))
 (not $x19)))
(assert
 (let (($x22 (= symbol_0 (_ bv0 32))))
 (not $x22)))
(check-sat)
