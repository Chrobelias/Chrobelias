Basic BW tests
$ cat bw.smt2
$ export OCAMLRUNPARAM='b=0'
$ export CHRO_TRACE_OPT=1 CHRO_DEBUG=1
  $ Chro -stop-after simpl -dpresimpl ./bw.smt2
  (and
    (= (5 & 3) 1)
    (= (5 | 3) 7))

Why automata gives unsat?
  $ Chro -dpresimpl ./bw.smt2
  (and
    (= (5 & 3) 1)
    (= (5 | 3) 7))
  sat (nfa)
