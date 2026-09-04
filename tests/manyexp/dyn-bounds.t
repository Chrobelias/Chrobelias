Dynamic bres/bstates: the residue fan-out of the exponent elimination
draws from a global fuel budget (Config.residue_bound), and a deepening
ladder re-solves with a bigger budget whenever a truncated attempt ends
undecided -- so this three-exponent instance solves under default flags
(it used to need explicit -bres/-bstates to finish at all).

  $ timeout 30 Chro -q -no-model issue188.smt2
  sat (under int)
  no-model mode

The ladder's last rung is exact: this instance is unsat, the first
bounded rung cannot prove it, and the answer must still come out unsat,
not unknown.

  $ timeout 30 Chro -q -no-model ../../examples/double_exp.smt2
  unsat (nfa)
