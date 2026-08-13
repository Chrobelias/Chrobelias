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
    Alphabet with extra char:   0 1 2 3 4 5 6 7 8 9
  
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (= (+ (- 42) (mod (str.to.int x) 11111)) 0)
  [+simpl]
    Alphabet with extra char:   0 1 2 3 4 5 6 7 8 9
  
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
             (= (mod (+ (str.to.int x) (* (- 1) %r1)) 11111) 0)
             (<= (+ (- 11110) %r1) 0)
             (<= (* (- 1) %r1) 0))
  [+simpl]
    Alphabet with extra char:   0 1 2 3 4 5 6 7 8 9
  
  [+simpl]
    Something ready to substitute
        %r1 -> 42;
  
  [+simpl]
    iter(2)= (and
             (= (+ (- 42) %r1) 0)
             (= (mod (+ (* (- 1) %r1) (str.to.int x)) 11111) 0)
             (<= (+ (- 11110) %r1) 0)
             (<= (* (- 1) %r1) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  [+simpl]
    iter(3)= (and
             (= (mod (+ (- 42) (str.to.int x)) 11111) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (and
             (= (mod (+ (- 42) (str.to.int x)) 11111) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  [+simpl]
    Alphabet with extra char:   0 1 2 3 4 5 6 7 8 9
  
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (mod (+ (- 42) x) 11111) 0)
             (<= (* (- 1) x) 0))
  [+simpl]
    Alphabet with extra char: 0
  
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
    Alphabet with extra char:   0 1 2 3 4 5 6 7 8 9
  
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (= (mod (mod (str.to.int x) 442271) 417677) 0)
  [+simpl]
    Alphabet with extra char:   0 1 2 3 4 5 6 7 8 9
  
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
             (= %r2 0)
             (<= (* (- 1) (str.to.int x)) 0)
             (= (mod (+ %r1 (* (- 1) %r2)) 417677) 0)
             (<= (+ (- 417676) %r2) 0)
             (<= (* (- 1) %r2) 0)
             (= (mod (+ (str.to.int x) (* (- 1) %r1)) 442271) 0)
             (<= (+ (- 442270) %r1) 0)
             (<= (* (- 1) %r1) 0))
  [+simpl]
    Alphabet with extra char:   0 1 2 3 4 5 6 7 8 9
  
  [+simpl]
    Something ready to substitute
        %r2 -> 0;
  
  [+simpl]
    iter(2)= (and
             (= %r2 0)
             (= (mod (+ %r1 (* (- 1) %r2)) 417677) 0)
             (= (mod (+ (* (- 1) %r1) (str.to.int x)) 442271) 0)
             (<= (+ (- 442270) %r1) 0)
             (<= (+ (- 417676) %r2) 0)
             (<= (* (- 1) %r1) 0)
             (<= (* (- 1) %r2) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  [+simpl]
    iter(3)= (and
             (= (mod %r1 417677) 0)
             (= (mod (+ (* (- 1) %r1) (str.to.int x)) 442271) 0)
             (<= (+ (- 442270) %r1) 0)
             (<= (* (- 1) %r1) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (and
             (= (mod %r1 417677) 0)
             (= (mod (+ (* (- 1) %r1) (str.to.int x)) 442271) 0)
             (<= (+ (- 442270) %r1) 0)
             (<= (* (- 1) %r1) 0)
             (<= (* (- 1) (str.to.int x)) 0))
  [+simpl]
    Alphabet with extra char:   0 1 2 3 4 5 6 7 8 9
  
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (mod %r1 417677) 0)
             (= (mod (+ (* (- 1) %r1) x) 442271) 0)
             (<= (* (- 1) x) 0)
             (<= (+ (- 442270) %r1) 0)
             (<= (* (- 1) %r1) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (and
             (= (mod %r1 417677) 0)
             (= (mod (+ (* (- 1) %r1) x) 442271) 0)
             (<= (+ (- 442270) %r1) 0)
             (<= (* (- 1) %r1) 0)
             (<= (* (- 1) x) 0))
  [+simpl]
    fixed-point
  
  (and
    (= (mod %r1 417677) 0)
    (= (mod (+ (* (- 1) %r1) x) 442271) 0)
    (<= (+ (- 442270) %r1) 0)
    (<= (* (- 1) %r1) 0)
    (<= (* (- 1) x) 0))
