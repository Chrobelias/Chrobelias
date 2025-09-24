regex-002-unsat-multiply-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-multiply-multiply-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "Nr$fyZQ9!=M@0`f{-~s|cA|O-)&2'\t'g.50MXPEQ*<MZh[pa^Fs2Mw'\n'm0*Z1.g*7aanT\\]4'\x0b'e8@<E'\n'9a5G$@'\t''\n'b)fImHZ*'\t''\x0b'8uv'\n'^b[eQF/$2t6Ma?7][Sr-'\t'Oj\\-R' 'C6jx#'Ap'\x0c'' ''nxw]kq'\x0b'N8?SucbnOGe$jDq9g4CS}'\x0b'wao|p]pK' 'PZp'\x0b'=R'\\g[aK[6lg4[8SeB'\r'AD|\\*'\x0b'3\\0PCOx<Fg_Dh0u+3LPyo9'8~Z:f9z~bDc&d'M.'\x0c'IZk772LCDBg}9A&yE98+qaoaa*vA'\r'@H'\x0b'L'\r'={bta")
  Fatal error: exception Failure("TBD")
  TIMEOUT
