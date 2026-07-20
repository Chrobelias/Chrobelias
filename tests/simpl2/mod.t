  $ cat > 0.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (str.to.int x) 11111) 42))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over -bound 0  --dsimpl --stop-after pre-simpl 0.smt2 | sed 's/[[:space:]]*$//'

  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (mod (str.to.int x) 442271) 417677) 0))
  > (check-sat)
  > EOF
$ cat 1.smt2
  $ CHRO_DEBUG=1 Chro -no-over -bound 0  --dpresimpl --stop-after pre-simpl 1.smt2 | sed 's/[[:space:]]*$//'
  (and
    (<= (+ (- 442270) (* 417677 %q4)) 0)
    (<= (+ (* (- 417677) %q4) (* (- 442271) %q2)) 0)
    (<= (* (- 417677) %q4) 0))
