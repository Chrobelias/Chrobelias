; query-00061.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (bvslt symbol_2 symbol_1))
(assert
 (let (($x15 (= symbol_3 symbol_0)))
 (not $x15)))
(assert
 (let (($x17 (bvslt symbol_3 symbol_0)))
 (not $x17)))
(assert
 (let (($x19 (= symbol_2 symbol_0)))
 (not $x19)))
(assert
 (let (($x21 (bvslt symbol_2 symbol_0)))
 (not $x21)))
(assert
 (= symbol_1 symbol_0))
(assert
 (let (($x24 (bvslt symbol_1 symbol_0)))
 (not $x24)))
(check-sat)
