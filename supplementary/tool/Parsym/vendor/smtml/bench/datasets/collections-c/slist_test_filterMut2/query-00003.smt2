; query-00003.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let (($x12 (bvsge symbol_1 (_ bv3 32))))
 (not $x12)))
(assert
 (let (($x15 (bvsge symbol_0 (_ bv3 32))))
 (not $x15)))
(check-sat)
