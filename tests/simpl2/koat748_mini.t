  $ cp koat748_mini.smt2 input.smt2

  $ export CHRO_DEBUG=1
  $ Chro -dsimpl -pre-simpl -stop-after pre-simpl input.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (and
               (<= 0 (+ (+ it1141
                        (* it1143 (exp 2 (+ it57 (* (- 1) 1))) (* (- 1) 1)))
                     (* (- 1) 1))))
             (= (+ (* it1126 (* (- 1) 2)) it1143) 0)
             (= (+ it1126 (* it1118 (* (- 1) 1))) 0)
             (= (+ it1118 (* (- 1) 1)) 0)
             (<= 0 (+ (+ 2
                      (* (* (- 1) 1) it1095 (exp 2 (+ it134 (* (- 1) 1)))))
                   (* (* (- 1) 1) (exp 2 it134)))))
  iteration 2
  ast(2) = (and
             (= it1118 1)
             (= (+ it1126 (* (- 1) it1118)) 0)
             (= (+ it1143 (* (- 2) it1126)) 0)
             (<= (+ (* it1095 (exp 2 (+ (- 1) it134))) (exp 2 it134)) 2)
             (<= (+ (* it1143 (exp 2 (+ (- 1) it57))) (* (- 1) it1141)) (- 1)))
  Something ready to substitute:  it1118 -> 1; it1143 -> (* 2 it1126);
  iteration 3
  ast(3) = (and
             (= it1118 1)
             (= (+ it1126 (* (- 1) it1118)) 0)
             (= (+ it1143 (* (- 2) it1126)) 0)
             (<= (+ (* it1095 (exp 2 (+ (- 1) it134))) (exp 2 it134)) 2)
             (<= (+ (* it1143 (exp 2 (+ (- 1) it57))) (* (- 1) it1141)) (- 1)))
  iteration 4
  ast(4) = (and
             (= it1126 1)
             (= (+ (* (- 2) it1126) (* 2 it1126)) 0)
             (<= (+ (* it1095 (exp 2 (+ (- 1) it134))) (exp 2 it134)) 2)
             (<= (+ (* (- 1) it1141) (* 2 it1126 (exp 2 (+ (- 1) it57)))) (- 1)))
  Something ready to substitute:  it1118 -> 1; it1126 -> 1; it1143 -> (* 2
                                                                      it1126);
  iteration 5
  ast(5) = (and
             (= it1126 1)
             (= (+ (* (- 2) it1126) (* 2 it1126)) 0)
             (<= (+ (* it1095 (exp 2 (+ (- 1) it134))) (exp 2 it134)) 2)
             (<= (+ (* (- 1) it1141) (* 2 it1126 (exp 2 (+ (- 1) it57)))) (- 1)))
  iteration 6
  ast(6) = (and
             (<= (+ (* it1095 (exp 2 (+ (- 1) it134))) (exp 2 it134)) 2)
             (<= (+ (* (- 1) it1141) (exp 2 it57)) (- 1)))
  Fixpoint after 6 steps


  $ unset CHRO_DEBUG
  $ OCAMLRUNPARAM='b=0' Chro -no-pre-simpl input.smt2
  Fatal error: exception Failure("unimplemented 0 <= (+ 2 + (* -1 * it1095 * (2 ** (+ -1 + it134))) + (* -1 * (2 ** it134)))")
  [2]

  $ OCAMLRUNPARAM='b=0' Chro input.smt2
  sat


