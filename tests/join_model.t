  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (+ 5 y (* (- 7) u)) 0))
  > (assert (= (+ 2 y (* (- 3) x)) 0))
  > (assert (>= z 100))
  > (check-sat)
  > (get-model)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over -bound 0 --dsimpl --stop-after simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (<= 100 z)
             (= (+ (+ 2 y) (* (* (- 1) 3) x)) 0)
             (= (+ (+ 5 y) (* (* (- 1) 7) u)) 0))
  iter(2)= (and
             (= (+ y (* (- 7) u)) (- 5))
             (= (+ y (* (- 3) x)) (- 2))
             (<= 100 z))
  Something ready to substitute:  y -> (+ (- 5) (* 7 u));
  iter(3)= (and
             (= (+ y (* (- 7) u)) (- 5))
             (= (+ y (* (- 3) x)) (- 2))
             (<= 100 z))
  iter(4)= (and
             (= (+ (* (- 3) x) (* 7 u)) 3)
             (<= 100 z))
  Interesting:
  
  Expecting 1 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| u->0 x->-1 z->100 |}
  sat (under I)
  ((define-fun u () (_ Int) 0)
   (define-fun x () (_ Int) -1)
   (define-fun y () (_ Int) -5)
   (define-fun z () (_ Int) 100))

TODO: fix this later
  $ cat > 2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= x x))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro -no-over -bound 0 --dsimpl --stop-after simpl 2.smt2 | sed 's/[[:space:]]*$//'
  sat (presimpl)
  ()
