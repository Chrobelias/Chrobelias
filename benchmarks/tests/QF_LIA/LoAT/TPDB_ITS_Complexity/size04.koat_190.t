size04.koat_190
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size04.koat_190.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee2 (+ (* it117 it499) (* it117 it553)))
                      (= eee1 (+ (* it13 it488) (* it488 it92)))
                      (= (+ it492 (* (- 2) it13 it488) (* (- 2) it488 it92)
                         (* (- 1) i2)) 1)
                      (= (+ it493 (* (- 1) i3) (* 2 it13 it488)
                         (* 2 it488 it92)) 0)
                      (= (+ it494 (* (- 1) i4 (exp (- 1) eee1))) 0)
                      (= (+ it495 (* (- 1) i5 (exp (- 1) eee1))) 0)
                      (= (+ it548 (* (- 2) it498) (* (- 1) it492)) 0)
                      (= (+ it549 (* (- 1) it493) (* 2 it498)) 0)
                      (= (+ it550 (* (- 1) it494 (exp (- 1) it498))) 0)
                      (= (+ it551 (* (- 1) it495 (exp (- 1) it498))) 0)
                      (= (+ it733 (* (- 2) it117 it499) (* (- 2) it117 it553)
                         (* (- 1) it548)) 0)
                      (= (+ it734 (* (- 1) it549) (* 2 it117 it499)
                         (* 2 it117 it553)) 0)
                      (= (+ it735 (* (- 1) it550 (exp (- 1) eee2))) 0)
                      (= (+ it736 (* (- 1) it551 (exp (- 1) eee2))) 0)
                      (= (+ it941 (* (- 3) it735) (* (- 2) it736)) 0)
                      (= (+ it942 (* 3 it736) (* 5 it735)) 0)
                      (= (+ it943 (* (- 1) it737) (* (- 1) (exp it734 2))) 0)
                      (= (+ (* (- 24) it13 (exp it488 3) (exp it92 2))
                         (* (- 24) it92 (exp it13 2) (exp it488 3))
                         (* (- 8) (exp it13 3) (exp it488 3))
                         (* (- 8) (exp it488 3) (exp it92 3))
                         (* (- 6) i3 it13 it488) (* (- 6) i3 it488 it92)
                         (* (- 6) it13 it488 (exp i3 2))
                         (* (- 6) it488 it92 (exp i3 2)) (* (- 3) i6)
                         (* (- 1) it13 it488) (* (- 1) it488 it92) (* 3 it496)
                         (* 6 (exp it13 2) (exp it488 2))
                         (* 6 (exp it488 2) (exp it92 2))
                         (* 12 i3 (exp it13 2) (exp it488 2))
                         (* 12 i3 (exp it488 2) (exp it92 2))
                         (* 12 it13 it92 (exp it488 2))
                         (* 24 i3 it13 it92 (exp it488 2))) 0)
                      (= (+ (* (- 24) it499 (exp it117 3) (exp it553 2))
                         (* (- 24) it553 (exp it117 3) (exp it499 2))
                         (* (- 8) (exp it117 3) (exp it499 3))
                         (* (- 8) (exp it117 3) (exp it553 3))
                         (* (- 6) it117 it499 it549)
                         (* (- 6) it117 it499 (exp it549 2))
                         (* (- 6) it117 it549 it553)
                         (* (- 6) it117 it553 (exp it549 2)) (* (- 3) it552)
                         (* (- 1) it117 it499) (* (- 1) it117 it553)
                         (* 3 it737) (* 6 (exp it117 2) (exp it499 2))
                         (* 6 (exp it117 2) (exp it553 2))
                         (* 12 it499 it553 (exp it117 2))
                         (* 12 it549 (exp it117 2) (exp it499 2))
                         (* 12 it549 (exp it117 2) (exp it553 2))
                         (* 24 it499 it549 it553 (exp it117 2))) 0)
                      (= (+ (* (- 8) (exp it498 3)) (* (- 6) it493 it498)
                         (* (- 6) it498 (exp it493 2)) (* (- 3) it496)
                         (* (- 1) it498) (* 3 it552) (* 6 (exp it498 2))
                         (* 12 it493 (exp it498 2))) 0)
                      (= (+ (* 2 it739) (* 2 it740)) 0)
                      (<= 1 it734)
                      (<= (+ (* (- 2) it13) (* (- 2) it92) (* (- 1) i3)
                          (* 2 it13) (* 2 it13 it488) (* 2 it488 it92)
                          (* 2 it92)) 0)
                      (<= (+ (* (- 2) it13) (* (- 2) it92) (* (- 1) i3)
                          (* 2 it13) (* 2 it13 it488) (* 2 it488 it92)
                          (* 2 it92)) 1)
                      (<= (+ (* (- 2) it13) (* (- 1) i3) (* 2 it13 it488)
                          (* 2 it488 it92)) 0)
                      (<= (+ (* (- 2) it13) (* (- 1) i3) (* 2 it13 it488)
                          (* 2 it488 it92)) 1)
                      (<= (+ (* (- 2) it499) (* (- 2) it553) (* (- 1) it549)
                          (* 2 it117 it499) (* 2 it117 it553) (* 2 it499)) 0)
                      (<= (+ (* (- 2) it499) (* (- 2) it553) (* (- 1) it549)
                          (* 2 it117 it499) (* 2 it117 it553) (* 2 it499)) 1)
                      (<= (+ (* (- 2) it499) (* (- 2) it553) (* (- 1) it549)
                          (* 2 it117 it499) (* 2 it117 it553) (* 2 it499)
                          (* 2 it553)) 0)
                      (<= (+ (* (- 2) it499) (* (- 2) it553) (* (- 1) it549)
                          (* 2 it117 it499) (* 2 it117 it553) (* 2 it499)
                          (* 2 it553)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it13) (* 2 it92)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it92)) 0)
                      (<= (+ (* (- 1) it493) (* 2 it498)) 0)
                      (<= (+ (* (- 1) it493) (* 2 it498)) 1)
                      (<= (+ (* (- 1) it549) (* 2 it499)) 0)
                      (<= (+ (* (- 1) it549) (* 2 it499) (* 2 it553)) 1)
                      (<= (+ (* (- 1) it734) (* 2 it739) (* 2 it740)) (- 1))
                      (<= (+ (* (- 1) it734) (* 2 it739) (* 2 it740)) 0)
                      (<= (+ (* (- 1) it734) (* 2 it740)) (- 1))
                      (<= (+ (* (- 1) it734) (* 2 it740)) 0)
                      (<= (+ (* 2 it739) (* 2 it740)) 0)
                      (<= (* (- 1) it117) (- 1))
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it488) (- 1))
                      (<= (* (- 1) it498) (- 1))
                      (<= (* (- 1) it499) (- 1))
                      (<= (* (- 1) it553) (- 1))
                      (<= (* (- 1) it739) (- 1))
                      (<= (* (- 1) it740) (- 1))
                      (<= (* (- 1) it92) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it13
    2) it488
    
  Non linear arithmetic between
    0) i3
    1) it13
    2) it92
    3) (exp it488 2)
    
  Non linear arithmetic between
    0) i3
    1) it488
    2) it92
    
  Non linear arithmetic between
    0) i3
    1) (exp it13 2)
    2) (exp it488 2)
    
  Non linear arithmetic between
    0) i3
    1) (exp it488 2)
    2) (exp it92 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it117
    1) it499
    
  Non linear arithmetic between
    0) it117
    1) it499
    2) it549
    
  Non linear arithmetic between
    0) it117
    1) it499
    2) (exp it549 2)
    
  Non linear arithmetic between
    0) it117
    1) it549
    2) it553
    
  Non linear arithmetic between
    0) it117
    1) it553
    
  Non linear arithmetic between
    0) it117
    1) it553
    2) (exp it549 2)
    
  Non linear arithmetic between
    0) it13
    1) it488
    
  Non linear arithmetic between
    0) it13
    1) it488
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it13
    1) it92
    2) (exp it488 2)
    
  Non linear arithmetic between
    0) it13
    1) (exp it488 3)
    2) (exp it92 2)
    
  Non linear arithmetic between
    0) it488
    1) it92
    
  Non linear arithmetic between
    0) it488
    1) it92
    2) (exp i3 2)
    
  Non linear arithmetic between
    0) it493
    1) it498
    
  Non linear arithmetic between
    0) it493
    1) (exp it498 2)
    
  Non linear arithmetic between
    0) it494
    1) (exp (- 1) it498)
    
  Non linear arithmetic between
    0) it495
    1) (exp (- 1) it498)
    
  Non linear arithmetic between
    0) it498
    1) (exp it493 2)
    
  Non linear arithmetic between
    0) it499
    1) it549
    2) it553
    3) (exp it117 2)
    
  Non linear arithmetic between
    0) it499
    1) it553
    2) (exp it117 2)
    
  Non linear arithmetic between
    0) it499
    1) (exp it117 3)
    2) (exp it553 2)
    
  Non linear arithmetic between
    0) it549
    1) (exp it117 2)
    2) (exp it499 2)
    
  Non linear arithmetic between
    0) it549
    1) (exp it117 2)
    2) (exp it553 2)
    
  Non linear arithmetic between
    0) it550
    1) (exp (- 1) eee2)
    
  Non linear arithmetic between
    0) it551
    1) (exp (- 1) eee2)
    
  Non linear arithmetic between
    0) it553
    1) (exp it117 3)
    2) (exp it499 2)
    
  Non linear arithmetic between
    0) it92
    1) (exp it13 2)
    2) (exp it488 3)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it117 2)
    
  Non linear arithmetic between
    0) (exp it117 2)
    1) (exp it499 2)
    
  Non linear arithmetic between
    0) (exp it117 2)
    1) (exp it553 2)
    
  Non linear arithmetic between
    0) (exp it117 3)
    
  Non linear arithmetic between
    0) (exp it117 3)
    1) (exp it499 3)
    
  Non linear arithmetic between
    0) (exp it117 3)
    1) (exp it553 3)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 2)
    1) (exp it488 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it13 3)
    1) (exp it488 3)
    
  Non linear arithmetic between
    0) (exp it488 2)
    
  Non linear arithmetic between
    0) (exp it488 2)
    1) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it488 3)
    
  Non linear arithmetic between
    0) (exp it488 3)
    1) (exp it92 3)
    
  Non linear arithmetic between
    0) (exp it493 2)
    
  Non linear arithmetic between
    0) (exp it498 2)
    
  Non linear arithmetic between
    0) (exp it498 3)
    
  Non linear arithmetic between
    0) (exp it499 2)
    
  Non linear arithmetic between
    0) (exp it499 3)
    
  Non linear arithmetic between
    0) (exp it549 2)
    
  Non linear arithmetic between
    0) (exp it553 2)
    
  Non linear arithmetic between
    0) (exp it553 3)
    
  Non linear arithmetic between
    0) (exp it734 2)
    
  Non linear arithmetic between
    0) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it92 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
