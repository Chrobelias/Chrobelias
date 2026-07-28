  $ cat > testO1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (<= (exp 2  x) x))
  > (check-sat)
  > EOF
$ export CHRO_DEBUG=1
  $ Chro -bound 0 --dsimpl --stop-after simpl testO1.smt2 | sed 's/[[:space:]]*$//'
  unsat (over)


  $ cat > testO2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (assert (not (distinct x1 (bwand x1 x1) )))
  > (assert (<= x1 x1))
  > (check-sat)
  > EOF
$ export CHRO_DEBUG=1
  $ export CHRO_TRACE_OPT=1
  $ Chro -bound 0 -no-over --dsimpl --stop-after simpl testO2.smt2 | sed 's/[[:space:]]*$//'
  (assert (= (+ (* (- 1) %0) x1 )  0) )
  (assert ((re.* (re.union (str.to.re "0") (re.union (str.to.re "2") (re.union (str.to.re "1") (str.to.re "7")))))))
  

  $ cat > test.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-const a String)
  > (declare-fun x1 () Int)
  > (assert (str.in_re a (str.to_re "ab")) )
  > (assert (<= x1 x1))
  > (check-sat)
  > (get-model)
  > EOF
$ export CHRO_DEBUG=1
  $ Chro --dsimpl --stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  sat (presimpl str)
  (
     (define-fun a () String
      "ab")
     (define-fun x1 () Int
      0)
  )
