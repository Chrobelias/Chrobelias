; query-00006.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (let (($x12 (bvsle symbol_0 (_ bv3 32))))
 (not $x12)))
(assert
 (let (($x15 (bvsle symbol_5 (_ bv3 32))))
 (not $x15)))
(assert
 (let (($x18 (bvsle symbol_4 (_ bv3 32))))
 (not $x18)))
(assert
 (let (($x21 (bvsle symbol_3 (_ bv3 32))))
 (not $x21)))
(check-sat)
