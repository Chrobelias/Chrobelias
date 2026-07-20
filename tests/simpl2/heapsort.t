  $ export CHRO_DEBUG=1
  $ Chro -bound -1 --dsimpl --stop-after simpl ../../benchmarks/heapsort.c.koat_2.smt2 | sed 's/[[:space:]]*$//'
  (assert (<= (+ (* (- 1) i10) (* 2 pow2(it147)) )  1) )
  (assert (<= (+ (* (- 1) i10) pow2(it147) )  1) )
  (assert (<= (* (- 1) it4)  -1) )
  (assert (<= it2  0) )
  (assert (<= (* (- 1) it147)  -1) )
  (assert (<= (* (- 1) i10)  -3) )
  
