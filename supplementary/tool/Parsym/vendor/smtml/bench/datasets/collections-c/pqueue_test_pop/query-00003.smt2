; query-00003.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_7 () (_ BitVec 32))
(declare-fun symbol_6 () (_ BitVec 32))
(assert
 (bvslt symbol_7 (_ bv8388608 32)))
(assert
 (bvsgt symbol_6 (_ bv4286578688 32)))
(assert
 (bvslt symbol_6 (_ bv8388608 32)))
(check-sat)
