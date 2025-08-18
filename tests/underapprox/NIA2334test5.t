
  $ export CHRO_DEBUG=1
  $ export CHRO_TRACE_OPT=1
  $ export OCAMLRUNPARAM="b=0"
  $ Chro -bound 3  -dsimpl -stop-after simpl ../overapprox/NIA2334test5.smt2
  Fatal error: exception Uncaught exception:
  File "vendor/smtml/src/smtml/smtlib.ml", line 343, characters 30-36: Assertion failed
  with backtrace:
  
  [2]
