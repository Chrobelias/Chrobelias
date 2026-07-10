; query-00049.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(assert
 (let (($x12 (bvsle symbol_0 symbol_2)))
 (not $x12)))
(assert
 (let (($x15 (= symbol_3 symbol_2)))
 (not $x15)))
(assert
 (let (($x17 (bvslt symbol_3 symbol_2)))
 (not $x17)))
(assert
 (let (($x19 (= symbol_3 symbol_0)))
 (not $x19)))
(assert
 (let (($x21 (bvslt symbol_3 symbol_0)))
 (not $x21)))
(assert
 (let (($x23 (= symbol_2 symbol_0)))
 (not $x23)))
(assert
 (let (($x25 (bvslt symbol_2 symbol_0)))
 (not $x25)))
(assert
 (let (($x28 (= symbol_3 symbol_1)))
 (not $x28)))
(assert
 (let (($x30 (bvslt symbol_3 symbol_1)))
 (not $x30)))
(assert
 (let (($x32 (= symbol_2 symbol_1)))
 (not $x32)))
(assert
 (let (($x34 (bvslt symbol_2 symbol_1)))
 (not $x34)))
(assert
 (bvslt symbol_1 symbol_0))
(check-sat)
