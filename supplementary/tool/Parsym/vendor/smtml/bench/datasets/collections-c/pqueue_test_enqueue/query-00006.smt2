; query-00006.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(assert
 (let (($x12 (bvsgt symbol_4 symbol_5)))
 (not $x12)))
(assert
 (let ((?x14 (bvsub symbol_4 symbol_5)))
 (let (($x16 (bvsgt ?x14 (_ bv0 32))))
 (not $x16))))
(assert
 (bvsgt symbol_5 (_ bv4286578688 32)))
(assert
 (bvslt symbol_5 (_ bv8388608 32)))
(assert
 (bvsgt symbol_4 (_ bv4286578688 32)))
(assert
 (bvslt symbol_4 (_ bv8388608 32)))
(check-sat)
