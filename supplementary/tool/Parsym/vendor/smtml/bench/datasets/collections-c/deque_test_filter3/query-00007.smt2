; query-00007.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (let (($x12 (bvsgt symbol_0 (_ bv5 32))))
 (not $x12)))
(assert
 (bvsgt symbol_5 (_ bv5 32)))
(assert
 (let (($x17 (bvsgt symbol_4 (_ bv5 32))))
 (not $x17)))
(assert
 (let (($x20 (bvsgt symbol_3 (_ bv5 32))))
 (not $x20)))
(check-sat)
