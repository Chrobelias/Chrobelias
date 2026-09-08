QF_EIA tests with x, exp x and exp exp x using only NFAs

Dynamic bres/bstates solve this under default flags (it used to time out):

  $ Chro -q -no-model ../manyexp/issue188.smt2
  sat (under int)
  no-model mode

QF_EIA tests with x, exp x and exp exp x using underapproximations

  $ timeout 5 Chro -bres 2 -bstates 10 ../manyexp/issue188.smt2 
  sat (nfa)
  (
     (define-fun t () Int
      0)
     (define-fun x () Int
      3)
     (define-fun y () Int
      8)
     (define-fun z () Int
      256)
  )

The same tests with three exponentiated vars in the LSB mode

  $ Chro -lsb -bres 2 -bstates 10 ../manyexp/issue188.smt2
  sat (nfa)
  (
     (define-fun t () Int
      0)
     (define-fun x () Int
      3)
     (define-fun y () Int
      8)
     (define-fun z () Int
      256)
  )

  $ cat > test1.smt2 <<-EOF
  > (set-logic ALL)
  > (set-info :status sat)
  > 
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun t () Int)
  > (assert (= (mod (+ x (** 2 x) (** 2 (** 2 x))) 100) t))
  > (assert (<= t 45))
  > (assert (>= t 35))
  > (check-sat)
  > EOF
  $ Chro -bres 2 -bstates 10 test1.smt2
  sat (under int)
