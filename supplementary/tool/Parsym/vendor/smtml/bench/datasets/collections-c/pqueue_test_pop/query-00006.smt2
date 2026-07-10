; query-00006.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_8 () (_ BitVec 32))
(declare-fun symbol_6 () (_ BitVec 32))
(declare-fun symbol_7 () (_ BitVec 32))
(assert
 (let (($x12 (bvsgt symbol_6 symbol_8)))
 (not $x12)))
(assert
 (bvsgt symbol_8 (_ bv4286578688 32)))
(assert
 (bvslt symbol_8 (_ bv8388608 32)))
(assert
 (bvsgt symbol_7 (_ bv4286578688 32)))
(assert
 (bvslt symbol_7 (_ bv8388608 32)))
(assert
 (bvsgt symbol_6 (_ bv4286578688 32)))
(assert
 (bvslt symbol_6 (_ bv8388608 32)))
(check-sat)
