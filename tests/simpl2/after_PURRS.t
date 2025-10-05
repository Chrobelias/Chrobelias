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
  $ Chro -pre-simpl -bound -1 -dpresimpl -stop-after pre-simpl 1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (+ (exp 2 n) (exp 2 n)) (* 2
                                        (+ (exp 2 (+ n (* (- 1) 1)))
                                        (exp 2 (+ n (* (- 1) 1)))))))
  iter(2)= (= (+ (* (- 2) (exp 2 (+ n))) (exp 2 n) (exp 2 n)) 0)
  iter(3)= (= (+ (* (- 1) (exp 2 n)) (exp 2 n)) 0)
  iter(4)= True
  sat ; presimpl
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
  $ Chro -pre-simpl -bound -1 -dpresimpl -stop-after pre-simpl 2.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= (* 2 (+ (exp 2 (+ n (* (- 1) 1))) (exp 2 (+ n (* (- 1) 1))))) 333))
  iter(2)= (= (+ (* (exp 2 (+ (- 1) n)) 2) (* (exp 2 (+ (- 1) n)) 2)) 333)
  iter(3)= (= (+ (exp 2 n) (exp 2 n)) 333)
  (= (+ (exp 2 n) (exp 2 n)) 333)
