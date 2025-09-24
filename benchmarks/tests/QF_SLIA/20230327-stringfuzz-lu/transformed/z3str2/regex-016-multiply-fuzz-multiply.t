regex-016-multiply-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-multiply-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "SSoo22!!JJ$$QQbb33''\\\\xx00cc''aa}}NNIIqq}}GG''\\\\xx00bb''ttAA''yy77__2277==aauucc11__00eeKKvv==mm..iiiiGG##,,LLCC++eedd&&\\\\\\\\++SS22''\\\\nn''AAFF%%^^00DDff]]vvgg;;''\\\\xx00cc''))ddjj00''\\\\rr''\\\\\\\\!!##8866""""zz44jj,,{{??//::SS77))QQUU''\\\\nn''kk~~~~5500''\\\\tt''33")
  Fatal error: exception Failure("TBD")
  TIMEOUT
