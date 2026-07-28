  $ cp koat748_mini.smt2 input.smt2

$ export CHRO_DEBUG=simpl
  $ Chro --dsimpl --stop-after pre-simpl input.smt2 | sed 's/[[:space:]]*$//'


  $ unset CHRO_DEBUG
  $ OCAMLRUNPARAM='b=0' Chro input.smt2
  sat (under int)

  $ OCAMLRUNPARAM='b=0' Chro input.smt2
  sat (under int)


