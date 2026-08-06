  $ cat > 0.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (str.to.int x) 11111) 42))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro -no-over -bound 0  --dsimpl --stop-after pre-simpl 0.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    iter(1)= (= (+ (- 42) (mod (str.to.int x) 11111)) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (= (+ (- 42) (mod (str.to.int x) 11111)) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (= (+ (- 42) (mod @stoix 11111)) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ (- 42) %r1) 0)
             (<= (* (- 1) (str.to.int x)) 0)
             (= (+ (str.to.int x) (* (- 11111) %q2) (* (- 1) %r1)) 0)
             (<= (+ (- 11110) %r1) 0)
             (<= (* (- 1) %r1) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %r1 -> 42;
  
  [+simpl]
    iter(2)= (and
             (= (+ (- 42) %r1) 0)
             (= (+ (* (- 11111) %q2) (* (- 1) %r1) (str.to.int x)) 0)
             (<= (+ (- 11110) %r1) 0)
             (<= (* (- 1) %r1) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  [+simpl]
    iter(3)= (and
             (= (+ (- 42) (* (- 11111) %q2) (str.to.int x)) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (and
             (= (+ (- 42) (* (- 11111) %q2) (str.to.int x)) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ (- 42) (* (- 11111) %q2) x) 0)
             (<= (* (- 1) x) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %r1 -> 42;
        x -> (+ 42 (* 11111 %q2));
  
  [+simpl]
    iter(3)= (<= (+ (* 42 (- 1)) (* (* 11111 %q2) (- 1))) 0)
  [+simpl]
    iter(4)= (<= (+ (- 42) (* (- 11111) %q2)) 0)
  [+simpl]
    fixed-point
  

  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (mod (str.to.int x) 442271) 417677) 0))
  > (check-sat)
  > EOF
$ cat 1.smt2
  $ CHRO_DEBUG=simpl Chro -no-over -bound 0  --dpresimpl --stop-after pre-simpl 1.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    iter(1)= (= (mod (mod (str.to.int x) 442271) 417677) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (= (mod (mod (str.to.int x) 442271) 417677) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (= (mod (mod @stoix 442271) 417677) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= %r3 0)
             (<= (* (- 1) (str.to.int x)) 0)
             (= (+ %r1 (* (- 417677) %q4) (* (- 1) %r3)) 0)
             (<= (+ (- 417676) %r3) 0)
             (<= (* (- 1) %r3) 0)
             (= (+ (str.to.int x) (* (- 442271) %q2) (* (- 1) %r1)) 0)
             (<= (+ (- 442270) %r1) 0)
             (<= (* (- 1) %r1) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %r3 -> 0;
  
  [+simpl]
    iter(2)= (and
             (= %r3 0)
             (= (+ (* (- 442271) %q2) (* (- 1) %r1) (str.to.int x)) 0)
             (= (+ (* (- 417677) %q4) %r1 (* (- 1) %r3)) 0)
             (<= (+ (- 442270) %r1) 0)
             (<= (+ (- 417676) %r3) 0)
             (<= (* (- 1) %r1) 0)
             (<= (* (- 1) %r3) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  [+simpl]
    Something ready to substitute
        %r1 -> (* 417677 %q4);
        %r3 -> 0;
  
  [+simpl]
    iter(3)= (and
             (= (+ (* (- 442271) %q2) (* (- 1) %r1) (str.to.int x)) 0)
             (= (+ (* (- 417677) %q4) %r1) 0)
             (<= (+ (- 442270) %r1) 0)
             (<= (* (- 1) %r1) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  [+simpl]
    iter(4)= (and
             (= (+ (* (- 442271) %q2) (* (- 417677) %q4) (str.to.int x)) 0)
             (<= (+ (- 442270) (* 417677 %q4)) 0)
             (<= (* (- 417677) %q4) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (and
             (= (+ (* (- 442271) %q2) (* (- 417677) %q4) (str.to.int x)) 0)
             (<= (+ (- 442270) (* 417677 %q4)) 0)
             (<= (* (- 417677) %q4) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ (* (- 442271) %q2) (* (- 417677) %q4) x) 0)
             (<= (* (- 1) x) 0)
             (<= (+ (- 442270) (* 417677 %q4)) 0)
             (<= (* (- 417677) %q4) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %r1 -> (* 417677 %q4);
        %r3 -> 0;
        x -> (+ (* 442271 %q2) (* 417677 %q4));
  
  [+simpl]
    iter(2)= (and
             (= (+ (* (- 442271) %q2) (* (- 417677) %q4) x) 0)
             (<= (+ (- 442270) (* 417677 %q4)) 0)
             (<= (* (- 417677) %q4) 0)
             (<= (* (- 1) x) 0))
  [+simpl]
    iter(3)= (and
             (<= (+ (- 442270) (* 417677 %q4)) 0)
             (<= (+ (* (* 442271 %q2) (- 1)) (* (* 417677 %q4) (- 1))) 0)
             (<= (* (- 417677) %q4) 0))
  [+simpl]
    iter(4)= (and
             (<= (+ (- 442270) (* 417677 %q4)) 0)
             (<= (+ (* (- 442271) %q2) (* (- 417677) %q4)) 0)
             (<= (* (- 417677) %q4) 0))
  [+simpl]
    fixed-point
  
  (and
    (<= (+ (- 442270) (* 417677 %q4)) 0)
    (<= (+ (* (- 442271) %q2) (* (- 417677) %q4)) 0)
    (<= (* (- 417677) %q4) 0))
