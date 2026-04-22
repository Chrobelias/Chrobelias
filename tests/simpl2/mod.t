  $ cat > 0.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (str.to.int x) 11111) 42))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over -bound 0  --dsimpl --stop-after pre-simpl 0.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (= (+ (- 42) (mod (str.to.int x) 11111)) 0)
  Alphabet with extra char: #
  
  fixed-point
  
  Filtered unknown: (= (+ (- 42) (mod (str.to.int x) 11111)) 0)
  
  These atomic formulas are unsupported:
  
  After string approximations: (and
                                 (= (+ (- 42) (mod (str.to.int x) 11111)) 0)
                                 (or
                                   (<= (+ 1 (str.to.int x)) 0)
                                   (<= (* (- 1) (str.to.int x)) 0)))
  
  DPLL: Theory ast: (and
                      (= (+ (- 42) (mod (str.to.int x) 11111)) 0)
                      (or
                        (<= (+ 1 (str.to.int x)) 0)
                        (<= (* (- 1) (str.to.int x)) 0)))
  
  DPLL: Theory ast: (and
                      (= (+ (- 42) (mod (str.to.int x) 11111)) 0)
                      (or
                        (<= (+ 1 (str.to.int x)) 0)
                        (<= (* (- 1) (str.to.int x)) 0)))
  
  DPLL: into Z3 added: (and
                         (P $0)
                         (or
                           (P $1)
                           (not (P $1))))
  
  Basic simplifications:
  
  iter(1)= (and
             (= (+ (- 42) %r1) 0)
             (<= (* (- 1) (str.to.int x)) 0)
             (= (+ (str.to.int x) (* (- 11111) %q2) (* (- 1) %r1)) 0)
             (<= (+ (- 11110) %r1) 0)
             (<= (* (- 1) %r1) 0))
  Alphabet with extra char: #
  
  Something ready to substitute
        %r1 -> 42;
  
  iter(2)= (and
             (= (+ (- 42) %r1) 0)
             (= (+ (* (- 11111) %q2) (* (- 1) %r1) (str.to.int x)) 0)
             (<= (+ (- 11110) %r1) 0)
             (<= (* (- 1) %r1) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  iter(3)= (and
             (= (+ (- 42) (* (- 11111) %q2) (str.to.int x)) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  fixed-point
  
  Arithmetized: (and
                  (= (+ (- 42) (* (- 11111) %q2) x) 0)
                  (<= (* (- 1) x) 0))
  
  Basic simplifications:
  
  iter(1)= (and
             (= (+ (- 42) (* (- 11111) %q2) x) 0)
             (<= (* (- 1) x) 0))
  Alphabet with extra char: #
  
  Something ready to substitute
        %r1 -> 42;
        x -> (+ 42 (* 11111 %q2));
  
  iter(3)= (<= (+ (* 42 (- 1)) (* (* 11111 %q2) (- 1))) 0)
  iter(4)= (<= (+ (- 42) (* (- 11111) %q2)) 0)
  fixed-point
  

  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= (mod (mod (str.to.int x) 442271) 417677) 0))
  > (check-sat)
  > EOF
$ cat 1.smt2
  $ CHRO_DEBUG=1 Chro -no-over -bound 0  --dpresimpl --stop-after pre-simpl 1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (= (mod (mod (str.to.int x) 442271) 417677) 0)
  Alphabet with extra char: #
  
  fixed-point
  
  Filtered unknown: (= (mod (mod (str.to.int x) 442271) 417677) 0)
  
  These atomic formulas are unsupported:
  
  After string approximations: (and
                                 (= (mod (mod (str.to.int x) 442271) 417677) 0)
                                 (or
                                   (<= (+ 1 (str.to.int x)) 0)
                                   (<= (* (- 1) (str.to.int x)) 0)))
  
  DPLL: Theory ast: (and
                      (= (mod (mod (str.to.int x) 442271) 417677) 0)
                      (or
                        (<= (+ 1 (str.to.int x)) 0)
                        (<= (* (- 1) (str.to.int x)) 0)))
  
  DPLL: Theory ast: (and
                      (= (mod (mod (str.to.int x) 442271) 417677) 0)
                      (or
                        (<= (+ 1 (str.to.int x)) 0)
                        (<= (* (- 1) (str.to.int x)) 0)))
  
  DPLL: into Z3 added: (and
                         (P $0)
                         (or
                           (P $1)
                           (not (P $1))))
  
  Basic simplifications:
  
  iter(1)= (and
             (= %r3 0)
             (<= (* (- 1) (str.to.int x)) 0)
             (= (+ %r1 (* (- 417677) %q4) (* (- 1) %r3)) 0)
             (<= (+ (- 417676) %r3) 0)
             (<= (* (- 1) %r3) 0)
             (= (+ (str.to.int x) (* (- 442271) %q2) (* (- 1) %r1)) 0)
             (<= (+ (- 442270) %r1) 0)
             (<= (* (- 1) %r1) 0))
  Alphabet with extra char: #
  
  Something ready to substitute
        %r3 -> 0;
  
  iter(2)= (and
             (= %r3 0)
             (= (+ (* (- 442271) %q2) (* (- 1) %r1) (str.to.int x)) 0)
             (= (+ (* (- 417677) %q4) %r1 (* (- 1) %r3)) 0)
             (<= (+ (- 442270) %r1) 0)
             (<= (+ (- 417676) %r3) 0)
             (<= (* (- 1) %r1) 0)
             (<= (* (- 1) %r3) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  Something ready to substitute
        %r1 -> (+ (* (- 442271) %q2) (str.to.int x));
        %r3 -> 0;
  
  iter(3)= (and
             (= (+ (* (- 442271) %q2) (* (- 1) %r1) (str.to.int x)) 0)
             (= (+ (* (- 417677) %q4) %r1) 0)
             (<= (+ (- 442270) %r1) 0)
             (<= (* (- 1) %r1) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  iter(4)= (and
             (= (+ (* (- 442271) %q2) (* (* (- 442271) %q2) (- 1))
                (* (str.to.int x) (- 1)) (str.to.int x)) 0)
             (= (+ (* (- 417677) %q4) (* (- 442271) %q2) (str.to.int x)) 0)
             (<= (+ (- 442270) (* (- 442271) %q2) (str.to.int x)) 0)
             (<= (+ (* (* (- 442271) %q2) (- 1)) (* (str.to.int x) (- 1))) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  iter(5)= (and
             (= (+ (* (- 417677) %q4) (* (- 442271) %q2) (str.to.int x)) 0)
             (<= (+ (- 442270) (* (- 442271) %q2) (str.to.int x)) 0)
             (<= (+ (* 442271 %q2) (* (- 1) (str.to.int x))) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  fixed-point
  
  Arithmetized: (and
                  (= (+ (* (- 417677) %q4) (* (- 442271) %q2) x) 0)
                  (<= (+ (- 442270) (* (- 442271) %q2) x) 0)
                  (<= (+ (* 442271 %q2) (* (- 1) x)) 0)
                  (<= (* (- 1) x) 0))
  
  Basic simplifications:
  
  iter(1)= (and
             (= (+ (* (- 417677) %q4) (* (- 442271) %q2) x) 0)
             (<= (+ (- 442270) (* (- 442271) %q2) x) 0)
             (<= (+ (* 442271 %q2) (* (- 1) x)) 0)
             (<= (* (- 1) x) 0))
  Alphabet with extra char: #
  
  Something ready to substitute
        %r1 -> (+ (* (- 442271) %q2) (str.to.int x));
        %r3 -> 0;
        x -> (+ (* 417677 %q4) (* 442271 %q2));
  
  iter(3)= (and
             (<= (+ (- 442270) (* 417677 %q4)) 0)
             (<= (+ (* 442271 %q2) (* (* 417677 %q4) (- 1))
                 (* (* 442271 %q2) (- 1))) 0)
             (<= (+ (* (* 417677 %q4) (- 1)) (* (* 442271 %q2) (- 1))) 0))
  iter(4)= (and
             (<= (+ (- 442270) (* 417677 %q4)) 0)
             (<= (+ (* (- 417677) %q4) (* (- 442271) %q2)) 0)
             (<= (* (- 1) %q4) 0))
  fixed-point
  
  (and
    (<= (+ (- 442270) (* 417677 %q4)) 0)
    (<= (+ (* (- 417677) %q4) (* (- 442271) %q2)) 0)
    (<= (* (- 1) %q4) 0))
