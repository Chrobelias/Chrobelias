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
  iter(1.0)= (and
               (<= (exp 2 0) 0)
               (exists (x) (<= (exp 2 0) 0)))
  iter(1.1)= (not True)
  iter(1.1)= (and
               (<= (exp 2 0) 1)
               (exists (x) (<= (exp 2 1) 1)))
  iter(1.2)= (and
               (exists (x) (not True)))
  iter(1.3)= (exists (x) (not True))
  iter(1.2)= (and
               (<= (exp 2 0) 2)
               (exists (x) (<= (exp 2 2) 2)))
  iter(1.3)= (and
               (exists (x) (not True)))
  iter(1.4)= (exists (x) (not True))
  iter(1.3)= (and
               (<= (exp 2 1) 0)
               (exists (x) (<= (exp 2 0) 0)))
  iter(1.4)= (not True)
  iter(1.4)= (and
               (<= (exp 2 1) 1)
               (exists (x) (<= (exp 2 1) 1)))
  iter(1.5)= (not True)
  iter(1.5)= (and
               (<= (exp 2 1) 2)
               (exists (x) (<= (exp 2 2) 2)))
  iter(1.6)= (and
               (exists (x) (not True)))
  iter(1.7)= (exists (x) (not True))
  iter(1.6)= (and
               (<= (exp 2 2) 0)
               (exists (x) (<= (exp 2 0) 0)))
  iter(1.7)= (not True)
  iter(1.7)= (and
               (<= (exp 2 2) 1)
               (exists (x) (<= (exp 2 1) 1)))
  iter(1.8)= (not True)
  iter(1.8)= (and
               (<= (exp 2 2) 2)
               (exists (x) (<= (exp 2 2) 2)))
  iter(1.9)= (not True)
  Interesting: x y
  
  Expecting 9 choices ...
  
  Can't decide in lib/Underapprox.ml
  Simplify step: ((2 ** y) <= x & (Ex (2 ** x) <= x))
  Simplify step: ((2 ** y) <= x & (Ex (2 ** x) <= x))
  Simplified expression: ((2 ** y) <= x & (Ex (2 ** x) <= x))
  Trying to use Semenov deciding procedure over (((-1x + 1pow2(y) <= 0)) & (exists (x) ((-1x + 1pow2(x) <= 0))))
  (assert (<= (+ (* (- 1) x) pow2(y) )  0) )
  (assert (exists (x) (<= (+ (* (- 1) x) pow2(x) )  0) ) )
  


