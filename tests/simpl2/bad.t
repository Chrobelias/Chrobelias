$ export CHRO_DEBUG=1
  $ export OCAMLRUNPARAM='b=0'
  $ cat > TODO1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (* x1 x2) 52))
  > (check-sat)
  > EOF
  $ Chro -bound 0 -pre-simpl -dsimpl TODO1.smt2 | sed 's/[[:space:]]*$//'
  Error after simplification.
    Non linear arithmetic between
      0) x1
      1) x2

  Leftover formula:
  (<= (* x1 x2) 52)


$ export OCAMLRUNPARAM='b=0'
  $ cat > TODO1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (exp x1 2) 124))
  > (check-sat)
  > EOF
  $ Chro -bound 0 -pre-simpl -dsimpl TODO1.smt2 | sed 's/[[:space:]]*$//'
  Error after simplification.
    Non linear arithmetic between
      0) (exp x1 2)

  Leftover formula:
  (<= (exp x1 2) 124)

The single exponent is not bad
  $ cat > TODO3.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it57 () Int)
  > (declare-fun it383 () Int)
  > (assert (and
  >        (<= (+ (* (- 1) it383) (exp 2 it57)) 0)
  >        (<= (* (- 1) it57) (- 1))
  > ))
  > (check-sat)
  > EOF
  $ Chro -bound 0 -pre-simpl -dsimpl TODO3.smt2 | sed 's/[[:space:]]*$//'
  (assert (<= (* (- 1) it57)  -1) )
  (assert (exists (it383) (<= (+ (* (- 1) it383) pow2(it57) )  0) ) )

  (assert (<= (+ it57 (* (- 1) pow2(it57)) )  0) )

  sat

  $ Chro -pre-simpl -dsimpl ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_83.smt2 | sed 's/[[:space:]]*$//'