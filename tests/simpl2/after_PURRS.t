  $ export CHRO_DEBUG=1
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
  Basic simplifications:
  
  iter(1)= (= (+ (exp 2 n) (exp 2 n) (* (- 2) (exp 2 (+ (- 1) n)))
              (* (- 2) (exp 2 (+ (- 1) n)))) 0)
  Alphabet with extra char: 0
  
  iter(2)= True
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
  Basic simplifications:
  
  iter(1)= (= (+ (- 333) (* 2 (exp 2 (+ (- 1) n))) (* 2 (exp 2 (+ (- 1) n)))) 0)
  Alphabet with extra char: 0
  
  iter(2)= (= (+ (- 333) (* 2 (exp 2 n))) 0)
  fixed-point
  
  (= (+ (- 333) (* 2 (exp 2 n))) 0)
