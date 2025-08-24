  $ cp ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_748.smt2 input.smt2

  $ export CHRO_DEBUG=1
  $ Chro -dsimpl -pre-simpl -stop-after pre-simpl input.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (and
               (<= (+ 0 0) (+ (+ (+ 0 it1141)
                              (* (+ 0 it1143) (exp 2 (+ it57 (* (- 1) 1)))
                              (+ 0 (* (- 1) 1))))
                           (+ 0 (* (- 1) 1))))
               (<= 0 (+ (* it1143 (* (- 1) 1)) it1141))
               (<= 0 (+ it1138 (* (- 1) 3)))
               (<= 0 (+ it1143 (* (- 1) 1)))
               (<= 0 (+ it57 (* (- 1) 1))))
             (= (+ (* it1126 (* (- 1) 2)) it1143) 0)
             (= (+ it1126 (* it1118 (* (- 1) 1))) 0)
             (= (+ (+ (* it88 (* (- 1) 3)) (* it1117 (* (- 1) 1))) it1125) 0)
             (= (+ it1124 (* it1116 (* (- 1) 1))) 0)
             (= (+ (* it1109 (* (- 1) 1)) it1119) 0)
             (= (+ it1118 (* (- 1) 1)) 0)
             (and
               (<= 0 (+ it134 (* (- 1) 1)))
               (<= (+ 0 0) (+ (+ (* (+ 0 it1095) (exp 2 (+ it134 (* (- 1) 1)))
                                 (+ 0 (* (- 1) 1)))
                              (* (exp 2 it134) (+ 0 (* (- 1) 1))))
                           (+ 0 2)))
               (<= 0 (+ (* it1090 (* (- 1) 1)) 3))
               (<= 0 (+ (* it1095 (* (- 1) 1)) it1093))))
  iteration 2
  ast(2) = (and
             (= it1118 1)
             (= (+ it1119 (* (- 1) it1109)) 0)
             (= (+ it1124 (* (- 1) it1116)) 0)
             (= (+ it1125 (* (- 3) it88) (* (- 1) it1117)) 0)
             (= (+ it1126 (* (- 1) it1118)) 0)
             (= (+ it1143 (* (- 2) it1126)) 0)
             (<= it1090 3)
             (<= (+ it1095 (* (- 1) it1093)) 0)
             (<= (+ it1143 (* (- 1) it1141)) 0)
             (<= (+ (* it1095 (exp 2 (+ (- 1) it134))) (exp 2 it134)) 2)
             (<= (+ (* it1143 (exp 2 (+ (- 1) it57))) (* (- 1) it1141)) (- 1))
             (<= (* (- 1) it1138) (- 3))
             (<= (* (- 1) it1143) (- 1))
             (<= (* (- 1) it134) (- 1))
             (<= (* (- 1) it57) (- 1)))
  Something ready to substitute:  it1118 -> 1; it1119 -> it1109; it1124 ->
                                 it1116; it1126 -> it1118; it1143 -> (* 2
                                                                     it1126);
  iteration 3
  ast(3) = (and
             (= it1118 1)
             (= (+ it1119 (* (- 1) it1109)) 0)
             (= (+ it1124 (* (- 1) it1116)) 0)
             (= (+ it1125 (* (- 3) it88) (* (- 1) it1117)) 0)
             (= (+ it1126 (* (- 1) it1118)) 0)
             (= (+ it1143 (* (- 2) it1126)) 0)
             (<= it1090 3)
             (<= (+ it1095 (* (- 1) it1093)) 0)
             (<= (+ it1143 (* (- 1) it1141)) 0)
             (<= (+ (* it1095 (exp 2 (+ (- 1) it134))) (exp 2 it134)) 2)
             (<= (+ (* it1143 (exp 2 (+ (- 1) it57))) (* (- 1) it1141)) (- 1))
             (<= (* (- 1) it1138) (- 3))
             (<= (* (- 1) it1143) (- 1))
             (<= (* (- 1) it134) (- 1))
             (<= (* (- 1) it57) (- 1)))
  iteration 4
  ast(4) = (and
             (= it1118 1)
             (= (+ it1125 (* (- 3) it88) (* (- 1) it1117)) 0)
             (= (+ (* (- 2) it1118) (* 2 it1126)) 0)
             (<= it1090 3)
             (<= (+ it1095 (* (- 1) it1093)) 0)
             (<= (+ (* it1095 (exp 2 (+ (- 1) it134))) (exp 2 it134)) 2)
             (<= (+ (* (- 1) it1141) (* 2 it1126)) 0)
             (<= (+ (* (- 1) it1141) (* 2 it1126 (exp 2 (+ (- 1) it57)))) (- 1))
             (<= (* (- 2) it1126) (- 1))
             (<= (* (- 1) it1138) (- 3))
             (<= (* (- 1) it134) (- 1))
             (<= (* (- 1) it57) (- 1)))
  iteration 5
  ast(5) = (and
             (= (+ it1125 (* (- 3) it88) (* (- 1) it1117)) 0)
             (= (* 2 it1118) 2)
             (<= it1090 3)
             (<= (+ it1095 (* (- 1) it1093)) 0)
             (<= (+ (* it1095 (exp 2 (+ (- 1) it134))) (exp 2 it134)) 2)
             (<= (+ (* (- 1) it1141) (* 2 it1118)) 0)
             (<= (+ (* (- 1) it1141) (* 2 it1118 (exp 2 (+ (- 1) it57)))) (- 1))
             (<= (* (- 2) it1118) (- 1))
             (<= (* (- 1) it1138) (- 3))
             (<= (* (- 1) it134) (- 1))
             (<= (* (- 1) it57) (- 1)))
  iteration 6
  ast(6) = (and
             (= (+ it1125 (* (- 3) it88) (* (- 1) it1117)) 0)
             (<= it1090 3)
             (<= (+ it1095 (* (- 1) it1093)) 0)
             (<= (+ (* it1095 (exp 2 (+ (- 1) it134))) (exp 2 it134)) 2)
             (<= (+ (* (- 1) it1141) (* 2 (exp 2 (+ (- 1) it57)))) (- 1))
             (<= (* (- 1) it1138) (- 3))
             (<= (* (- 1) it1141) (- 2))
             (<= (* (- 1) it134) (- 1))
             (<= (* (- 1) it57) (- 1)))
  Fixpoint after 6 steps


  $ unset CHRO_DEBUG
  $ Chro -no-pre-simpl input.smt2
  sat
  $ Chro input.smt2

  Raised at Stdlib.failwith in file "stdlib.ml", line 29, characters 17-33
  Called from Lib__Me.Symantics.mul in file "lib/me.ml", line 152, characters 13-53
  Called from Lib__Me.of_eia2.helper in file "lib/me.ml", line 220, characters 65-76
  Called from Lib__Me.of_eia2 in file "lib/me.ml", line 240, characters 55-67
  Called from Stdlib__List.map in file "list.ml", line 87, characters 15-19
  Called from Stdlib__List.map in file "list.ml", line 88, characters 14-21
  Called from Lib__Me.ir_of_ast.ir_of_ast in file "lib/me.ml", line 544, characters 19-42
  Called from Dune__exe__Chro.check_sat in file "bin/chro.ml", line 48, characters 32-54
  Called from Dune__exe__Chro.exec in file "bin/chro.ml", line 88, characters 6-19
  Called from Stdlib__List.fold_left in file "list.ml", line 123, characters 24-34
  Called from Dune__exe__Chro in file "bin/chro.ml", line 117, characters 10-61
  [2]
