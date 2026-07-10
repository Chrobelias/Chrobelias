; query-00001.smtml
(set-info :status unknown)
(set-logic ALL)
(assert
 (let ((?x14 (bvadd (_ bv1049644 32) (_ bv0 32))))
 (let ((?x12 (bvadd (_ bv1049668 32) (_ bv0 32))))
 (and (distinct ?x12 ?x14) true))))
(check-sat)
