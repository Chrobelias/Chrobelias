; query-00009.smtml
(set-info :status unknown)
(set-logic ALL)
(declare-fun symbol_1 () (_ BitVec 32))
(declare-fun symbol_0 () (_ BitVec 32))
(declare-fun symbol_5 () (_ BitVec 32))
(declare-fun symbol_4 () (_ BitVec 32))
(declare-fun symbol_3 () (_ BitVec 32))
(assert
 (bvsle symbol_1 (_ bv3 32)))
(assert
 (bvsle symbol_0 (_ bv3 32)))
(assert
 (let (($x16 (bvsle symbol_5 (_ bv3 32))))
 (not $x16)))
(assert
 (let (($x19 (bvsle symbol_4 (_ bv3 32))))
 (not $x19)))
(assert
 (let (($x22 (bvsle symbol_3 (_ bv3 32))))
 (not $x22)))
(check-sat)
