; query-00233.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (let (($x12 (= symbol_0 symbol_2)))
 (not $x12)))
(assert
 (let (($x14 (bvslt symbol_0 symbol_2)))
 (not $x14)))
(assert
 (bvslt symbol_3 symbol_1))
(assert
 (let (($x19 (= symbol_2 symbol_1)))
 (not $x19)))
(assert
 (let (($x21 (bvslt symbol_2 symbol_1)))
 (not $x21)))
(assert
 (bvslt symbol_1 symbol_0))
(check-sat)
