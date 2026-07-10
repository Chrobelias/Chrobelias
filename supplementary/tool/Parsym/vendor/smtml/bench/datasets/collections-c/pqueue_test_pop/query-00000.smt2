; query-00000.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_6 () (_ BitVec 32))
(assert
 (let (($x12 (bvslt symbol_6 (_ bv8388608 32))))
 (not $x12)))
(check-sat)
