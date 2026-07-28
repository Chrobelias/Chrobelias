  $ cat > test.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (<= (exp 2  x) x))
  > (assert (<= (exp 2  y) x))
  > (check-sat)
  > EOF
  $ export CHRO_DEBUG=simpl
  $ timeout 2 Chro -no-over -bound 3 --dsimpl --stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ (exp 2 y) (* (- 1) x)) 0)
             (<= (+ (exp 2 x) (* (- 1) x)) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (and
             (<= (+ (* (- 1) x) (exp 2 x)) 0)
             (<= (+ (* (- 1) x) (exp 2 y)) 0))
  [+simpl]
    fixed-point
  
  (assert (<= (+ (* (- 1) x) pow2(y) )  0) )
  (assert (<= (+ (* (- 1) x) pow2(x) )  0) )
  








  $ Chro -no-over -bound 3 --dsimpl --stop-after simpl smoke1.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ 80 (* 77 (exp 2 x1)) (* 42 (exp 2 x2)) (* 575 x2)
                 (* (- 575) x1)) 0)
             (<= (* (- 1) x2) 0)
             (<= (* (- 1) x1) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (and
             (<= (+ 80 (* 575 x2) (* (- 575) x1) (* 77 (exp 2 x1))
                 (* 42 (exp 2 x2))) 0)
             (<= (* (- 1) x1) 0)
             (<= (* (- 1) x2) 0))
  [+simpl]
    fixed-point
  
  sat (under int)
$ echo '77*2^2+42*2^2' | bc
  $ unset CHRO_DEBUG
  $ Chro -no-over -bound 3  smoke1.smt2 | sed 's/[[:space:]]*$//'
  sat (under int)

  $ cat > test.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (assert (not (distinct x1 (bwand x1 x1) )))
  > (assert (<= x1 x1))
  > (check-sat)
  > EOF
  $ Chro  --dsimpl --stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  (assert (= (+ (* (- 1) %0) x1 )  0) )
  (assert ((re.* (re.union (str.to.re "0") (re.union (str.to.re "2") (re.union (str.to.re "1") (str.to.re "7")))))))
  

  $ cat > test.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-const a String)
  > (declare-fun x1 () Int)
  > (assert (str.in_re a (str.to_re "ab")) )
  > (assert (<= x1 x1))
  > (check-sat)
  > EOF
  $ export CHRO_DEBUG=simpl
  $ Chro --dsimpl --stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    iter(1)= (and
             (<= (+ x1 (* (- 1) x1)) 0)
             (= a "ab"))
  [+simpl]
    Alphabet with extra char: 0 a b
  
  [+simpl]
    Something ready to substitute
        a -> "ab";
  
  [+simpl]
    iter(2)= (= a "ab")
  [+simpl]
    iter(3)= True
  [+simpl]
    fixed-point
  
  sat (presimpl str)
