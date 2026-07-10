; query-00048.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let ((?x14 (bvadd (_ bv1049696 32) (_ bv0 32))))
 (let ((?x12 (bvadd (_ bv1049684 32) (_ bv0 32))))
 (let (($x15 (= ?x12 ?x14)))
 (not $x15)))))
(assert
 (let (($x19 (bvslt (_ bv7 32) symbol_0)))
 (not $x19)))
(assert
 (bvslt (_ bv6 32) symbol_0))
(assert
 (bvslt (_ bv5 32) symbol_0))
(assert
 (bvslt (_ bv4 32) symbol_0))
(assert
 (bvslt (_ bv3 32) symbol_0))
(assert
 (bvslt symbol_0 (_ bv16 32)))
(assert
 (bvsgt symbol_0 (_ bv2 32)))
(check-sat)
