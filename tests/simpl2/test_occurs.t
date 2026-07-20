  $ CHRO_DEBUG=1 Chro --dsimpl --stop-after pre-simpl test3rec.smt2 | sed 's/[[:space:]]*$//'
  sat (presimpl int)

  $ CHRO_DEBUG=1 Chro --dsimpl --stop-after pre-simpl test4rec.smt2 | sed 's/[[:space:]]*$//'
  $ cat > xxx.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun y () Int)
  > (assert (= (+ y y) (- 9899)) )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -bound 1  --stop-after pre-simpl xxx.smt2 | sed 's/[[:space:]]*$//'

  $ cat > 4.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun a () Int)
  > (declare-fun v () Int)
  > (declare-fun x () Int)
  > (declare-fun z () Int)
  > (assert (and
  >           (= (+ it19 it23 (* (- 1) i4)) (- 1))
  >           (= (+ it21 it57 (* (- 1) it21) (* (- 1) it57)) 0)
  > ))
  > (check-sat)
  > ;(get-model)
  > EOF
  $ CHRO_DEBUG=1 Chro -bound 1  --stop-after pre-simpl 4.smt2 | sed 's/[[:space:]]*$//'
  sat (presimpl int)

  $ cat > 5.smt2 <<-EOF
  > (set-logic ALL)
  > ;(declare-fun a () Int)
  > ;(declare-fun v () Int)
  > ;(declare-fun x () Int)
  > (declare-fun z () Int)
  > (assert
  >   (= (+ (* it198 (- 1)) it232 (* it19 (- 3))) 0) )
  > (assert
  >   (= (+ (* it199 (- 1)) it233) 0))
  > (assert
  >   (= (+ it19 (* it200 (- 1)) z) 0))
  > 
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -bound 1  --stop-after pre-simpl 5.smt2 | sed 's/[[:space:]]*$//'
  sat (presimpl int)
