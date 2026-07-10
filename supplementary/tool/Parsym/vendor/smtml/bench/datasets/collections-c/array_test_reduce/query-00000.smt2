; query-00000.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let ((?x12 (bvadd symbol_0 (_ bv0 32))))
 (let (($x13 (= symbol_0 ?x12)))
 (not $x13))))
(check-sat)
