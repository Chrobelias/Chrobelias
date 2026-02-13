  $ cat > 0.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (str.to.int x) 11111) 42))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over -bound 0  --dsimpl --stop-after pre-simpl 0.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (= %r1 42)
             (= (str.to.int x) (+ (* 11111 %q2) %r1))
             (<= (+ %r1 1) 11111)
             (<= 0 %r1))
  Something ready to substitute
        %r1 -> 42;
  
  iter(2)= (and
             (= (str.to.int x) (+ %r1 (* 11111 %q2)))
             (<= 0 %r1)
             (<= %r1 11110))
  iter(3)= (= (str.to.int x) (+ 42 (* 11111 %q2)))
  fixed-point
  
  Bound for underapproximation: 13
  

  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (mod (str.to.int x) 442271) 417677) 0))
  > (check-sat)
  > EOF
$ cat 1.smt2
  $ CHRO_DEBUG=1 Chro -no-over -bound 0  --dpresimpl --stop-after pre-simpl 1.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (= %r3 0)
             (= %r1 (+ (* 417677 %q4) %r3))
             (<= (+ %r3 1) 417677)
             (<= 0 %r3)
             (= (str.to.int x) (+ (* 442271 %q2) %r1))
             (<= (+ %r1 1) 442271)
             (<= 0 %r1))
  Something ready to substitute
        %r1 -> (+ %r3 (* 417677 %q4));
  
  iter(2)= (and
             (= %r3 0)
             (= (str.to.int x) (+ %r1 (* 442271 %q2)))
             (<= 0 %r1)
             (<= 0 %r3)
             (<= %r1 442270)
             (<= %r3 417676))
  Something ready to substitute
        %r1 -> (+ %r3 (* 417677 %q4));
        %r3 -> 0;
  
  iter(3)= (and
             (= (str.to.int x) (+ %r3 (* 417677 %q4) (* 442271 %q2)))
             (<= 0 %r3)
             (<= %r3 417676)
             (<= (+ %r3 (* 417677 %q4)) 442270)
             (<= (+ (* (- 417677) %q4) (* (- 1) %r3)) 0))
  iter(4)= (and
             (= (str.to.int x) (+ (* 417677 %q4) (* 442271 %q2)))
             (<= %q4 1)
             (<= (* (- 1) %q4) 0))
  fixed-point
  
  Bound for underapproximation: 19
  
  (and
    (= (str.to.int x) (+ (* 417677 %q4) (* 442271 %q2)))
    (<= %q4 1)
    (<= (* (- 1) %q4) 0))
