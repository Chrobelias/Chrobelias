$ cat input4.smt2
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl input4.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (and
               (= (+ (+ it376 (* (* (- 1) 3) i7)) (* 2 (exp i6 3))) 0)
               (= (+ (* (* (- 1) 2) i3) (* 2 i3)) 0)
               (<= i6 5)
               (<= 1 i3)
               (<= 1 (* 2 i3))
               (<= 1 (* 4 i3))
               (<= (+ (+ (+ (+ (* (* (- 1) 3) it376
                               (exp 9 (+ (* (- 1) 1) it140)))
                            (* (* (- 1) 1) (exp i6 3)))
                         (* 3 (exp i6 3) (exp 9 (+ (* (- 1) 1) it140))))
                      (* 4 (exp (* (* (- 1) 2) i3) 2)
                      (exp (exp 4 (+ (* (- 1) 1) it140)) 2)))
                   (exp i6 5)) (* (- 1) 1))
               (<= (+ (+ (* (* (- 1) 1) i7) (exp i3 2)) (exp i6 5)) (* (- 1) 1))
               (<= (+ (+ (* (* (- 1) 1) it376) (exp i6 5))
                   (exp (* (* (- 1) 2) i3) 2)) (* (- 1) 1))
               (<= (+ (+ (+ (+ (* (* (- 1) 1) it376
                               (exp 9 (+ (* (- 1) 1) it140)))
                            (* (* (- 1) 1) (exp i6 3)))
                         (* (exp i6 3) (exp 9 (+ (* (- 1) 1) it140))))
                      (* (exp (* (* (- 1) 2) i3) 2)
                      (exp (exp 4 (+ (* (- 1) 1) it140)) 2)))
                   (exp i6 5)) (* (- 1) 1))
               (<= (* (* (- 1) 1) i6) 5)
               (<= (* (* (- 1) 1) it140) (* (- 1) 1))))
  iteration 2
  ast(2) = (and
             (= (+ it376 (* (- 3) i7) (* 2 (exp i6 3))) 0)
             (= (+ (* (- 2) i3) (* 2 i3)) 0)
             (<= i6 5)
             (<= 1 i3)
             (<= 1 (* 2 i3))
             (<= 1 (* 4 i3))
             (<= (+ (* (- 3) it376 (exp 9 (+ (- 1) it140)))
                 (* (- 1) (exp i6 3)) (* 3 (exp i6 3) (exp 9 (+ (- 1) it140)))
                 (* 4 (exp (* (- 2) i3) 2) (exp (exp 4 (+ (- 1) it140)) 2))
                 (exp i6 5)) (- 1))
             (<= (+ (* (- 1) i7) (exp i3 2) (exp i6 5)) (- 1))
             (<= (+ (* (- 1) it376) (exp i6 5) (exp (* (- 2) i3) 2)) (- 1))
             (<= (+ (* (- 1) it376 (exp 9 (+ (- 1) it140)))
                 (* (- 1) (exp i6 3)) (* (exp i6 3) (exp 9 (+ (- 1) it140)))
                 (* (exp (* (- 2) i3) 2) (exp (exp 4 (+ (- 1) it140)) 2))
                 (exp i6 5)) (- 1))
             (<= (* (- 1) i6) 5)
             (<= (* (- 1) it140) (- 1)))
  Fixpoint after 2 steps

  $ /usr/bin/time -f "TIME: %U" timeout 5 Chro -pre-simpl input4.smt2 || echo "timeout"
  Command exited with non-zero status 124
  TIME: 4.99
  timeout

  $ export CHRO_DEBUG=1
  $ /usr/bin/time -f "TIME: %U" Chro -no-pre-simpl input4.smt2 -dsimpl 2>&1 | nl -ba | sed 's/[[:space:]]*$//'
       1	whole: (bool.and
       2	        (bool.and
       3	         (bool.and
       4	          (bool.and
       5	           (bool.and
       6	            (bool.and
       7	             (bool.and
       8	              (bool.and
       9	               (bool.and
      10	                (bool.and
      11	                 (bool.and
      12	                  (bool.eq
      13	                   (int.add (int.add it376 (int.mul -3 i7))
      14	                    (int.mul 2 (int.pow i6 3))) 0)
      15	                  (bool.eq (int.add (int.mul -2 i3) (int.mul 2 i3)) 0))
      16	                 (int.le_s i6 5)) (int.le_s 1 i3))
      17	               (int.le_s 1 (int.mul 2 i3))) (int.le_s 1 (int.mul 4 i3)))
      18	             (int.le_s
      19	              (int.add
      20	               (int.add
      21	                (int.add
      22	                 (int.add
      23	                  (int.mul (int.mul -3 it376) (int.pow 9 (int.add -1 it140)))
      24	                  (int.mul -1 (int.pow i6 3)))
      25	                 (int.mul (int.mul 3 (int.pow i6 3))
      26	                  (int.pow 9 (int.add -1 it140))))
      27	                (int.mul (int.mul 4 (int.pow (int.mul -2 i3) 2))
      28	                 (int.pow (int.pow 4 (int.add -1 it140)) 2))) (int.pow i6 5))
      29	              -1))
      30	            (int.le_s
      31	             (int.add (int.add (int.mul -1 i7) (int.pow i3 2))
      32	              (int.pow i6 5)) -1))
      33	           (int.le_s
      34	            (int.add (int.add (int.mul -1 it376) (int.pow i6 5))
      35	             (int.pow (int.mul -2 i3) 2)) -1))
      36	          (int.le_s
      37	           (int.add
      38	            (int.add
      39	             (int.add
      40	              (int.add
      41	               (int.mul (int.mul -1 it376) (int.pow 9 (int.add -1 it140)))
      42	               (int.mul -1 (int.pow i6 3)))
      43	              (int.mul (int.pow i6 3) (int.pow 9 (int.add -1 it140))))
      44	             (int.mul (int.pow (int.mul -2 i3) 2)
      45	              (int.pow (int.pow 4 (int.add -1 it140)) 2))) (int.pow i6 5))
      46	           -1)) (int.le_s (int.mul -1 i6) 5))
      47	        (int.le_s (int.mul -1 it140) -1))
      48
      49	Interesting:
      50
      51	Expecting 1 choices ...
      52
      53	lib/Underapprox.ml gives early Sat.
      54	env = {| |}
      55	sat
      56	TIME: 27.44


