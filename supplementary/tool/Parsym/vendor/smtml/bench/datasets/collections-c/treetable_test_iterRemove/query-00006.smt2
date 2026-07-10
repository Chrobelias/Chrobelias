; query-00006.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_2 () (_ BitVec 32))
(assert
 (let (($x12 (= symbol_1 symbol_0)))
 (not $x12)))
(assert
 (bvslt symbol_1 symbol_2))
(assert
 (bvslt symbol_0 symbol_1))
(check-sat)
