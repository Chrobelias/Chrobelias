regex-018-translate-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-translate-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "`Ay['\t')lGz'\n'<"933'\x0c'+<6'{' ''OW`'\r'>rdAO)lc'\x0b'GWR[0M'\x0b'N")
  Fatal error: exception Failure("TBD")
  TIMEOUT
