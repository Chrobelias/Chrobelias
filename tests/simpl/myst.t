$ export CHRO_DEBUG=1
  $ Chro -bound 0 --no-pre-simpl --dsimpl --stop-after simpl ../../benchmarks/MysteriousProgram.jar-obl-12.smt2_9.smt2 | sed 's/[[:space:]]*$//'
  sat (under int)
