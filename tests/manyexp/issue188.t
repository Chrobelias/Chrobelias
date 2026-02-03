QF_EIA tests with x, exp x and exp exp x using only NFAs

  $ timeout 5 Chro ../manyexp/issue188.smt2 
  timeout
  [124]

QF_EIA tests with x, exp x and exp exp x using underapproximations

  $ timeout 5 Chro -bres 2 -bstates 10 ../manyexp/issue188.smt2 
  sat (nfa)
  ((define-fun t () (_ Int) 0)
   (define-fun x () (_ Int) 3)
   (define-fun y () (_ Int) 8)
   (define-fun z () (_ Int) 256))

The same tests with three exponentiated vars in the LSB mode

  $ Chro -lsb -bres 2 -bstates 10 ../manyexp/issue188.smt2
  sat (nfa)
  ((define-fun t () (_ Int) 0)
   (define-fun x () (_ Int) 3)
   (define-fun y () (_ Int) 8)
   (define-fun z () (_ Int) 256))

  $ cat > test1.smt2 <<-EOF
  > (set-logic ALL)
  > (set-info :status sat)
  > 
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun t () Int)
  > (assert (= (mod (+ x (exp 2 x) (exp 2 (exp 2 x))) 100) t))
  > (assert (<= t 45))
  > (assert (>= t 35))
  > (check-sat)
  > EOF
  $ Chro -bres 2 -bstates 10 test1.smt2
  sat (nfa)
