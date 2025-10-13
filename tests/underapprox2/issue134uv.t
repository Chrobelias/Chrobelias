$ export OCAMLRUNPARAM='b=0'
  $ cat > 0.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun u () Int)
  > (declare-fun v () Int)
  > (declare-fun a () Int)
  > (declare-fun z () Int)
  > (assert (= 113 (* (+ (exp 2 u) (exp 2 v) a) (exp 2 z)) ))
  > (check-sat)
  > EOF
  $ OCAMLRUNPARAM='b=0' Chro -no-over-approx -bound 6 -lsb 0.smt2
  unknown
  ; converting to automaton expression: unimplemented (= (+ (* (- 1) a (exp 2 z)) (* (- 1) (exp 2 (+ u z)))
                   (* (- 1) (exp 2 (+ v z)))) (- 113))

  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (assert (= 52 (* x (exp 2 y)) ))
  > (check-sat)
  > EOF

$ export CHRO_DEBUG=1
  $ timeout 2 Chro -no-over-approx -bound -1 -bmax 5 -dsimpl -flat 0 -lsb  1.smt2 #-stop-after simpl -amin 5 -amax 5
  (assert (exists (u0)
          (and
            (exists (y) (= (+ eee1 (* (- 1) u0) (* (- 1) y) )  0) )
            (= (* (- 1) pow2(eee1))  -52)
            (<= (* (- 1) u0)  0)
            )
  )
  (assert (<= (+ eee1 (* (- 1) pow2(eee1)) )  -1)
  )
  (assert (exists (u1)
          (and
            (= (+ eee2 (* (- 1) u1) (* (- 1) y) )  0)
            (= (+ (* (- 2) pow2(eee2)) (* (- 1) pow2(y)) )  -52)
            (<= (* (- 1) u1)  0)
            )
  )
  (assert (<= (+ eee2 (* (- 1) pow2(eee2)) )  -1) )
  (assert (<= (+ (* (- 1) eee2) pow2(y) )  0) )
  (assert (<= (+ y (* (- 1) pow2(y)) )  -1) )
  
  (assert (<= (+ (* (- 1) pow2(eee2)) pow2(y) )  0) )
  (assert (<= (+ eee2 (* (- 1) pow2(y)) )  0) )
  (assert (<= (+ (* (- 1) eee2) y )  0) )
  
  (assert (<= (+ pow2(eee2) (* (- 1) pow2(y)) )  0) )
  (assert (<= (+ y (* (- 1) pow2(eee2)) )  0) )
  (assert (<= (+ eee2 (* (- 1) y) )  0) )
  
  (assert (exists (u2)
          (and
            (= (+ eee3 (* (- 1) u2) (* (- 1) y) )  0)
            (= (+ (* (- 4) pow2(eee3)) (* (- 2) pow2(y)) )  -52)
            (<= (* (- 1) u2)  0)
            )
  )
  (assert (<= (+ eee3 (* (- 1) pow2(eee3)) )  -1) )
  (assert (<= (+ (* (- 1) eee3) pow2(y) )  0) )
  (assert (<= (+ y (* (- 1) pow2(y)) )  -1) )
  
  (assert (<= (+ (* (- 1) pow2(eee3)) pow2(y) )  0) )
  (assert (<= (+ eee3 (* (- 1) pow2(y)) )  0) )
  (assert (<= (+ (* (- 1) eee3) y )  0) )
  
  (assert (<= (+ pow2(eee3) (* (- 1) pow2(y)) )  0) )
  (assert (<= (+ y (* (- 1) pow2(eee3)) )  0) )
  (assert (<= (+ eee3 (* (- 1) y) )  0) )
  
  (assert (exists (u3)
          (and
            (= (+ eee4 (* (- 1) u3) (* (- 1) y) )  0)
            (= (+ (* (- 4) pow2(eee4)) (* (- 3) pow2(y)) )  -52)
            (<= (* (- 1) u3)  0)
            )
  )
  (assert (<= (+ eee4 (* (- 1) pow2(eee4)) )  -1) )
  (assert (<= (+ (* (- 1) eee4) pow2(y) )  0) )
  (assert (<= (+ y (* (- 1) pow2(y)) )  -1) )
  
  (assert (<= (+ (* (- 1) pow2(eee4)) pow2(y) )  0) )
  (assert (<= (+ eee4 (* (- 1) pow2(y)) )  0) )
  (assert (<= (+ (* (- 1) eee4) y )  0) )
  
  (assert (<= (+ pow2(eee4) (* (- 1) pow2(y)) )  0) )
  (assert (<= (+ y (* (- 1) pow2(eee4)) )  0) )
  (assert (<= (+ eee4 (* (- 1) y) )  0) )
  
  (assert (exists (u4)
          (and
            (= (+ eee5 (* (- 1) u4) (* (- 1) y) )  0)
            (= (+ (* (- 8) pow2(eee5)) (* (- 4) pow2(y)) )  -52)
            (<= (* (- 1) u4)  0)
            )
  )
  (assert (<= (+ eee5 (* (- 1) pow2(eee5)) )  -1) )
  (assert (<= (+ (* (- 1) eee5) pow2(y) )  0) )
  (assert (<= (+ y (* (- 1) pow2(y)) )  -1) )
  
  (assert (<= (+ (* (- 1) pow2(eee5)) pow2(y) )  0) )
  (assert (<= (+ eee5 (* (- 1) pow2(y)) )  0) )
  (assert (<= (+ (* (- 1) eee5) y )  0) )
  
  (assert (<= (+ pow2(eee5) (* (- 1) pow2(y)) )  0) )
  (assert (<= (+ y (* (- 1) pow2(eee5)) )  0) )
  (assert (<= (+ eee5 (* (- 1) y) )  0) )
  
  (assert (exists (u5)
          (and
            (= (+ eee6 (* (- 1) u5) (* (- 1) y) )  0)
            (= (+ (* (- 8) pow2(eee6)) (* (- 5) pow2(y)) )  -52)
            (<= (* (- 1) u5)  0)
            )
  )
  (assert (<= (+ eee6 (* (- 1) pow2(eee6)) )  -1) )
  (assert (<= (+ (* (- 1) eee6) pow2(y) )  0) )
  (assert (<= (+ y (* (- 1) pow2(y)) )  -1) )
  
  (assert (<= (+ (* (- 1) pow2(eee6)) pow2(y) )  0) )
  (assert (<= (+ eee6 (* (- 1) pow2(y)) )  0) )
  (assert (<= (+ (* (- 1) eee6) y )  0) )
  
  (assert (= (* (- 1) u5)  0) )
  (assert (<= (* (- 1) u5)  0) )
  
  sat ; under II

  $ echo '(2^10-2^8+1)* 2^2' | bc
  3076
  $ cat > 2.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun z () Int)
  > (assert (= (* x (exp 2 z)) 3076))
  > (check-sat)
  > (get-model)
  > EOF

  $ export RUN='Chro -no-over-approx -bound -1 -dsimpl -lsb 2.smt2'
  $ CHRO_DEBUG=1 $RUN -flat 1 -stop-after presimpl #-amin 1 -amax 1
  iter(1)= (and
             (= (* x (exp 2 z)) 3076))
  iter(2)= (= (* x (exp 2 z)) 3076)
  vars_for_under2: x
  
  iter(1)= (and
             (= (* 1
                (* (+ (* 1
                      (* (+ (* 1 (exp 2 u0)) (* 1 (* (- 1) (exp 2 u1))))
                      (exp 2 0)))
                   (* 1 0))
                (exp 2 z))) (* 1 3076))
             (<= (* 1 (* 1 u1)) (* 1 (* 1 u0)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u1))))
  iter(2)= (and
             (= (+ (* (* (* (* (* (- 1) (exp 2 u1)) 1) 1) (exp 2 z)) 1)
                (* (* (* (* (exp 2 u0) 1) 1) (exp 2 z)) 1)) 3076)
             (<= u1 u0)
             (<= 0 u1))
  iter(3)= (and
             (= (+ (* (- 1) (exp 2 u1) (exp 2 z)) (exp 2 (+ u0 z))) 3076)
             (<= u1 u0)
             (<= 0 u1))
  iter(4)= (and
             (= (+ (* (- 1) (exp 2 (+ u1 z))) (exp 2 (+ u0 z))) 3076)
             (<= u1 u0)
             (<= 0 u1))
  iter(1)= (and
             (= (* 1
                (* (+ (* 1
                      (* (+ (* 1 (exp 2 u2)) (* 1 (* (- 1) (exp 2 u3))))
                      (exp 2 1)))
                   (* 1 1))
                (exp 2 z))) (* 1 3076))
             (<= (* 1 (* 1 u3)) (* 1 (* 1 u2)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u3))))
  iter(2)= (and
             (= (+ (* (* 1 (exp 2 z)) 1)
                (* (* (* (* (* (- 1) (exp 2 u3)) 2) 1) (exp 2 z)) 1)
                (* (* (* (* (exp 2 u2) 2) 1) (exp 2 z)) 1)) 3076)
             (<= u3 u2)
             (<= 0 u3))
  iter(3)= (and
             (= (+ (* (- 2) (exp 2 u3) (exp 2 z)) (* 2 (exp 2 u2) (exp 2 z))
                (exp 2 z)) 3076)
             (<= u3 u2)
             (<= 0 u3))
  iter(4)= (and
             (= (+ (* (- 2) (exp 2 (+ u3 z))) (* 2 (exp 2 (+ u2 z))) (exp 2 z)) 3076)
             (<= u3 u2)
             (<= 0 u3))
  $ CHRO_DEBUG=1 $RUN -flat 1 -bmax 3 -stop-after presimpl # -amin 1 -amax 1
  iter(1)= (and
             (= (* x (exp 2 z)) 3076))
  iter(2)= (= (* x (exp 2 z)) 3076)
  vars_for_under2: x
  
  iter(1)= (and
             (= (* 1
                (* (+ (* 1
                      (* (+ (* 1 (exp 2 u0)) (* 1 (* (- 1) (exp 2 u1))))
                      (exp 2 0)))
                   (* 1 0))
                (exp 2 z))) (* 1 3076))
             (<= (* 1 (* 1 u1)) (* 1 (* 1 u0)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u1))))
  iter(2)= (and
             (= (+ (* (* (* (* (* (- 1) (exp 2 u1)) 1) 1) (exp 2 z)) 1)
                (* (* (* (* (exp 2 u0) 1) 1) (exp 2 z)) 1)) 3076)
             (<= u1 u0)
             (<= 0 u1))
  iter(3)= (and
             (= (+ (* (- 1) (exp 2 u1) (exp 2 z)) (exp 2 (+ u0 z))) 3076)
             (<= u1 u0)
             (<= 0 u1))
  iter(4)= (and
             (= (+ (* (- 1) (exp 2 (+ u1 z))) (exp 2 (+ u0 z))) 3076)
             (<= u1 u0)
             (<= 0 u1))
  iter(1)= (and
             (= (* 1
                (* (+ (* 1
                      (* (+ (* 1 (exp 2 u2)) (* 1 (* (- 1) (exp 2 u3))))
                      (exp 2 1)))
                   (* 1 1))
                (exp 2 z))) (* 1 3076))
             (<= (* 1 (* 1 u3)) (* 1 (* 1 u2)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u3))))
  iter(2)= (and
             (= (+ (* (* 1 (exp 2 z)) 1)
                (* (* (* (* (* (- 1) (exp 2 u3)) 2) 1) (exp 2 z)) 1)
                (* (* (* (* (exp 2 u2) 2) 1) (exp 2 z)) 1)) 3076)
             (<= u3 u2)
             (<= 0 u3))
  iter(3)= (and
             (= (+ (* (- 2) (exp 2 u3) (exp 2 z)) (* 2 (exp 2 u2) (exp 2 z))
                (exp 2 z)) 3076)
             (<= u3 u2)
             (<= 0 u3))
  iter(4)= (and
             (= (+ (* (- 2) (exp 2 (+ u3 z))) (* 2 (exp 2 (+ u2 z))) (exp 2 z)) 3076)
             (<= u3 u2)
             (<= 0 u3))
  iter(1)= (and
             (= (* 1
                (* (+ (* 1
                      (* (+ (* 1 (exp 2 u4)) (* 1 (* (- 1) (exp 2 u5))))
                      (exp 2 2)))
                   (* 1 2))
                (exp 2 z))) (* 1 3076))
             (<= (* 1 (* 1 u5)) (* 1 (* 1 u4)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u5))))
  iter(2)= (and
             (= (+ (* (* 2 (exp 2 z)) 1)
                (* (* (* (* (* (- 1) (exp 2 u5)) 4) 1) (exp 2 z)) 1)
                (* (* (* (* (exp 2 u4) 4) 1) (exp 2 z)) 1)) 3076)
             (<= u5 u4)
             (<= 0 u5))
  iter(3)= (and
             (= (+ (* (- 4) (exp 2 u5) (exp 2 z)) (* 2 (exp 2 z))
                (* 4 (exp 2 u4) (exp 2 z))) 3076)
             (<= u5 u4)
             (<= 0 u5))
  iter(4)= (and
             (= (+ (* (- 4) (exp 2 (+ u5 z))) (* 2 (exp 2 z))
                (* 4 (exp 2 (+ u4 z)))) 3076)
             (<= u5 u4)
             (<= 0 u5))
  iter(1)= (and
             (= (* 1
                (* (+ (* 1
                      (* (+ (* 1 (exp 2 u6)) (* 1 (* (- 1) (exp 2 u7))))
                      (exp 2 2)))
                   (* 1 3))
                (exp 2 z))) (* 1 3076))
             (<= (* 1 (* 1 u7)) (* 1 (* 1 u6)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u7))))
  iter(2)= (and
             (= (+ (* (* 3 (exp 2 z)) 1)
                (* (* (* (* (* (- 1) (exp 2 u7)) 4) 1) (exp 2 z)) 1)
                (* (* (* (* (exp 2 u6) 4) 1) (exp 2 z)) 1)) 3076)
             (<= u7 u6)
             (<= 0 u7))
  iter(3)= (and
             (= (+ (* (- 4) (exp 2 u7) (exp 2 z)) (* 3 (exp 2 z))
                (* 4 (exp 2 u6) (exp 2 z))) 3076)
             (<= u7 u6)
             (<= 0 u7))
  iter(4)= (and
             (= (+ (* (- 4) (exp 2 (+ u7 z))) (* 3 (exp 2 z))
                (* 4 (exp 2 (+ u6 z)))) 3076)
             (<= u7 u6)
             (<= 0 u7))

The test below should be SAT but there is an issue #143
which is needed to be fixed first
-amin 1 -amax 1
  $ timeout 2 $RUN -flat 1 | grep -v assert | sed -r '/^\s*$/d'
          (and
            (exists (z)
            (and
              (exists (u0)
              (and
                (= (+ eee2 (* (- 1) u0) (* (- 1) z) )  0)
                (<= (+ (* (- 1) u0) u1 )  0)
                )
              (= (+ eee1 (* (- 1) u1) (* (- 1) z) )  0)
              )
            (= (+ (* (- 1) pow2(eee1)) pow2(eee2) )  3076)
            (<= (* (- 1) u1)  0)
            )
  )
          (and
            (exists (u2)
            (and
              (= (+ eee4 (* (- 1) u2) (* (- 1) z) )  0)
              (<= (+ (* (- 1) u2) u3 )  0)
              )
            (= (+ eee3 (* (- 1) u3) (* (- 1) z) )  0)
            (= (+ (* (- 2) pow2(eee3)) (* 2 pow2(eee4)) pow2(z) )  3076)
            (<= (* (- 1) u3)  0)
            )
  )
  unknown
  ; Under2 resigns
  unknown
  ; converting to automaton expression: unable to multiply var by var: (pow2(z) )  with (x )
  no model

  $ echo '(2^12-2^10+1)* 2^0' | bc
  3073

  $ cat > 3.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun z () Int)
  > (assert (= (* x (exp 2 z)) 3073))
  > (check-sat)
  > (get-model)
  > EOF
  $ export RUN='Chro -no-over-approx -bound -1 -dsimpl -lsb 3.smt2'
-amin 1 -amax 1
  $ timeout 2 $RUN -lsb 3.smt2 -flat 1 | grep -v assert | sed -r '/^\s*$/d'
          (and
            (exists (z)
            (and
              (exists (u0)
              (and
                (= (+ eee2 (* (- 1) u0) (* (- 1) z) )  0)
                (<= (+ (* (- 1) u0) u1 )  0)
                )
              (= (+ eee1 (* (- 1) u1) (* (- 1) z) )  0)
              )
            (= (+ (* (- 1) pow2(eee1)) pow2(eee2) )  3073)
            (<= (* (- 1) u1)  0)
            )
  )
          (and
            (exists (u2)
            (and
              (= (+ eee4 (* (- 1) u2) (* (- 1) z) )  0)
              (<= (+ (* (- 1) u2) u3 )  0)
              )
            (= (+ eee3 (* (- 1) u3) (* (- 1) z) )  0)
            (= (+ (* (- 2) pow2(eee3)) (* 2 pow2(eee4)) pow2(z) )  3073)
            (<= (* (- 1) u3)  0)
            )
  )
  sat ; under II

  $ echo '(2^13-2^7+2^5)*2^0' | bc
  8096

  $ cat > 4.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun z () Int)
  > (assert (= (* x (exp 2 z)) 8096))
  > (check-sat)
  > (get-model)
  > EOF
  $ export RUN='Chro -no-over-approx -bound -1 -dsimpl -lsb 4.smt2'
  $ CHRO_DEBUG=1 $RUN -flat 2 -stop-after presimpl
  iter(1)= (and
             (= (* x (exp 2 z)) 8096))
  iter(2)= (= (* x (exp 2 z)) 8096)
  vars_for_under2: x
  
  iter(1)= (and
             (= (* 1
                (* (+ (* 1
                      (* (+ (* 1 (exp 2 u0)) (* 1 (* (- 1) (exp 2 u1)))
                         (* 1 (exp 2 u2)))
                      (exp 2 0)))
                   (* 1 0))
                (exp 2 z))) (* 1 8096))
             (<= (* 1 (* 1 u1)) (* 1 (* 1 u0)))
             (<= (* 1 (* 1 u2)) (* 1 (* 1 u1)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u2))))
  iter(2)= (and
             (= (+ (* (* (* (* (* (- 1) (exp 2 u1)) 1) 1) (exp 2 z)) 1)
                (* (* (* (* (exp 2 u0) 1) 1) (exp 2 z)) 1)
                (* (* (* (* (exp 2 u2) 1) 1) (exp 2 z)) 1)) 8096)
             (<= u1 u0)
             (<= u2 u1)
             (<= 0 u2))
  iter(3)= (and
             (= (+ (* (- 1) (exp 2 u1) (exp 2 z)) (exp 2 (+ u0 z))
                (exp 2 (+ u2 z))) 8096)
             (<= u1 u0)
             (<= u2 u1)
             (<= 0 u2))
  iter(4)= (and
             (= (+ (* (- 1) (exp 2 (+ u1 z))) (exp 2 (+ u0 z))
                (exp 2 (+ u2 z))) 8096)
             (<= u1 u0)
             (<= u2 u1)
             (<= 0 u2))
  iter(1)= (and
             (= (* 1
                (* (+ (* 1
                      (* (+ (* 1 (exp 2 u3)) (* 1 (* (- 1) (exp 2 u4)))
                         (* 1 (exp 2 u5)))
                      (exp 2 1)))
                   (* 1 1))
                (exp 2 z))) (* 1 8096))
             (<= (* 1 (* 1 u4)) (* 1 (* 1 u3)))
             (<= (* 1 (* 1 u5)) (* 1 (* 1 u4)))
             (<= (* 1 (* 1 0)) (* 1 (* 1 u5))))
  iter(2)= (and
             (= (+ (* (* 1 (exp 2 z)) 1)
                (* (* (* (* (* (- 1) (exp 2 u4)) 2) 1) (exp 2 z)) 1)
                (* (* (* (* (exp 2 u3) 2) 1) (exp 2 z)) 1)
                (* (* (* (* (exp 2 u5) 2) 1) (exp 2 z)) 1)) 8096)
             (<= u4 u3)
             (<= u5 u4)
             (<= 0 u5))
  iter(3)= (and
             (= (+ (* (- 2) (exp 2 u4) (exp 2 z)) (* 2 (exp 2 u3) (exp 2 z))
                (* 2 (exp 2 u5) (exp 2 z)) (exp 2 z)) 8096)
             (<= u4 u3)
             (<= u5 u4)
             (<= 0 u5))
  iter(4)= (and
             (= (+ (* (- 2) (exp 2 (+ u4 z))) (* 2 (exp 2 (+ u3 z)))
                (* 2 (exp 2 (+ u5 z))) (exp 2 z)) 8096)
             (<= u4 u3)
             (<= u5 u4)
             (<= 0 u5))
  $ timeout 2 $RUN -flat 2 | grep -v assert | sed -r '/^\s*$/d'
          (and
            (exists (z)
            (and
              (exists (u1)
              (and
                (exists (u0)
                (and
                  (= (+ eee2 (* (- 1) u0) (* (- 1) z) )  0)
                  (<= (+ (* (- 1) u0) u1 )  0)
                  )
                (= (+ eee1 (* (- 1) u1) (* (- 1) z) )  0)
                (<= (+ (* (- 1) u1) u2 )  0)
                )
              (= (+ eee3 (* (- 1) u2) (* (- 1) z) )  0)
              )
            (= (+ (* (- 1) pow2(eee1)) pow2(eee2) pow2(eee3) )  8096)
            (<= (* (- 1) u2)  0)
            )
  )
  sat ; under II
