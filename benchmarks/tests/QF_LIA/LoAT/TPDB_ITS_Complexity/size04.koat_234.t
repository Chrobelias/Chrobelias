size04.koat_234
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size04.koat_234.smt2 || echo TIMEOUT
  Leftover formula:
  (and
                      (= eee1 (+ (* it1069 it117) (* it117 it13)))
                      (= (+ it1064 (* (- 2) it92) (* (- 1) i2)) 1)
                      (= (+ it1065 (* (- 1) i3) (* 2 it92)) 0)
                      (= (+ it1066 (* (- 1) i4 (exp (- 1) it92))) 0)
                      (= (+ it1067 (* (- 1) i5 (exp (- 1) it92))) 0)
                      (= (+ it1108 (* (- 2) it1069 it117) (* (- 2) it117 it13)
                         (* (- 1) it1064)) 0)
                      (= (+ it1109 (* (- 1) it1065) (* 2 it1069 it117)
                         (* 2 it117 it13)) 0)
                      (= (+ it1110 (* (- 1) it1066 (exp (- 1) eee1))) 0)
                      (= (+ it1111 (* (- 1) it1067 (exp (- 1) eee1))) 0)
                      (= (+ it1143 (* (- 2) it1115) (* (- 1) it1108)) 0)
                      (= (+ it1144 (* (- 1) it1109) (* 2 it1115)) 0)
                      (= (+ it1145 (* (- 1) it1110 (exp (- 1) it1115))) 0)
                      (= (+ it1146 (* (- 1) it1111 (exp (- 1) it1115))) 0)
                      (= (+ (* (- 24) it1069 (exp it117 3) (exp it13 2))
                         (* (- 24) it13 (exp it1069 2) (exp it117 3))
                         (* (- 8) (exp it1069 3) (exp it117 3))
                         (* (- 8) (exp it117 3) (exp it13 3))
                         (* (- 6) it1065 it1069 it117)
                         (* (- 6) it1065 it117 it13)
                         (* (- 6) it1069 it117 (exp it1065 2))
                         (* (- 6) it117 it13 (exp it1065 2)) (* (- 3) it1068)
                         (* (- 1) it1069 it117) (* (- 1) it117 it13)
                         (* 3 it1112) (* 6 (exp it1069 2) (exp it117 2))
                         (* 6 (exp it117 2) (exp it13 2))
                         (* 12 it1065 (exp it1069 2) (exp it117 2))
                         (* 12 it1065 (exp it117 2) (exp it13 2))
                         (* 12 it1069 it13 (exp it117 2))
                         (* 24 it1065 it1069 it13 (exp it117 2))) 0)
                      (= (+ (* (- 8) (exp it1115 3)) (* (- 6) it1109 it1115)
                         (* (- 6) it1115 (exp it1109 2)) (* (- 3) it1112)
                         (* (- 1) it1115) (* 3 it1147) (* 6 (exp it1115 2))
                         (* 12 it1109 (exp it1115 2))) 0)
                      (= (+ (* (- 8) (exp it92 3)) (* (- 6) i3 it92)
                         (* (- 6) it92 (exp i3 2)) (* (- 3) i6) (* (- 1) it92)
                         (* 3 it1068) (* 6 (exp it92 2))
                         (* 12 i3 (exp it92 2))) 0)
                      (= (+ (* 2 it1114) (* 2 it1148)) 0)
                      (<= (+ (* (- 2) it1069) (* (- 2) it13) (* (- 1) it1065)
                          (* 2 it1069) (* 2 it1069 it117) (* 2 it117 it13)
                          (* 2 it13)) 0)
                      (<= (+ (* (- 2) it1069) (* (- 2) it13) (* (- 1) it1065)
                          (* 2 it1069) (* 2 it1069 it117) (* 2 it117 it13)
                          (* 2 it13)) 1)
                      (<= (+ (* (- 2) it1069) (* (- 2) it13) (* (- 1) it1065)
                          (* 2 it1069 it117) (* 2 it117 it13) (* 2 it13)) 0)
                      (<= (+ (* (- 2) it1069) (* (- 2) it13) (* (- 1) it1065)
                          (* 2 it1069 it117) (* 2 it117 it13) (* 2 it13)) 1)
                      (<= (+ (* (- 1) i3) (* 2 it92)) 0)
                      (<= (+ (* (- 1) i3) (* 2 it92)) 1)
                      (<= (+ (* (- 1) it1065) (* 2 it1069) (* 2 it13)) 1)
                      (<= (+ (* (- 1) it1065) (* 2 it13)) 0)
                      (<= (+ (* (- 1) it1109) (* 2 it1115)) 0)
                      (<= (+ (* (- 1) it1109) (* 2 it1115)) 1)
                      (<= (+ (* (- 1) it1144) (* 2 it1114)) 0)
                      (<= (+ (* (- 1) it1144) (* 2 it1114)) 1)
                      (<= (+ (* (- 1) it1144) (* 2 it1114) (* 2 it1148)) 0)
                      (<= (+ (* (- 1) it1144) (* 2 it1114) (* 2 it1148)) 1)
                      (<= (+ (* 2 it1114) (* 2 it1148)) 0)
                      (<= (* (- 1) it1069) (- 1))
                      (<= (* (- 1) it1114) (- 1))
                      (<= (* (- 1) it1115) (- 1))
                      (<= (* (- 1) it1148) (- 1))
                      (<= (* (- 1) it117) (- 1))
                      (<= (* (- 1) it13) (- 1))
                      (<= (* (- 1) it92) (- 1)))
  Non linear arithmetic between
    0) i3
    1) it92
    
  Non linear arithmetic between
    0) i3
    1) (exp it92 2)
    
  Non linear arithmetic between
    0) i4
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) i5
    1) (exp (- 1) it92)
    
  Non linear arithmetic between
    0) it1065
    1) it1069
    2) it117
    
  Non linear arithmetic between
    0) it1065
    1) it1069
    2) it13
    3) (exp it117 2)
    
  Non linear arithmetic between
    0) it1065
    1) it117
    2) it13
    
  Non linear arithmetic between
    0) it1065
    1) (exp it1069 2)
    2) (exp it117 2)
    
  Non linear arithmetic between
    0) it1065
    1) (exp it117 2)
    2) (exp it13 2)
    
  Non linear arithmetic between
    0) it1066
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it1067
    1) (exp (- 1) eee1)
    
  Non linear arithmetic between
    0) it1069
    1) it117
    
  Non linear arithmetic between
    0) it1069
    1) it117
    2) (exp it1065 2)
    
  Non linear arithmetic between
    0) it1069
    1) it13
    2) (exp it117 2)
    
  Non linear arithmetic between
    0) it1069
    1) (exp it117 3)
    2) (exp it13 2)
    
  Non linear arithmetic between
    0) it1109
    1) it1115
    
  Non linear arithmetic between
    0) it1109
    1) (exp it1115 2)
    
  Non linear arithmetic between
    0) it1110
    1) (exp (- 1) it1115)
    
  Non linear arithmetic between
    0) it1111
    1) (exp (- 1) it1115)
    
  Non linear arithmetic between
    0) it1115
    1) (exp it1109 2)
    
  Non linear arithmetic between
    0) it117
    1) it13
    
  Non linear arithmetic between
    0) it117
    1) it13
    2) (exp it1065 2)
    
  Non linear arithmetic between
    0) it13
    1) (exp it1069 2)
    2) (exp it117 3)
    
  Non linear arithmetic between
    0) it92
    1) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp i3 2)
    
  Non linear arithmetic between
    0) (exp it1065 2)
    
  Non linear arithmetic between
    0) (exp it1069 2)
    
  Non linear arithmetic between
    0) (exp it1069 2)
    1) (exp it117 2)
    
  Non linear arithmetic between
    0) (exp it1069 3)
    
  Non linear arithmetic between
    0) (exp it1069 3)
    1) (exp it117 3)
    
  Non linear arithmetic between
    0) (exp it1109 2)
    
  Non linear arithmetic between
    0) (exp it1115 2)
    
  Non linear arithmetic between
    0) (exp it1115 3)
    
  Non linear arithmetic between
    0) (exp it117 2)
    
  Non linear arithmetic between
    0) (exp it117 2)
    1) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it117 3)
    
  Non linear arithmetic between
    0) (exp it117 3)
    1) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it13 2)
    
  Non linear arithmetic between
    0) (exp it13 3)
    
  Non linear arithmetic between
    0) (exp it92 2)
    
  Non linear arithmetic between
    0) (exp it92 3)
    
  UNKNOWN (Errors after simplification)
  TIMEOUT
