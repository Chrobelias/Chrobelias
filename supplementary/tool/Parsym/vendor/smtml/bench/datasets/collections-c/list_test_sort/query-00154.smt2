; query-00154.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let (($x12 (= symbol_3 symbol_2)))
 (not $x12)))
(assert
 (let (($x15 (= symbol_3 symbol_1)))
 (not $x15)))
(assert
 (let (($x17 (bvslt symbol_3 symbol_1)))
 (not $x17)))
(assert
 (= symbol_2 symbol_1))
(assert
 (let (($x20 (bvslt symbol_2 symbol_1)))
 (not $x20)))
(assert
 (let (($x23 (= symbol_3 symbol_0)))
 (not $x23)))
(assert
 (let (($x25 (bvslt symbol_3 symbol_0)))
 (not $x25)))
(assert
 (let (($x27 (= symbol_2 symbol_0)))
 (not $x27)))
(assert
 (let (($x29 (bvslt symbol_2 symbol_0)))
 (not $x29)))
(assert
 (let (($x31 (= symbol_1 symbol_0)))
 (not $x31)))
(assert
 (let (($x33 (bvslt symbol_1 symbol_0)))
 (not $x33)))
(check-sat)
