; query-00005.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (bvsgt symbol_5 (_ bv5 32)))
(assert
 (let (($x14 (bvsgt symbol_4 (_ bv5 32))))
 (not $x14)))
(assert
 (let (($x17 (bvsgt symbol_3 (_ bv5 32))))
 (not $x17)))
(check-sat)
