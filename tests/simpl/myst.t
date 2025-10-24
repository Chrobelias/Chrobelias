$ export CHRO_DEBUG=1
  $ Chro -bound 0 -no-pre-simpl -dsimpl -stop-after simpl ../../benchmarks/MysteriousProgram.jar-obl-12.smt2_9.smt2 | sed 's/[[:space:]]*$//'
  unknown (nfa; unimplemented (= (+ (+ 0 it197)
                   (* (exp 2 it192) (+ 0 it177) (+ 0 (* (- 1) 1)))) (+ 0 0)))
