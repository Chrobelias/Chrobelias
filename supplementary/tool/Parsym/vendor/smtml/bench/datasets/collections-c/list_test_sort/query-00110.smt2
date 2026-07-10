; query-00110.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(assert
 (let (($x12 (bvsle symbol_1 symbol_3)))
 (not $x12)))
(assert
 (let (($x14 (= symbol_3 symbol_1)))
 (not $x14)))
(assert
 (let (($x16 (bvslt symbol_3 symbol_1)))
 (not $x16)))
(assert
 (let (($x19 (= symbol_3 symbol_0)))
 (not $x19)))
(assert
 (let (($x21 (bvslt symbol_3 symbol_0)))
 (not $x21)))
(assert
 (= symbol_2 symbol_0))
(assert
 (let (($x25 (bvslt symbol_2 symbol_0)))
 (not $x25)))
(assert
 (let (($x27 (= symbol_1 symbol_0)))
 (not $x27)))
(assert
 (let (($x29 (bvslt symbol_1 symbol_0)))
 (not $x29)))
(check-sat)
