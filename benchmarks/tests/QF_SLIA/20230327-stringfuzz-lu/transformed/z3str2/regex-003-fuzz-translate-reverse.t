regex-003-fuzz-translate-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-translate-reverse.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x ">#W))_'c0x\\'z'b0x\\'@zT/Q6S*EIP1LGzI0L@z+'y2zlzO@z`_:='c0x\\'R9Z")
  Fatal error: exception Failure("TBD")
  TIMEOUT
