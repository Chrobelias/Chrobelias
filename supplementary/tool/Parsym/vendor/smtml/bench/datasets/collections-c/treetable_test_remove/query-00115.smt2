; query-00115.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(assert
 (= symbol_2 symbol_0))
(assert
 (let (($x13 (bvslt symbol_2 symbol_0)))
 (not $x13)))
(assert
 (= symbol_1 symbol_0))
(assert
 (let (($x17 (bvslt symbol_1 symbol_0)))
 (not $x17)))
(assert
 (and (distinct symbol_2 symbol_1) true))
(assert
 (and (distinct symbol_2 symbol_0) true))
(check-sat)
