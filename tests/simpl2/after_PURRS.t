  $ export CHRO_DEBUG=simpl
  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun n () Int)
  > (assert (=
  >        (+ (exp 2 n) (exp 2 n))
  >        (* 2
  >              (+ (exp 2 (+ n (- 1)))
  >                 (exp 2 (+ n (- 1)))))
  > ))
  > (check-sat)
  > EOF
  $ Chro -bound -1 --dpresimpl --stop-after pre-simpl 1.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (= (+ (exp 2 n) (exp 2 n) (* (- 2) (exp 2 (+ (- 1) n)))
              (* (- 2) (exp 2 (+ (- 1) n)))) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= True
  [+simpl]
    fixed-point
  
  sat (presimpl int)
  $ cat > 2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun n () Int)
  > (assert (=
  >           (* 2  (+ (exp 2 (- n 1))
  >                    (exp 2 (- n 1))))
  >         333
  > 
  > ))
  > (check-sat)
  > EOF
  $ Chro -bound -1 --dpresimpl --stop-after pre-simpl 2.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (= (+ (- 333) (* 2 (exp 2 (+ (- 1) n))) (* 2 (exp 2 (+ (- 1) n)))) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (= (+ (- 333) (* 2 (exp 2 n))) 0)
  [+simpl]
    fixed-point
  
  (= (+ (- 333) (* 2 (exp 2 n))) 0)
