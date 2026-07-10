; query-00009.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let ((?x14 (bvadd (_ bv1049680 32) (_ bv0 32))))
 (let ((?x12 (bvadd (_ bv1049676 32) (_ bv0 32))))
 (= ?x12 ?x14))))
(assert
 (let (($x18 (bvslt (_ bv3 32) symbol_0)))
 (not $x18)))
(assert
 (bvslt symbol_0 (_ bv16 32)))
(assert
 (bvsgt symbol_0 (_ bv2 32)))
(check-sat)
