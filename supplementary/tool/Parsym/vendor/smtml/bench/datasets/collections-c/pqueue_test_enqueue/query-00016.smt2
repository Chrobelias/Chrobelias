; query-00016.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_2 () (_ BitVec 32))
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(assert
 (bvslt symbol_2 (_ bv8388608 32)))
(assert
 (bvsgt symbol_1 (_ bv4286578688 32)))
(assert
 (bvslt symbol_1 (_ bv8388608 32)))
(assert
 (bvsgt symbol_0 (_ bv4286578688 32)))
(assert
 (bvslt symbol_0 (_ bv8388608 32)))
(assert
 (let ((?x22 (bvsub symbol_4 symbol_5)))
 (let (($x24 (bvsgt ?x22 (_ bv0 32))))
 (not $x24))))
(assert
 (bvsgt symbol_5 (_ bv4286578688 32)))
(assert
 (bvslt symbol_5 (_ bv8388608 32)))
(assert
 (bvsgt symbol_4 (_ bv4286578688 32)))
(assert
 (bvslt symbol_4 (_ bv8388608 32)))
(check-sat)
