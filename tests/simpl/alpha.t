This test should be removed
  $ cat > testA.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it147 () Int)
  > (assert (exists ((it6 Int) (it160 Int))
  >           (and
  >             (exists ((it159 Int)) (= (+ it159 (* (- 2) (exp 2 it147)) )  -1))
  >             (exists ((it158 Int)) (= (+ it158 (* (- 1) (exp 2 it147)) )  -1))
  >             (exists ((it157 Int)) (= (+ it157 (* (- 2) (exp 2 it147)) )  -1))
  >             (exists ((it155 Int)) (= (+ it155 (* (- 2) (exp 2 it147)) )  -1))
  >             (exists ((it154 Int)) (= (+ it154 (* (- 2) (exp 2 it147)) )  -2))
  >             (exists ((it152 Int)) (= (+ (* (- 14) it147) it152 (* (- 1) it6) )  0))
  >             (<= (+ (* (- 1) it160) (exp 2 it147) )  1)
  >             (<= (+ (* (- 1) it160) (* 2 (exp 2 it147)) )  1)
  >             (<= (* (- 1) it160)  -3)
  >             (exists ((it4 Int)) (<= (* (- 1) it4)  -1))
  >             (exists ((it2 Int)) (<= it2  0))
  >             (<= (* (- 1) it147)  -1)
  >             (exists ((i2 Int)) (= (+ (* (- 1) i2) it6 )  12))
  >           )
  > ))
  > (check-sat)
  > EOF
$ export OCAMLRUNPARAM='b=0'
$ export CHRO_DEBUG=1

  $ unset CHRO_EIA=
  $ timeout 2 Chro -dsimpl -stop-after simpl testA.smt2 | sed 's/[[:space:]]*$//'
  (assert (exists (-1)
          (and
            (<= (+ (* (- 1) -1) (* (- 1) it147) )  0)
            (exists (-2 it154)
            (= (+ (* (- 1) -2) it154 (* (- 2) pow2(it147)) )  0) )
            (exists (it4) (<= (+ (* (- 1) -1) (* (- 1) it4) )  0) )
            (exists (it2) (<= it2  0) )
            (exists (it159)
            (= (+ (* (- 1) -1) it159 (* (- 2) pow2(it147)) )  0) )
            (exists (it158)
            (= (+ (* (- 1) -1) it158 (* (- 1) pow2(it147)) )  0) )
            (exists (it160)
            (and
              (<= (+ (* (- 1) it160) pow2(it147) )  1)
              (<= (+ (* (- 1) it160) (* 2 pow2(it147)) )  1)
              (exists (-3) (<= (+ (* (- 1) -3) (* (- 1) it160) )  0) )
              )
            (exists (it6)
            (and
              (exists (it152) (= (+ (* (- 14) it147) it152 (* (- 1) it6) )  0)
              )
              (exists (i2) (= (+ (* (- 1) i2) it6 )  12) )
              )
            )
  )
This is TODO. It is not related to alpha-equivalence simplifications.
