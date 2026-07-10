; query-00487.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (= symbol_1 symbol_2))
(assert
 (bvslt symbol_3 symbol_2))
(assert
 (bvslt symbol_2 symbol_1))
(assert
 (let (($x17 (= symbol_3 symbol_0)))
 (not $x17)))
(assert
 (let (($x19 (bvslt symbol_3 symbol_0)))
 (not $x19)))
(assert
 (let (($x21 (= symbol_2 symbol_0)))
 (not $x21)))
(assert
 (let (($x23 (bvslt symbol_2 symbol_0)))
 (not $x23)))
(assert
 (let (($x25 (= symbol_1 symbol_0)))
 (not $x25)))
(assert
 (let (($x27 (bvslt symbol_1 symbol_0)))
 (not $x27)))
(check-sat)
