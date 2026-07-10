; query-00004.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (let (($x12 (bvsgt symbol_5 (_ bv5 32))))
 (not $x12)))
(assert
 (let (($x15 (bvsgt symbol_4 (_ bv5 32))))
 (not $x15)))
(assert
 (let (($x18 (bvsgt symbol_3 (_ bv5 32))))
 (not $x18)))
(check-sat)
