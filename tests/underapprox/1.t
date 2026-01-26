  $ cat > test.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (<= (exp 2  x) x))
  > (assert (<= (exp 2  y) x))
  > (check-sat)
  > EOF
  $ export CHRO_DEBUG=1
  $ timeout 2 Chro -no-over -bound 3 --dsimpl --stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
  Basic simplifications:
  
  iter(1)= (and
             (<= (exp 2 y) x)
             (<= (exp 2 x) x))
  iter(2)= (and
             (<= (exp 2 x) x)
             (<= (exp 2 y) x))
  fixed-point
  
  Bound for underapproximation: 3
  
  Interesting: x y
  
  Expecting 9 choices ...
  
  Can't decide in lib/Underapprox.ml
  Starting NFA Solver ...
  
  (assert (<= (+ (* (- 1) x) pow2(x) )  0) )
  (assert (<= (+ (* (- 1) x) pow2(y) )  0) )
  








  $ Chro -no-over -bound 3 --dsimpl --no-pre-simpl --stop-after simpl smoke1.smt2 | sed 's/[[:space:]]*$//'
  Bound for underapproximation: 10
  
  Interesting: x1 x2
  
  Expecting 100 choices ...
  
  lib/Underapprox.ml gives early Sat.
  env = {| x1->1 x2->0 |}
  sat (under I)
$ echo '77*2^2+42*2^2' | bc
  $ unset CHRO_DEBUG
  $ Chro -no-over -bound 3  smoke1.smt2 | sed 's/[[:space:]]*$//'
  sat (under I)

$ cat > test.smt2 <<-EOF
> (set-logic ALL)
> (declare-fun x1 () Int)
> (assert (not (distinct x1 (bwand x1 x1) )))
> (assert (<= x1 x1))
> (check-sat)
> EOF
$ Chro  -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
(assert (exists (x1  %0) ((re.star (mor (mor (mor 4 2) 0) 7) )))
)

$ cat > test.smt2 <<-EOF
> (set-logic ALL)
> (declare-const a String)
> (declare-fun x1 () Int)
> (assert (str.in_re a (str.to_re "ab")) )
> (assert (<= x1 x1))
> (check-sat)
> EOF
$ export CHRO_DEBUG=1
$ Chro -over-approx -dsimpl -stop-after simpl test.smt2 | sed 's/[[:space:]]*$//'
+  Fatal error: exception Failure("Expression (str.in_re a (str.to_re \"ab\")) can't be handled")
+  Raised at Stdlib.failwith in file "stdlib.ml", line 29, characters 17-33
+  Called from Dune__exe__Chro.exec in file "bin/chro.ml", line 82, characters 16-37
+  Called from Stdlib__List.fold_left in file "list.ml", line 123, characters 24-34
+  Called from Dune__exe__Chro in file "bin/chro.ml", line 87, characters 10-61
