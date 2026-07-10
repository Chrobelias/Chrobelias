; query-00010.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(assert
 (let (($x12 (bvslt symbol_0 (_ bv8388608 32))))
 (not $x12)))
(assert
 (let ((?x16 (bvsub symbol_4 symbol_5)))
 (let (($x18 (bvsgt ?x16 (_ bv0 32))))
 (not $x18))))
(assert
 (bvsgt symbol_5 (_ bv4286578688 32)))
(assert
 (bvslt symbol_5 (_ bv8388608 32)))
(assert
 (bvsgt symbol_4 (_ bv4286578688 32)))
(assert
 (bvslt symbol_4 (_ bv8388608 32)))
(check-sat)
