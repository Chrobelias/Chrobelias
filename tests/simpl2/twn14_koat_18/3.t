$ cat input3.smt2
  $ CHRO_DEBUG=1 Chro -pre-simpl -dsimpl -stop-after pre-simpl input3.smt2 | sed 's/[[:space:]]*$//'
  iteration 1
  ast(1) = (and
             (and
               (= (+ (+ it358 (* (* (- 1) 1) i2)) (* (* (- 1) 1) 1)) 2)
               (= (+ it359 (* (* (- 1) 1) i3)) 0)
               (= (+ it360 (* (* (- 1) 1) i3)) 0)
               (= (+ it361 (* (* (- 1) 1) i7)) 0)
               (= (+ it362 (* (* (- 1) 1) i6)) 0)
               (= (+ it363 (* (* (- 1) 1) i7)) 0)
               (= (+ (+ it376 (* (* (- 1) 3) it361)) (* 2 (exp it362 3))) 0)
               (= (+ (* (* (- 1) 2) it360) (* 2 it360)) 0)
               (<= i6 5)
               (<= 1 i3)
               (<= 1 it360)
               (<= 1 (* 2 it360))
               (<= 1 (* 4 it360))
               (<= (+ (+ (+ (+ (* (* (- 1) 3) it376
                               (exp 9 (+ (* (- 1) 1) it140)))
                            (* (* (- 1) 1) (exp it362 3)))
                         (* 3 (exp it362 3) (exp 9 (+ (* (- 1) 1) it140))))
                      (* 4 (exp (* (* (- 1) 2) it360) 2)
                      (exp (exp 4 (+ (* (- 1) 1) it140)) 2)))
                   (exp it362 5)) (* (- 1) 1))
               (<= (+ (+ (* (* (- 1) 1) it361) (exp it360 2)) (exp it362 5))
               (* (- 1) 1))
               (<= (+ (+ (* (* (- 1) 1) it376) (exp it362 5))
                   (exp (* (* (- 1) 2) it360) 2)) (* (- 1) 1))
               (<= (+ (+ (+ (+ (* (* (- 1) 1) it376
                               (exp 9 (+ (* (- 1) 1) it140)))
                            (* (* (- 1) 1) (exp it362 3)))
                         (* (exp it362 3) (exp 9 (+ (* (- 1) 1) it140))))
                      (* (exp (* (* (- 1) 2) it360) 2)
                      (exp (exp 4 (+ (* (- 1) 1) it140)) 2)))
                   (exp it362 5)) (* (- 1) 1))
               (<= (* (* (- 1) 1) i6) 5)
               (<= (* (* (- 1) 1) it140) (* (- 1) 1))))
  iteration 2
  ast(2) = (and
             (= (+ it358 (* (- 1) i2)) 3)
             (= (+ it359 (* (- 1) i3)) 0)
             (= (+ it360 (* (- 1) i3)) 0)
             (= (+ it361 (* (- 1) i7)) 0)
             (= (+ it362 (* (- 1) i6)) 0)
             (= (+ it363 (* (- 1) i7)) 0)
             (= (+ it376 (* (- 3) it361) (* 2 (exp it362 3))) 0)
             (= (+ (* (- 2) it360) (* 2 it360)) 0)
             (<= i6 5)
             (<= 1 i3)
             (<= 1 it360)
             (<= 1 (* 2 it360))
             (<= 1 (* 4 it360))
             (<= (+ (* (- 3) it376 (exp 9 (+ (- 1) it140)))
                 (* (- 1) (exp it362 3))
                 (* 3 (exp it362 3) (exp 9 (+ (- 1) it140)))
                 (* 4 (exp (* (- 2) it360) 2) (exp (exp 4 (+ (- 1) it140)) 2))
                 (exp it362 5)) (- 1))
             (<= (+ (* (- 1) it361) (exp it360 2) (exp it362 5)) (- 1))
             (<= (+ (* (- 1) it376) (exp it362 5) (exp (* (- 2) it360) 2)) (- 1))
             (<= (+ (* (- 1) it376 (exp 9 (+ (- 1) it140)))
                 (* (- 1) (exp it362 3))
                 (* (exp it362 3) (exp 9 (+ (- 1) it140)))
                 (* (exp (* (- 2) it360) 2) (exp (exp 4 (+ (- 1) it140)) 2))
                 (exp it362 5)) (- 1))
             (<= (* (- 1) i6) 5)
             (<= (* (- 1) it140) (- 1)))
  Something ready to substitute:  it358 -> (+ 3 i2); it359 -> i3; it360 ->
                                 i3; it361 -> i7; it362 -> i6; it363 ->
                                 i7;
  iteration 3
  ast(3) = (and
             (= (+ it358 (* (- 1) i2)) 3)
             (= (+ it359 (* (- 1) i3)) 0)
             (= (+ it360 (* (- 1) i3)) 0)
             (= (+ it361 (* (- 1) i7)) 0)
             (= (+ it362 (* (- 1) i6)) 0)
             (= (+ it363 (* (- 1) i7)) 0)
             (= (+ it376 (* (- 3) it361) (* 2 (exp it362 3))) 0)
             (= (+ (* (- 2) it360) (* 2 it360)) 0)
             (<= i6 5)
             (<= 1 i3)
             (<= 1 it360)
             (<= 1 (* 2 it360))
             (<= 1 (* 4 it360))
             (<= (+ (* (- 3) it376 (exp 9 (+ (- 1) it140)))
                 (* (- 1) (exp it362 3))
                 (* 3 (exp it362 3) (exp 9 (+ (- 1) it140)))
                 (* 4 (exp (* (- 2) it360) 2) (exp (exp 4 (+ (- 1) it140)) 2))
                 (exp it362 5)) (- 1))
             (<= (+ (* (- 1) it361) (exp it360 2) (exp it362 5)) (- 1))
             (<= (+ (* (- 1) it376) (exp it362 5) (exp (* (- 2) it360) 2)) (- 1))
             (<= (+ (* (- 1) it376 (exp 9 (+ (- 1) it140)))
                 (* (- 1) (exp it362 3))
                 (* (exp it362 3) (exp 9 (+ (- 1) it140)))
                 (* (exp (* (- 2) it360) 2) (exp (exp 4 (+ (- 1) it140)) 2))
                 (exp it362 5)) (- 1))
             (<= (* (- 1) i6) 5)
             (<= (* (- 1) it140) (- 1)))
  iteration 4
  ast(4) = (and
             (= 0 0)
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
  iteration 5
  ast(5) = (and
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
  Fixpoint after 5 steps

  $ /usr/bin/time -f "TIME: %U" timeout 5 Chro -pre-simpl input3.smt2 || echo "timeout"
  Command exited with non-zero status 124
  TIME: 4.99
  timeout

  $ export CHRO_DEBUG=1
  $ /usr/bin/time -f "TIME: %U" Chro -no-pre-simpl input3.smt2 -dsimpl 2>&1 | nl -ba | sed 's/[[:space:]]*$//'
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
      12	                  (bool.and
      13	                   (bool.and
      14	                    (bool.and
      15	                     (bool.and
      16	                      (bool.and
      17	                       (bool.and
      18	                        (bool.and
      19	                         (bool.eq
      20	                          (int.add (int.add it358 (int.mul -1 i2)) -1) 2)
      21	                         (bool.eq (int.add it359 (int.mul -1 i3)) 0))
      22	                        (bool.eq (int.add it360 (int.mul -1 i3)) 0))
      23	                       (bool.eq (int.add it361 (int.mul -1 i7)) 0))
      24	                      (bool.eq (int.add it362 (int.mul -1 i6)) 0))
      25	                     (bool.eq (int.add it363 (int.mul -1 i7)) 0))
      26	                    (bool.eq
      27	                     (int.add (int.add it376 (int.mul -3 it361))
      28	                      (int.mul 2 (int.pow it362 3))) 0))
      29	                   (bool.eq (int.add (int.mul -2 it360) (int.mul 2 it360)) 0))
      30	                  (int.le_s i6 5)) (int.le_s 1 i3)) (int.le_s 1 it360))
      31	               (int.le_s 1 (int.mul 2 it360)))
      32	              (int.le_s 1 (int.mul 4 it360)))
      33	             (int.le_s
      34	              (int.add
      35	               (int.add
      36	                (int.add
      37	                 (int.add
      38	                  (int.mul (int.mul -3 it376) (int.pow 9 (int.add -1 it140)))
      39	                  (int.mul -1 (int.pow it362 3)))
      40	                 (int.mul (int.mul 3 (int.pow it362 3))
      41	                  (int.pow 9 (int.add -1 it140))))
      42	                (int.mul (int.mul 4 (int.pow (int.mul -2 it360) 2))
      43	                 (int.pow (int.pow 4 (int.add -1 it140)) 2)))
      44	               (int.pow it362 5)) -1))
      45	            (int.le_s
      46	             (int.add (int.add (int.mul -1 it361) (int.pow it360 2))
      47	              (int.pow it362 5)) -1))
      48	           (int.le_s
      49	            (int.add (int.add (int.mul -1 it376) (int.pow it362 5))
      50	             (int.pow (int.mul -2 it360) 2)) -1))
      51	          (int.le_s
      52	           (int.add
      53	            (int.add
      54	             (int.add
      55	              (int.add
      56	               (int.mul (int.mul -1 it376) (int.pow 9 (int.add -1 it140)))
      57	               (int.mul -1 (int.pow it362 3)))
      58	              (int.mul (int.pow it362 3) (int.pow 9 (int.add -1 it140))))
      59	             (int.mul (int.pow (int.mul -2 it360) 2)
      60	              (int.pow (int.pow 4 (int.add -1 it140)) 2))) (int.pow it362 5))
      61	           -1)) (int.le_s (int.mul -1 i6) 5))
      62	        (int.le_s (int.mul -1 it140) -1))
      63
      64	Interesting:
      65
      66	Expecting 1 choices ...
      67
      68	lib/Underapprox.ml gives early Sat.
      69	env = {| |}
      70	sat
      71	TIME: 0.03


