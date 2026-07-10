; query-00000.smtml
(set-info :status unknown)
(set-logic ALL)
(assert
 (let ((?x14 (bvadd (_ bv1049704 32) (_ bv0 32))))
 (let ((?x12 (bvadd (_ bv1049840 32) (_ bv0 32))))
 (let (($x15 (and (distinct ?x12 ?x14) true)))
 (not $x15)))))
(check-sat)
