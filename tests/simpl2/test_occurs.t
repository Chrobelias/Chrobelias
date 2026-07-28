  $ CHRO_DEBUG=simpl Chro --dsimpl --stop-after pre-simpl test3rec.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ (- 13) y x) 0)
             (= (+ (- 13) x y) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        x -> (+ 13 (- y));
  
  [+simpl]
    iter(2)= (= (+ (- 13) x y) 0)
  [+simpl]
    iter(3)= True
  [+simpl]
    fixed-point
  
  sat (presimpl int)

  $ CHRO_DEBUG=simpl Chro --dsimpl --stop-after pre-simpl test4rec.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ (- 10000) z x) 0)
             (= (+ (- 100) y z) 0)
             (= (+ (- 1) x y) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        x -> (+ 10000 (- z));
        y -> (+ 100 (- z));
  
  [+simpl]
    iter(3)= (= (+ 10099 (* 2 (* (- 1) z))) 0)
  [+simpl]
    iter(4)= (= (+ 10099 (* (- 2) z)) 0)
  [+simpl]
    fixed-point
  
  $ cat > xxx.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun y () Int)
  > (assert (= (+ y y) (- 9899)) )
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro -bound 1  --stop-after pre-simpl xxx.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (= (+ 9899 y y) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (= (+ 9899 (* 2 y)) 0)
  [+simpl]
    fixed-point
  

  $ cat > 4.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun a () Int)
  > (declare-fun v () Int)
  > (declare-fun x () Int)
  > (declare-fun z () Int)
  > (assert (and
  >           (= (+ it19 it23 (* (- 1) i4)) (- 1))
  >           (= (+ it21 it57 (* (- 1) it21) (* (- 1) it57)) 0)
  > ))
  > (check-sat)
  > ;(get-model)
  > EOF
  $ CHRO_DEBUG=simpl Chro -bound 1  --stop-after pre-simpl 4.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ 1 it19 it23 (* (- 1) i4)) 0)
             (= (+ it21 it57 (* (- 1) it21) (* (- 1) it57)) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        it19 -> (+ (- 1) i4 (- it23));
  
  [+simpl]
    iter(2)= (= (+ 1 (* (- 1) i4) it19 it23) 0)
  [+simpl]
    iter(3)= True
  [+simpl]
    fixed-point
  
  sat (presimpl int)

  $ cat > 5.smt2 <<-EOF
  > (set-logic ALL)
  > ;(declare-fun a () Int)
  > ;(declare-fun v () Int)
  > ;(declare-fun x () Int)
  > (declare-fun z () Int)
  > (assert
  >   (= (+ (* it198 (- 1)) it232 (* it19 (- 3))) 0) )
  > (assert
  >   (= (+ (* it199 (- 1)) it233) 0))
  > (assert
  >   (= (+ it19 (* it200 (- 1)) z) 0))
  > 
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro -bound 1  --stop-after pre-simpl 5.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ it19 (* (- 1) it200) z) 0)
             (= (+ (* (- 1) it199) it233) 0)
             (= (+ (* (- 1) it198) it232 (* (- 3) it19)) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        it19 -> (+ it200 (- z));
        it232 -> (+ (* 3 it19) it198);
        it233 -> it199;
  
  [+simpl]
    iter(2)= (and
             (= (+ it19 (* (- 1) it200) z) 0)
             (= (+ (* (- 1) it198) (* (- 3) it19) it232) 0)
             (= (+ (* (- 1) it199) it233) 0))
  [+simpl]
    iter(3)= (= (+ (* (- 1) it198) (* 3 it19) it198 (* it200 (- 3))
              (* (* (- 1) z) (- 3))) 0)
  [+simpl]
    iter(4)= (= (+ (* (- 3) it200) (* 3 z) (* it200 3) (* (* (- 1) z) 3)) 0)
  [+simpl]
    iter(5)= True
  [+simpl]
    fixed-point
  
  sat (presimpl int)
