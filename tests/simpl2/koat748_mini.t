  $ cp koat748_mini.smt2 input.smt2

$ export CHRO_DEBUG=1
  $ Chro -dsimpl -pre-simpl -stop-after pre-simpl input.smt2 | sed 's/[[:space:]]*$//'
  sat (underapprox1)


  $ unset CHRO_DEBUG
  $ OCAMLRUNPARAM='b=0' Chro -no-pre-simpl input.smt2
  unknown (converting to automaton expression: unimplemented 0 <= (+ 2 + (* -1 * it1095 * (2 ** (+ -1 + it134))) + (* -1 * (2 ** it134))))

  $ OCAMLRUNPARAM='b=0' Chro input.smt2
  sat (underapprox1)


