Dynamic bres/bstates: the residue fan-out of the exponent elimination
draws from a global budget (Config.residue_bound), and a deepening
ladder re-solves with a bigger budget whenever a truncated attempt ends
undecided -- so this three-exponent instance solves under default flags
(it used to need explicit bounds to finish at all).

  $ timeout 30 Chro -q -no-model issue188.smt2
  sat (under int)
  no-model mode

The ladder's last rung is exact: this instance is unsat, the first
bounded rung cannot prove it, and the answer must still come out unsat,
not unknown.

  $ timeout 30 Chro -q -no-model ../../examples/double_exp.smt2
  unsat (nfa)

A truncated refutation is not trusted. CHRO_DYN_ATTEMPTS=1 allows no retry,
so double_exp (unsat) comes out unknown rather than a wrong unsat.

  $ CHRO_DYN_ATTEMPTS=1 Chro -q -no-model ../../examples/double_exp.smt2
  (warning:  check annotation that says 'unsat')
  unknown (nfa)

-no-dyn runs the elimination unbounded and stays exact.

  $ Chro -q -no-model -no-dyn ../../examples/double_exp.smt2
  unsat (nfa)
