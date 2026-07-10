; query-00724.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(assert
 (let (($x12 (= symbol_0 symbol_2)))
 (not $x12)))
(assert
 (bvslt symbol_3 symbol_0))
(assert
 (= symbol_2 symbol_0))
(assert
 (let (($x17 (bvslt symbol_2 symbol_0)))
 (not $x17)))
(assert
 (= symbol_1 symbol_0))
(assert
 (let (($x21 (bvslt symbol_1 symbol_0)))
 (not $x21)))
(check-sat)
