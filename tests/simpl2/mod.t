  $ cat > 0.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (str.to.int x) 11111) 42))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over -bound 0  --dsimpl --stop-after pre-simpl 0.smt2 | sed 's/[[:space:]]*$//'
  Base now is 10
  
  iter(1)= (= (mod (str.to.int x) 11111) 42)
  Alphabet with extra char: 0
  
  fixed-point
  
  Arithmetization gives 3 asts...
  Arithmetized: (and
                  (= (mod x 11111) 42)
                  (<= 0 x)
                  (<= 0 x)
                  (<= 0 x))
  
  Basic simplifications:
  
  iter(1)= (and
             (= %r1 42)
             (<= 0 x)
             (<= 0 x)
             (<= 0 x)
             (= x (+ (* 11111 %q2) %r1))
             (<= (+ %r1 1) 11111)
             (<= 0 %r1))
  Alphabet with extra char: 0
  
  Something ready to substitute
        %r1 -> 42;
  
  iter(2)= (and
             (= x (+ %r1 (* 11111 %q2)))
             (<= 0 %r1)
             (<= 0 x)
             (<= %r1 11110))
  Something ready to substitute
        %r1 -> 42;
        x -> (+ 42 (* 11111 %q2));
  
  iter(3)= (<= 0 x)
  iter(4)= (<= (* (- 11111) %q2) 42)
  fixed-point
  

  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (mod (str.to.int x) 442271) 417677) 0))
  > (check-sat)
  > EOF
$ cat 1.smt2
  $ CHRO_DEBUG=1 Chro -no-over -bound 0  --dpresimpl --stop-after pre-simpl 1.smt2 | sed 's/[[:space:]]*$//'
  Base now is 10
  
  iter(1)= (= (mod (mod (str.to.int x) 442271) 417677) 0)
  Alphabet with extra char: 0
  
  fixed-point
  
  Arithmetization gives 3 asts...
  Arithmetized: (and
                  (= (mod (mod x 442271) 417677) 0)
                  (<= 0 x)
                  (<= 0 x)
                  (<= 0 x))
  
  Basic simplifications:
  
  iter(1)= (and
             (= %r3 0)
             (<= 0 x)
             (<= 0 x)
             (<= 0 x)
             (= %r1 (+ (* 417677 %q4) %r3))
             (<= (+ %r3 1) 417677)
             (<= 0 %r3)
             (= x (+ (* 442271 %q2) %r1))
             (<= (+ %r1 1) 442271)
             (<= 0 %r1))
  Alphabet with extra char: 0
  
  Something ready to substitute
        %r1 -> (+ %r3 (* 417677 %q4));
  
  iter(2)= (and
             (= %r3 0)
             (= x (+ %r1 (* 442271 %q2)))
             (<= 0 %r1)
             (<= 0 %r3)
             (<= 0 x)
             (<= %r1 442270)
             (<= %r3 417676))
  Something ready to substitute
        %r1 -> (+ %r3 (* 417677 %q4));
        %r3 -> 0;
  
  iter(3)= (and
             (= x (+ %r3 (* 417677 %q4) (* 442271 %q2)))
             (<= 0 %r3)
             (<= 0 x)
             (<= %r3 417676)
             (<= (+ %r3 (* 417677 %q4)) 442270)
             (<= (+ (* (- 417677) %q4) (* (- 1) %r3)) 0))
  Something ready to substitute
        %r1 -> (+ %r3 (* 417677 %q4));
        %r3 -> 0;
        x -> (+ (* 417677 %q4) (* 442271 %q2));
  
  iter(4)= (and
             (<= 0 x)
             (<= (* (- 417677) %q4) 0)
             (<= (* 417677 %q4) 442270))
  iter(5)= (and
             (<= (+ (* (- 442271) %q2) (* (- 417677) %q4)) 0)
             (<= (* (- 417677) %q4) 0)
             (<= (* 417677 %q4) 442270))
  fixed-point
  
  Lightweight run:
  (and
                     (<= (+ (* (- 442271) %q2) (* (- 417677) %q4)) 0)
                     (<= (* (- 417677) %q4) 0)
                     (<= (* 417677 %q4) 442270))
