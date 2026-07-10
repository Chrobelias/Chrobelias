; query-00006.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (bvsgt symbol_0 (_ bv5 32)))
(assert
 (bvsgt symbol_5 (_ bv5 32)))
(assert
 (let (($x16 (bvsgt symbol_4 (_ bv5 32))))
 (not $x16)))
(assert
 (let (($x19 (bvsgt symbol_3 (_ bv5 32))))
 (not $x19)))
(check-sat)
