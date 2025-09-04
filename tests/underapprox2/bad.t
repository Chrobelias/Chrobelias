$ export CHRO_DEBUG=1
  $ export OCAMLRUNPARAM='b=0'
  $ cat > t1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun u7 () Int)
  > (declare-fun z () Int)
  > (assert (and
  >           (= (+ (* (exp 2 u7) (exp 2 z)) (* 11 (exp 2 z))) y)
  >           (<= y 1000000)
  > ))
  > (check-sat)
  > EOF
>           (<= 10 z)
>           (<= (+ (- 11) (* (- 1) (exp 2 u7))) (- 1000))))
  $ Chro -bound 0 -pre-simpl -dpresimpl t1.smt2 -stop-after presimpl | sed 's/[[:space:]]*$//'
  (and
    (= (+ (* 11 (exp 2 z)) (exp 2 (+ u7 z))) y)
    (<= y 1000000))
