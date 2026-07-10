; query-00027.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (= symbol_2 symbol_1))
(assert
 (let (($x13 (bvslt symbol_2 symbol_1)))
 (not $x13)))
(assert
 (let (($x16 (bvslt symbol_2 symbol_0)))
 (not $x16)))
(assert
 (let (($x18 (bvslt symbol_1 symbol_0)))
 (not $x18)))
(assert
 (and (distinct symbol_1 symbol_2) true))
(assert
 (and (distinct symbol_0 symbol_2) true))
(assert
 (and (distinct symbol_0 symbol_1) true))
(check-sat)
