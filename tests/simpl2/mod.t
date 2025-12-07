  $ cat > 0.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (str.to.int x) 11111) 42))
  > (check-sat)
  > EOF
  $ Chro -no-over-approx -bound 0 -pre-simpl -dsimpl -stop-after pre-simpl 0.smt2 | sed 's/[[:space:]]*$//'

  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (mod (str.to.int x) 442271) 417677) 0))
  > (check-sat)
  > EOF
$ cat 1.smt2
  $ Chro -no-over-approx -bound 0 -pre-simpl -dpresimpl -stop-after pre-simpl 1.smt2 | sed 's/[[:space:]]*$//'
  (and
    (and
      (= r1 (* 417677 q4))
      (= (str.to.int x) (+ r1 (* 442271 q2)))
      (<= 0 r1)
      (<= r1 442270)))
