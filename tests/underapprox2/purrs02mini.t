  $ export CHRO_DEBUG=1
  $ timeout 2 Chro -no-over -bound 0 --dsimpl ../../benchmarks/QF_LIA/PURRS/purrs02.smt2 --stop-after presimpl #| sed 's/[[:space:]]*$//'
  unsat (presimpl int)


