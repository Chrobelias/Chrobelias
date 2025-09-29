
  $ export CHRO_HACK_ORDERINGS=1
  $ timeout 2 Chro -flat 1 examples/order1.smt2 | sed 's/[[:space:]]*$//'
  Ir = (assert (exists (%1 b y)
               (and
                 (= %1 (str.len b))(= y (str.to.int b))(= (+ (* (- 1) %0) u )
                                                        0)
                 (= (+ (* (- 1) y) (* (- 1) pow2(eee15)) pow2(eee16)
                    (* (- 5) pow2(u)) )
                  -1)
                 (= (+ (* (- 1) %1) pow2(%0) )  1)
                 (<= (+ (* (- 1) eee15) eee16 )  0)
                 )
       )
  ph = (= %1 (str.len b)),
   tag = 2
  ph = (= y (str.to.int b)),
   tag = 4
  ph = ((-1%0 + 1u = 0)),
   tag = 7
  ph = ((-1y + -1pow2(eee15) + 1pow2(eee16) + -5pow2(u) = -1)),
   tag = 7
  ph = ((-1%1 + 1pow2(%0) = 1)),
   tag = 7
  ph = ((-1eee15 + 1eee16 <= 0)),
   tag = 7
  Lib__Orderings.prepare_order_check.f 43
    coeff1 = -1, coeff2 = 1
  ORDER: eee16<eee15
  There are 336 orderings
  There are 168 orderings
  0: pow2(%0) %0 pow2(eee16) eee16 pow2(eee15) eee15 pow2(u) u
  1: pow2(%0) %0 pow2(eee16) eee16 pow2(eee15) pow2(u) eee15 u
  2: pow2(%0) %0 pow2(eee16) eee16 pow2(u) u pow2(eee15) eee15
  3: pow2(%0) %0 pow2(eee16) eee16 pow2(u) pow2(eee15) u eee15
  4: pow2(%0) %0 pow2(eee16) pow2(eee15) eee16 eee15 pow2(u) u
  5: pow2(%0) %0 pow2(eee16) pow2(eee15) eee16 pow2(u) eee15 u
  6: pow2(%0) %0 pow2(eee16) pow2(eee15) pow2(u) eee16 eee15 u
  7: pow2(%0) %0 pow2(eee16) pow2(u) eee16 u pow2(eee15) eee15
  8: pow2(%0) %0 pow2(eee16) pow2(u) eee16 pow2(eee15) u eee15
  9: pow2(%0) %0 pow2(eee16) pow2(u) pow2(eee15) eee16 u eee15
  timeout
