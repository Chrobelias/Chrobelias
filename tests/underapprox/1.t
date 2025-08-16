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
  $ Chro -bound 3 -dsimpl -stop-after simpl test.smt2
  There are 9 choices

  Checking (0): (bool.and (int.le_s 1 x) (int.le_s 1 x))




  $ Chro -bound 3 -dsimpl -stop-after simpl smoke1.smt2 | sed 's/[[:space:]]*$//'
  There are 9 choices

  Checking (0): (bool.and
                 (bool.and
                  (bool.and
                   (int.le_s
                    (int.mul
                     (int.mul (int.mul 3234 (int.mul 575 x2))
                      (int.mul -575 x1)) (int.mul -757 x3)) -80)
                   (int.le_s 0 x3)) (int.le_s 0 x2)) (int.le_s 0 x1))
  Checking (1): (bool.and
                 (bool.and
                  (bool.and
                   (int.le_s
                    (int.mul
                     (int.mul (int.mul 6468 (int.mul 575 x2))
                      (int.mul -575 x1)) (int.mul -757 x3)) -80)
                   (int.le_s 0 x3)) (int.le_s 0 x2)) (int.le_s 0 x1))
  Checking (2): (bool.and
                 (bool.and
                  (bool.and
                   (int.le_s
                    (int.mul
                     (int.mul (int.mul 12936 (int.mul 575 x2))
                      (int.mul -575 x1)) (int.mul -757 x3)) -80)
                   (int.le_s 0 x3)) (int.le_s 0 x2)) (int.le_s 0 x1))
  Checking (3): (bool.and
                 (bool.and
                  (bool.and
                   (int.le_s
                    (int.mul
                     (int.mul (int.mul 6468 (int.mul 575 x2))
                      (int.mul -575 x1)) (int.mul -757 x3)) -80)
                   (int.le_s 0 x3)) (int.le_s 0 x2)) (int.le_s 0 x1))
  Checking (4): (bool.and
                 (bool.and
                  (bool.and
                   (int.le_s
                    (int.mul
                     (int.mul (int.mul 12936 (int.mul 575 x2))
                      (int.mul -575 x1)) (int.mul -757 x3)) -80)
                   (int.le_s 0 x3)) (int.le_s 0 x2)) (int.le_s 0 x1))
  Checking (5): (bool.and
                 (bool.and
                  (bool.and
                   (int.le_s
                    (int.mul
                     (int.mul (int.mul 25872 (int.mul 575 x2))
                      (int.mul -575 x1)) (int.mul -757 x3)) -80)
                   (int.le_s 0 x3)) (int.le_s 0 x2)) (int.le_s 0 x1))
  Checking (6): (bool.and
                 (bool.and
                  (bool.and
                   (int.le_s
                    (int.mul
                     (int.mul (int.mul 12936 (int.mul 575 x2))
                      (int.mul -575 x1)) (int.mul -757 x3)) -80)
                   (int.le_s 0 x3)) (int.le_s 0 x2)) (int.le_s 0 x1))
  Checking (7): (bool.and
                 (bool.and
                  (bool.and
                   (int.le_s
                    (int.mul
                     (int.mul (int.mul 25872 (int.mul 575 x2))
                      (int.mul -575 x1)) (int.mul -757 x3)) -80)
                   (int.le_s 0 x3)) (int.le_s 0 x2)) (int.le_s 0 x1))
  Checking (8): (bool.and
                 (bool.and
                  (bool.and
                   (int.le_s
                    (int.mul
                     (int.mul (int.mul 51744 (int.mul 575 x2))
                      (int.mul -575 x1)) (int.mul -757 x3)) -80)
                   (int.le_s 0 x3)) (int.le_s 0 x2)) (int.le_s 0 x1))
  Can't decide in lib/Underapprox.ml
  Simplify step: ((+ (* 77 * (2 ** x1)) + (* 42 * (2 ** x2)) + (* 575 * x2) + (* -575 * x1) + (* -757 * x3)) <= (* -80) & 0 <= x3 & 0 <= x2 & 0 <= x1 & (+ 4) <= x1 & (+ 4) <= x2)
  Simplify step: ((+ (* 77 * (2 ** x1)) + (* 42 * (2 ** x2)) + (* 575 * x2) + (* -575 * x1) + (* -757 * x3)) <= -80 & 0 <= x3 & 0 <= x2 & 0 <= x1 & 4 <= x1 & 4 <= x2)
  Simplify step: ((+ (* 77 * (2 ** x1)) + (* 42 * (2 ** x2)) + (* 575 * x2) + (* -575 * x1) + (* -757 * x3)) <= -80 & 0 <= x3 & 0 <= x2 & 0 <= x1 & 4 <= x1 & 4 <= x2)
  Simplified expression: ((+ (* 77 * (2 ** x1)) + (* 42 * (2 ** x2)) + (* 575 * x2) + (* -575 * x1) + (* -757 * x3)) <= -80 & 0 <= x3 & 0 <= x2 & 0 <= x1 & 4 <= x1 & 4 <= x2)
  Trying to use Semenov deciding procedure over (((-575x1 + 575x2 + -757x3 + 77pow2(x1) + 42pow2(x2) <= -80)) & ((-1x3 <= 0)) & ((-1x2 <= 0)) & ((-1x1 <= 0)) & ((-1x1 <= -4)) & ((-1x2 <= -4)))
    subst = {| |}
    subst = {| |}
    subst = {| |}
    subst = {| |}
  ir = (exists (x3) ((-575x1 + 575x2 + -757x3 + 77pow2(x1) + 42pow2(x2) <= -80) & (-1x3 <= 0) & (-1x2 <= 0) & (-1x1 <= 0) & (-1x1 <= -4) & (-1x2 <= -4)))

  Vars: ["x3"]
  Can't simplify x3: bad polarity
  (assert (exists (x3)
          (and
            (<= (+ (* (- 575) x1) (* 575 x2) (* (- 757) x3) (* 77 pow2(x1))
                (* 42 pow2(x2)) )
             -80)
            (<= (* (- 1) x1)  -4)
            (<= (* (- 1) x2)  -4)
            (<= (* (- 1) x1)  0)
            (<= (* (- 1) x2)  0)
            (<= (* (- 1) x3)  0)
            )
  )
$ echo '77*2^2+42*2^2' | bc
  $ unset CHRO_DEBUG
  $ Chro -bound 3  smoke1.smt2 | sed 's/[[:space:]]*$//'

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
