; query-00109.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(assert
 (let ((?x29 (bvadd (_ bv1049708 32) (_ bv0 32))))
 (let ((?x12 (bvadd (_ bv1049704 32) (_ bv0 32))))
 (let ((?x23 ((_ extract 7 0) ?x12)))
 (let ((?x24 ((_ zero_extend 24) ?x23)))
 (let ((?x25 ((_ extract 7 0) ?x24)))
 (let ((?x19 ((_ extract 15 8) ?x12)))
 (let ((?x20 ((_ zero_extend 24) ?x19)))
 (let ((?x21 ((_ extract 7 0) ?x20)))
 (let ((?x16 ((_ extract 23 16) ?x12)))
 (let ((?x17 ((_ zero_extend 24) ?x16)))
 (let ((?x18 ((_ extract 7 0) ?x17)))
 (let ((?x22 (concat ?x18 ?x21)))
 (let ((?x26 (concat ?x22 ?x25)))
 (let ((?x13 ((_ extract 31 24) ?x12)))
 (let ((?x14 ((_ zero_extend 24) ?x13)))
 (let ((?x15 ((_ extract 7 0) ?x14)))
 (let ((?x27 (concat ?x15 ?x26)))
 (= ?x27 ?x29)))))))))))))))))))
(assert
 (let (($x33 (bvslt (_ bv10 32) symbol_0)))
 (not $x33)))
(assert
 (bvslt (_ bv9 32) symbol_0))
(assert
 (bvslt (_ bv8 32) symbol_0))
(assert
 (bvslt (_ bv7 32) symbol_0))
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
