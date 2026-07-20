$ cat  sum3exp.smt2
  $ export CHRO_DEBUG=1
$ export CHRO_TRACE_OPT=1
 -under2 -amin 0 -amax 11
  $ Chro -no-over -bound 3 --dsimpl sum3exp.smt2
  sat (under int)

