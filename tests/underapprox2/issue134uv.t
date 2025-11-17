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
  unknown (nfa; unimplemented (= (+ (* (- 1) a (exp 2 z)) (* (- 1) (exp 2 (+ u z)))
                   (* (- 1) (exp 2 (+ v z)))) (- 113)))

  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (assert (= 52 (* x (exp 2 y)) ))
  > (check-sat)
  > EOF

$ export CHRO_DEBUG=1
  $ timeout 2 Chro -no-over-approx -bound -1 -dsimpl -flat 0 -amin 5 -amax 5 -lsb  1.smt2 #-stop-after simpl
  (assert (exists (u1)
          (and
            (= (+ eee2 (* (- 1) u1) (* (- 1) y) )  0)
            (= (+ (* (- 1) pow2(eee2)) (* (- 5) pow2(y)) )  -52)
            )
  )
  (assert (<= (+ eee2 (* (- 1) pow2(eee2)) )  -1) )
  (assert (<= (+ (* (- 1) eee2) pow2(y) )  0) )
  (assert (<= (+ y (* (- 1) pow2(y)) )  -1) )
  
  sat (under II)

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
  $ CHRO_DEBUG=1 $RUN -amin 1 -amax 1 -flat 1 -stop-after presimpl
  iter(1)= (and
             (= (* x (exp 2 z)) 3076))
  iter(2)= (= (* x (exp 2 z)) 3076)
  vars_for_under2: x
  
  all as: 1
  
  iter(1)= (and
             (= (+ (* (exp 2 u1) (exp 2 z)) (* (* (- 1) (exp 2 v2)) (exp 2 z))
                (* 1 (exp 2 z))) 3076)
             (<= v2 u1))
  iter(2)= (and
             (= (+ (* (- 1) (exp 2 v2) (exp 2 z)) (exp 2 z) (exp 2 (+ u1 z))) 3076)
             (<= v2 u1))
  iter(3)= (and
             (= (+ (* (- 1) (exp 2 (+ v2 z))) (exp 2 z) (exp 2 (+ u1 z))) 3076)
             (<= v2 u1))
The test below should be SAT but there is an issue #143
which is needed to be fixed first
  $ timeout 2 $RUN -amin 1 -amax 1 -flat 1 | grep -v assert | sed -r '/^\s*$/d'
          (and
            (exists (u1)
            (and
              (= (+ eee4 (* (- 1) u1) (* (- 1) z) )  0)
              (<= (+ (* (- 1) u1) v2 )  0)
              )
            (= (+ eee3 (* (- 1) v2) (* (- 1) z) )  0)
            (= (+ (* (- 1) pow2(eee3)) pow2(eee4) pow2(z) )  3076)
            )
  )
  unknown (under II)
  unknown (nfa; unable to multiply var by var: (pow2(z) )  with (x )
  )
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
  $ timeout 2 $RUN -amin 1 -amax 1 -lsb 3.smt2 -flat 1 | grep -v assert | sed -r '/^\s*$/d'
          (and
            (exists (u1)
            (and
              (= (+ eee4 (* (- 1) u1) (* (- 1) z) )  0)
              (<= (+ (* (- 1) u1) v2 )  0)
              )
            (= (+ eee3 (* (- 1) v2) (* (- 1) z) )  0)
            (= (+ (* (- 1) pow2(eee3)) pow2(eee4) pow2(z) )  3073)
            )
  )
  sat (under II)

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
             (= (+ (* (exp 2 u1) (exp 2 z)) (* (* (- 1) (exp 2 u2)) (exp 2 z))
                (* (exp 2 u3) (exp 2 z))) 8096)
             (<= u2 u1)
             (<= u3 u2)
             (<= 0 u3))
  iter(2)= (and
             (= (+ (* (- 1) (exp 2 u2) (exp 2 z)) (exp 2 (+ u1 z))
                (exp 2 (+ u3 z))) 8096)
             (<= u2 u1)
             (<= u3 u2)
             (<= 0 u3))
  iter(3)= (and
             (= (+ (* (- 1) (exp 2 (+ u2 z))) (exp 2 (+ u1 z))
                (exp 2 (+ u3 z))) 8096)
             (<= u2 u1)
             (<= u3 u2)
             (<= 0 u3))
  $ timeout 2 $RUN -flat 2 | grep -v assert | sed -r '/^\s*$/d'
          (and
            (exists (z)
            (and
              (exists (u2)
              (and
                (exists (u1)
                (and
                  (= (+ eee5 (* (- 1) u1) (* (- 1) z) )  0)
                  (<= (+ (* (- 1) u1) u2 )  0)
                  )
                (= (+ eee4 (* (- 1) u2) (* (- 1) z) )  0)
                (<= (+ (* (- 1) u2) u3 )  0)
                )
              (= (+ eee6 (* (- 1) u3) (* (- 1) z) )  0)
              )
            (= (+ (* (- 1) pow2(eee4)) pow2(eee5) pow2(eee6) )  8096)
            (<= (* (- 1) u3)  0)
            )
  )
  sat (under II)
