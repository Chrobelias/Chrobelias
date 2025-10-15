  $ cat > 0.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (str.to.int x) 11111) 42))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over-approx -bound 0 -pre-simpl -dsimpl -stop-after pre-simpl 0.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (and
               (= r1 42))
             (= (str.to.int x) (+ (* 11111 q2) r1))
             (<= (+ r1 1) 11111)
             (<= 0 r1))
  Something ready to substitute:  r1 -> 42;
  iter(2)= (and
             (= r1 42)
             (= (str.to.int x) (+ r1 (* 11111 q2)))
             (<= r1 11110)
             (<= 0 r1))
  iter(3)= (and
             (= (str.to.int x) (+ 42 (* 11111 q2))))
  iter(4)= (= (str.to.int x) (+ 42 (* 11111 q2)))

  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (mod (str.to.int x) 442271) 417677) 0))
  > (check-sat)
  > EOF
$ cat 1.smt2
  $ CHRO_DEBUG=1 Chro -no-over-approx -bound 0 -pre-simpl -dpresimpl -stop-after pre-simpl 1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (and
               (= r3 0))
             (= r1 (+ (* 417677 q4) r3))
             (<= (+ r3 1) 417677)
             (<= 0 r3)
             (= (str.to.int x) (+ (* 442271 q2) r1))
             (<= (+ r1 1) 442271)
             (<= 0 r1))
  Something ready to substitute:  r3 -> 0;
  iter(2)= (and
             (= r3 0)
             (= (str.to.int x) (+ r1 (* 442271 q2)))
             (<= r1 442270)
             (<= r3 417676)
             (<= 0 r1)
             (<= 0 r3)
             (= r1 (+ r3 (* 417677 q4))))
  iter(3)= (and
             (= r1 (* 417677 q4))
             (= (str.to.int x) (+ r1 (* 442271 q2)))
             (<= r1 442270)
             (<= 0 r1))
  (and
    (= r1 (* 417677 q4))
    (= (str.to.int x) (+ r1 (* 442271 q2)))
    (<= r1 442270)
    (<= 0 r1))
