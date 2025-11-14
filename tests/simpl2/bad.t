$ export CHRO_DEBUG=1
  $ export OCAMLRUNPARAM='b=0'
  $ cat > TODO1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (* x1 x2) 52))
  > (check-sat)
  > EOF
  $ Chro -bound 0 --pre-simpl --dsimpl TODO1.smt2 | sed 's/[[:space:]]*$//'
  sat (under I)


$ export OCAMLRUNPARAM='b=0'
  $ cat > TODO1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (exp x1 2) 124))
  > (check-sat)
  > EOF
  $ Chro -bound 0 --pre-simpl --dsimpl TODO1.smt2 | sed 's/[[:space:]]*$//'
  sat (under I)



  $ Chro --pre-simpl --dsimpl ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_83.smt2 | sed 's/[[:space:]]*$//'
  unsat (presimpl)

  $ cat > TODO1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (and
  >    (<= (* x1 x2) 52)
  >    (= 1 2)
  > ))
  > (check-sat)
  > EOF
  $ Chro -bound 0 --pre-simpl --dsimpl TODO1.smt2 | sed 's/[[:space:]]*$//'
  unsat (presimpl)


  $ cat > UnderDoesntHelp1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (and
  >        (<= (* z y) 0)
  >        (<= (exp 2 x) (- 1))
  > ))
  > (check-sat)
  > EOF
$ export CHRO_DEBUG=1
  $ Chro -bound 2 --pre-simpl --dsimpl UnderDoesntHelp1.smt2 | sed 's/[[:space:]]*$//'
  unknown (nfa; not implemented: Lib__Me.Symantics.mul. l = Symbol (y,_), r = Symbol (z,_))
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
  $ Chro -bound 2 --pre-simpl --dsimpl TODO3.smt2 | sed 's/[[:space:]]*$//'
  sat (under I)


