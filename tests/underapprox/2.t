  $ cat > testU.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (exists ((x Int)) (<= (exp 2  x) x)))
  > (assert (<= (exp 2  y) x))
  > (check-sat)
  > EOF
  $ export CHRO_DEBUG=1
  $ timeout 2 Chro -no-over-approx -bound 3 -dsimpl -stop-after simpl testU.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (<= (exp 2 y) x)
             (exists (x) (<= (exp 2 x) x)))
  Interesting: x y
  
  Expecting 9 choices ...
  
  Can't decide in lib/Underapprox.ml
  (assert (<= (+ (* (- 1) x) pow2(y) )  0) )
  (assert (exists (x) (<= (+ (* (- 1) x) pow2(x) )  0) ) )
  


