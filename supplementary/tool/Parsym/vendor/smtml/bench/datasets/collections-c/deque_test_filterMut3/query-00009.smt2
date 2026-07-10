; query-00009.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (let (($x12 (bvsgt symbol_1 (_ bv5 32))))
 (not $x12)))
(assert
 (let (($x15 (bvsgt symbol_0 (_ bv5 32))))
 (not $x15)))
(assert
 (bvsgt symbol_5 (_ bv5 32)))
(assert
 (let (($x20 (bvsgt symbol_4 (_ bv5 32))))
 (not $x20)))
(assert
 (let (($x23 (bvsgt symbol_3 (_ bv5 32))))
 (not $x23)))
(check-sat)
