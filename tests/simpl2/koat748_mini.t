  $ cp koat748_mini.smt2 input.smt2

$ export CHRO_DEBUG=1
  $ Chro --dsimpl --pre-simpl --stop-after pre-simpl input.smt2 | sed 's/[[:space:]]*$//'
  sat (under I)


  $ unset CHRO_DEBUG
  $ OCAMLRUNPARAM='b=0' Chro --no-pre-simpl input.smt2
  unknown (nfa; unimplemented (<= 0 (+ (+ it1141
                         (* it1143 (exp 2 (+ it57 (* (- 1) 1))) (* (- 1) 1)))
                      (* (- 1) 1))))

  $ OCAMLRUNPARAM='b=0' Chro input.smt2
  sat (under I)


