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
  $ OCAMLRUNPARAM='b=0' Chro -no-over -bound 6 -lsb 0.smt2
  sat (non-linear)

  $ cat > 1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (assert (= 52 (* x (exp 2 y)) ))
  > (check-sat)
  > EOF

$ export CHRO_DEBUG=1
  $ timeout 2 Chro -no-over -bound -1 --dsimpl -flat 0 -amin 5 -amax 5 -lsb  1.smt2 #--stop-after simpl
  sat (non-linear)

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

  $ export RUN='Chro -no-over -bound -1 -lsb --dsimpl 2.smt2'
  $ CHRO_DEBUG=1 $RUN -amin 1 -amax 1 -flat 1 --stop-after presimpl
  iter(1)= (and
             (= (* x (exp 2 z)) 3076))
  iter(2)= (= (* x (exp 2 z)) 3076)
  
  Non linear arithmetic between
  
  0) x
  
  
  
  Into Z3 goes: (bool.eq (int.mul x (int.pow 2 z)) 3076)
  
  sat (non-linear)
  ()
The test below should be SAT but there is an issue #143
which is needed to be fixed first
  $ timeout 2 $RUN -amin 1 -amax 1 -flat 1 | grep -v assert | sed -r '/^\s*$/d'
  sat (non-linear)
  ()

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
  $ export RUN='Chro -no-over -bound -1 -lsb --dsimpl 3.smt2'
  $ timeout 2 $RUN -amin 1 -amax 1 -lsb 3.smt2 -flat 1 | grep -v assert | sed -r '/^\s*$/d'
  sat (non-linear)
  ()

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
  $ export RUN='Chro -no-over -bound -1 -lsb --dsimpl 4.smt2'
  $ CHRO_DEBUG=1 $RUN -flat 2 --stop-after presimpl
  iter(1)= (and
             (= (* x (exp 2 z)) 8096))
  iter(2)= (= (* x (exp 2 z)) 8096)
  
  Non linear arithmetic between
  
  0) x
  
  
  
  Into Z3 goes: (bool.eq (int.mul x (int.pow 2 z)) 8096)
  
  sat (non-linear)
  ()
  $ timeout 2 $RUN -flat 2 | grep -v assert | sed -r '/^\s*$/d'
  sat (non-linear)
  ()
