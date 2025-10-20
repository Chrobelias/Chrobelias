  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (+ 5 y (* (- 7) u)) 0))
  > (assert (= (+ 2 y (* (- 3) x)) 0))
  > (assert (>= z 100))
  > (check-sat)
  > (get-model)
  > EOF
  $ CHRO_DEBUG=1 Chro -no-over-approx -bound 0 -dsimpl -stop-after simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  Simplify step: ((<= 100 z) & (= (+ 2 y (* (- 3) x)) 0) & (= (+ 5 y
                                                              (* (- 7) u)) 0))
  Simplify step: ((<= 100 z) & (= (+ 2 y (* (- 3) x)) 0) & (= (+ 5 y
                                                              (* (- 7) u)) 0))
  Simplified expression: (and
                           (<= 100 z)
                           (= (+ 2 y (* (- 3) x)) 0)
                           (= (+ 5 y (* (- 7) u)) 0))
  iter(1)= (and
             (<= 100 z)
             (= (+ 2 y (* (- 3) x)) 0)
             (= (+ 5 y (* (- 7) u)) 0))
  Something ready to substitute:  y -> (+ (* 2 (- 1)) (* (* (- 3) x) (- 1)));
  iter(2)= (and
             (= (+ y (* (- 7) u)) (- 5))
             (= (+ y (* (- 3) x)) (- 2))
             (<= 100 z))
  iter(3)= (and
             (= (+ (* (- 7) u) (* 2 (- 1)) (* (* (- 3) x) (- 1))) (- 5))
             (= (+ (* (- 3) x) (* 2 (- 1)) (* (* (- 3) x) (- 1))) (- 2))
             (<= 100 z))
  iter(4)= (and
             (= (+ (* (- 7) u) (* 3 x)) (- 3))
             (<= 100 z))
  Interesting:
  
  Expecting 1 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| u->3 x->6 z->100 |}
  sat (under I)
  ((define-fun u () (_ Int) 3)
   (define-fun x () (_ Int) 6)
   (define-fun y () (_ Int) 16)
   (define-fun z () (_ Int) 100))

TODO: fix this later
  $ cat > 2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (assert (= x x))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro -no-over-approx -bound 0 -dsimpl -stop-after simpl 2.smt2 | sed 's/[[:space:]]*$//'
  sat (presimpl)
  ()
