$ export CHRO_DEBUG=1
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "123" x) (str.++ y x)))
  > (assert (= y "321"))
  > (check-sat)
  > EOF

  $ CHRO_DEBUG=1 Chro -pre-simpl -dpresimpl -dsimpl -stop-after simpl 1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= eeb6 (str.len x))
             (= eeb2 (str.len x))
             (= %1 (str.from_int eeb5))
             (= %0 (str.from_int eeb1))
             (= eeb6 eeb2)
             (= eeb5 (+ (* eeb7 (exp 10 eeb6)) eeb8))
             (= eeb8 (str.to.int x))
             (= eeb7 123)
             (= eeb2 eeb2)
             (= eeb1 (+ (* eeb3 (exp 10 eeb2)) eeb4))
             (= eeb4 (str.to.int x))
             (= eeb3 (str.to.int y))
             (= y "321")
             (= %1 %0))
  Something ready to substitute
        %1 -> %0
        eeb6 -> eeb2
        eeb7 -> 123
        y -> "321"
  
  iter(2)= (and
             (= %0 (str.from_int eeb1))
             (= %1 %0)
             (= %1 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb3 (str.to.int y))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 eeb2)
             (= eeb6 (str.len x))
             (= eeb7 123)
             (= eeb8 (str.to.int x))
             (= y "321"))
  iter(3)= (and
             (= %0 (str.from_int eeb1))
             (= %0 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb3 (str.to.int "321"))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* 123 (exp 10 eeb2))))
             (= eeb8 (str.to.int x)))
  iter(4)= (and
             (= %0 (str.from_int eeb1))
             (= %0 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb3 321)
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* 123 (exp 10 eeb2))))
             (= eeb8 (str.to.int x)))
  Something ready to substitute
        %1 -> %0
        eeb3 -> 321
        eeb6 -> eeb2
        eeb7 -> 123
        y -> "321"
  
  iter(5)= (and
             (= %0 (str.from_int eeb1))
             (= %0 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb3 321)
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* 123 (exp 10 eeb2))))
             (= eeb8 (str.to.int x)))
  iter(6)= (and
             (= %0 (str.from_int eeb1))
             (= %0 (str.from_int eeb5))
             (= eeb1 (+ eeb4 (* 321 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* 123 (exp 10 eeb2))))
             (= eeb8 (str.to.int x)))
  (and
    (= %0 (str.from_int eeb1))
    (= %0 (str.from_int eeb5))
    (= eeb1 (+ eeb4 (* 321 (exp 10 eeb2))))
    (= eeb2 (str.len x))
    (= eeb4 (str.to.int x))
    (= eeb5 (+ eeb8 (* 123 (exp 10 eeb2))))
    (= eeb8 (str.to.int x)))
  iter(1)= (and
             (and
               (= (+ (* (- 1) eeb1) (* 1 %0)) 0))
             (and
               (= (+ (* (- 1) eeb5) (* 1 %0)) 0))
             (and
               (= (+ (* (- 321) (exp 10 eeb2)) (* (- 1) eeb4) (* 1 eeb1)) 0))
             (and
               (= (+ (* 1 eeb2) (* (- 1) %2)) 0)
               (= %3 (chrob.len x))
               (= (+ (* 1 (exp 10 %2)) (* (- 1) %3)) 1))
             (and
               (= eeb4 (str.to.int x)))
             (and
               (= (+ (* (- 123) (exp 10 eeb2)) (* (- 1) eeb8) (* 1 eeb5)) 0))
             (and
               (= eeb8 (str.to.int x))))
  iter(2)= (and
             (= %3 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ %0 (* (- 1) eeb1)) 0)
             (= (+ %0 (* (- 1) eeb5)) 0)
             (= (+ eeb1 (* (- 321) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
             (= (+ eeb2 (* (- 1) %2)) 0)
             (= (+ eeb5 (* (- 123) (exp 10 eeb2)) (* (- 1) eeb8)) 0)
             (= (+ (* (- 1) %3) (exp 10 %2)) 1))
  Something ready to substitute
        %0 -> eeb1
        eeb1 -> (+ (* (* (- 321) (exp 10 eeb2)) (- 1)) (* (- eeb4) (- 1)))
        eeb2 -> %2
        eeb5 -> (+ (* (* (- 123) (exp 10 %2)) (- 1)) (* (- eeb8) (- 1)))
  
  iter(3)= (and
             (= %3 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ %0 (* (- 1) eeb1)) 0)
             (= (+ %0 (* (- 1) eeb5)) 0)
             (= (+ eeb1 (* (- 321) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
             (= (+ eeb2 (* (- 1) %2)) 0)
             (= (+ eeb5 (* (- 123) (exp 10 eeb2)) (* (- 1) eeb8)) 0)
             (= (+ (* (- 1) %3) (exp 10 %2)) 1))
  iter(4)= (and
             (= %3 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ eeb1 (* (* (* (- 321) (exp 10 eeb2)) (- 1)) (- 1))
                (* (* (* (- 1) eeb4) (- 1)) (- 1))) 0)
             (= (+ eeb1 (* (* (* (- 123) (exp 10 %2)) (- 1)) (- 1))
                (* (* (* (- 1) eeb8) (- 1)) (- 1))) 0)
             (= (+ (* (- 321) (exp 10 %2)) (* (- 1) eeb4)
                (* (* (- 321) (exp 10 eeb2)) (- 1)) (* (* (- 1) eeb4) (- 1))) 0)
             (= (+ (* (- 123) (exp 10 %2)) (* (- 1) eeb8)
                (* (* (- 123) (exp 10 %2)) (- 1)) (* (* (- 1) eeb8) (- 1))) 0)
             (= (+ (* (- 1) %3) (exp 10 %2)) 1))
  iter(5)= (and
             (= %3 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ (* (- 321) (exp 10 %2)) (* (- 1) eeb4)
                (* (* (- 321) (exp 10 eeb2)) (- 1)) (* (* (- 1) eeb4) (- 1))) 0)
             (= (+ (* (- 123) (exp 10 %2)) (* (- 1) eeb8)
                (* (* (- 321) (exp 10 eeb2)) (- 1)) (* (* (- 1) eeb4) (- 1))) 0)
             (= (+ (* (- 1) %3) (exp 10 %2)) 1))
  iter(6)= (and
             (= %3 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ eeb4 (* (- 1) eeb8) (* 198 (exp 10 %2))) 0)
             (= (+ (* (- 1) %3) (exp 10 %2)) 1))
  Something ready to substitute
        %0 -> eeb1
        eeb1 -> (+ (* (* (- 321) (exp 10 eeb2)) (- 1)) (* (- eeb4) (- 1)))
        eeb2 -> %2
        eeb4 -> (+ (* (- eeb8) (- 1)) (* (* 198 (exp 10 %2)) (- 1)))
        eeb5 -> (+ (* (* (- 123) (exp 10 %2)) (- 1)) (* (- eeb8) (- 1)))
  
  iter(7)= (and
             (= %3 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ eeb4 (* (- 1) eeb8) (* 198 (exp 10 %2))) 0)
             (= (+ (* (- 1) %3) (exp 10 %2)) 1))
  iter(8)= (and
             (= %3 (chrob.len x))
             (= eeb8 (str.to.int x))
             (= (+ (* (- 1) %3) (exp 10 %2)) 1)
             (= (+ (* (- 1) eeb8) (* 198 (exp 10 %2)) (* (* (- 1) eeb8) (- 1))
                (* (* 198 (exp 10 %2)) (- 1))) 0)
             (= (+ (* (* (- 1) eeb8) (- 1)) (* (* 198 (exp 10 %2)) (- 1))) (str.to.int x)))
  iter(9)= (and
             (= %3 (chrob.len x))
             (= eeb8 (str.to.int x))
             (= (+ eeb8 (* (- 198) (exp 10 %2))) (str.to.int x))
             (= (+ (* (- 1) %3) (exp 10 %2)) 1))
  (assert (exists (x)
          (and
            (exists (eeb8)
            (and
              (= eeb8 (chrob.to.int x))
              (= (+ eeb8 (* (- 1) x) (* (- 198) pow2(%2)) )  0)
              )
  
            (exists (%3)
            (and
              (= %3 (chrob.len x))
              (= (+ (* (- 1) %3) pow2(%2) )  1)
              )
  
            )
  )

  $ Chro 1.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)
