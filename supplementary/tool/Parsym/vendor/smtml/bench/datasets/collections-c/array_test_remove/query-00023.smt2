; query-00023.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let ((?x14 (bvadd (_ bv1049688 32) (_ bv0 32))))
 (let ((?x12 (bvadd (_ bv1049676 32) (_ bv0 32))))
 (= ?x12 ?x14))))
(assert
 (let (($x18 (bvslt (_ bv5 32) symbol_0)))
 (not $x18)))
(assert
 (bvslt (_ bv4 32) symbol_0))
(assert
 (bvslt (_ bv3 32) symbol_0))
(assert
 (bvslt symbol_0 (_ bv16 32)))
(assert
 (bvsgt symbol_0 (_ bv2 32)))
(check-sat)
