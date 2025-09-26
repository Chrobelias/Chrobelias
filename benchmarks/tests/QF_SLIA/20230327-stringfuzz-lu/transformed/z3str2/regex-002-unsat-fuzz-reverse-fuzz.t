regex-002-unsat-fuzz-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-fuzz-reverse-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "#(@a.J2GET4'\n'o'\r'HiNQt' '"Q*XB!<K+ZJ;YK;[u5C6kj' '_y*Wmn\\'hAh}1K'\n'{cl'\r''\n''\n'.}W:=#hrq|EP'\x0b'RC7NH-2i:og^(fr/m^BtmM'\n'zW*-cNmj&XzZ=:>Pj$}4xH%9CAxnF0@_")
  Fatal error: exception Failure("TBD")
  TIMEOUT
