$ cat  sum3exp.smt2
  $ export CHRO_DEBUG=1
  $ export CHRO_TRACE_OPT=1
  $ ls ../underapprox
  $ Chro -dsimpl -pre-simpl -stop-after pre-simpl -bound 3 ../underapprox/sum3exp.smt2
  Interesting: x1 x2 x3

  Expecting 27 choices ...

  lib/Underapprox.ml gives early Sat.
  env = {| x1->0 x2->2 x3->0 |}
  sat

