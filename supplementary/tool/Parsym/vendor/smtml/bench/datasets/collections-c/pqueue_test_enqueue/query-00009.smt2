; query-00009.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(assert
 (bvsle symbol_4 symbol_5))
(assert
 (let ((?x13 (bvsub symbol_4 symbol_5)))
 (let (($x15 (bvsgt ?x13 (_ bv0 32))))
 (not $x15))))
(assert
 (bvsgt symbol_5 (_ bv4286578688 32)))
(assert
 (bvslt symbol_5 (_ bv8388608 32)))
(assert
 (bvsgt symbol_4 (_ bv4286578688 32)))
(assert
 (bvslt symbol_4 (_ bv8388608 32)))
(check-sat)
