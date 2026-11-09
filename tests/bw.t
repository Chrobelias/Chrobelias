Basic BW tests
$ cat bw.smt2
$ export OCAMLRUNPARAM='b=0'
$ export CHRO_TRACE_OPT=1 CHRO_DEBUG=1
  $ Chro --dpresimpl --stop-after simpl ./bw.smt2
  sat (presimpl int)

Why automata gives unsat?
  $ Chro --dpresimpl ./bw.smt2
  sat (presimpl int)
