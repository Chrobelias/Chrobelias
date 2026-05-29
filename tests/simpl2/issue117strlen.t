  $ cat > len1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > 
  > (assert (< 1000 (str.len y)))
  > (assert (< (str.len x) (str.len y)))
  > (assert (< 1 (str.len x)))
  > (check-sat)
  > (get-model)
  > EOF
$ ls
$ cat len1.smt2
  $ CHRO_DEBUG=1 Chro -no-over -bound -1 --dpresimpl --stop-after presimpl len1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (<= (+ 2 (* (- 1) (str.len x))) 0)
             (<= (+ 1 (str.len x) (* (- 1) (str.len y))) 0)
             (<= (+ 1001 (* (- 1) (str.len y))) 0))
  Alphabet with extra char: 0
  
  iter(2)= (and
             (<= (+ 1 (str.len x) (* (- 1) (str.len y))) 0)
             (<= (+ 2 (* (- 1) (str.len x))) 0)
             (<= (+ 1001 (* (- 1) (str.len y))) 0))
  fixed-point
  
  Filtered unknown: (and
                      (<= (+ 1 (str.len x) (* (- 1) (str.len y))) 0)
                      (<= (+ 2 (* (- 1) (str.len x))) 0)
                      (<= (+ 1001 (* (- 1) (str.len y))) 0))
  
  These atomic formulas are unsupported:
  
  After string approximations: (and
                                 (<= (+ 1 (str.len x) (* (- 1) (str.len y))) 0)
                                 (<= (+ 2 (* (- 1) (str.len x))) 0)
                                 (<= (+ 1001 (* (- 1) (str.len y))) 0))
  
  DPLL: Theory ast: (and
                      (<= (+ 1 (str.len x) (* (- 1) (str.len y))) 0)
                      (<= (+ 2 (* (- 1) (str.len x))) 0)
                      (<= (+ 1001 (* (- 1) (str.len y))) 0))
  
  DPLL: into Z3 added: (and
                         (P $0)
                         (P $1)
                         (P $2))
  
  Basic simplifications:
  
  iter(1)= (and
             (<= (+ 1001 (* (- 1) (str.len y))) 0)
             (<= (+ 1 (str.len x) (* (- 1) (str.len y))) 0)
             (<= (+ 2 (* (- 1) (str.len x))) 0))
  Alphabet with extra char: 0
  
  iter(2)= (and
             (<= (+ 1 (str.len x) (* (- 1) (str.len y))) 0)
             (<= (+ 2 (* (- 1) (str.len x))) 0)
             (<= (+ 1001 (* (- 1) (str.len y))) 0))
  fixed-point
  
  Arithmetization gave 1 asts
  
  Arithmetized: (and
                  (<= (+ 1 strlenx (* (- 1) strleny)) 0)
                  (<= (* (- 1) strlenx) 0)
                  (<= (* (- 1) strleny) 0)
                  (<= (+ 2 (* (- 1) strlenx)) 0)
                  (<= (* (- 1) strlenx) 0)
                  (<= (+ 1001 (* (- 1) strleny)) 0)
                  (<= (* (- 1) strleny) 0))
  
  Basic simplifications:
  
  iter(1)= (and
             (<= (+ 1 strlenx (* (- 1) strleny)) 0)
             (<= (* (- 1) strlenx) 0)
             (<= (* (- 1) strleny) 0)
             (<= (+ 2 (* (- 1) strlenx)) 0)
             (<= (* (- 1) strlenx) 0)
             (<= (+ 1001 (* (- 1) strleny)) 0)
             (<= (* (- 1) strleny) 0))
  Alphabet with extra char: 0
  
  iter(2)= (and
             (<= (+ 1 strlenx (* (- 1) strleny)) 0)
             (<= (+ 2 (* (- 1) strlenx)) 0)
             (<= (+ 1001 (* (- 1) strleny)) 0)
             (<= (* (- 1) strlenx) 0)
             (<= (* (- 1) strleny) 0))
  fixed-point
  
  Lightweight run:
  (and
                     (<= (+ 1 strlenx (* (- 1) strleny)) 0)
                     (<= (+ 2 (* (- 1) strlenx)) 0)
                     (<= (+ 1001 (* (- 1) strleny)) 0)
                     (<= (* (- 1) strlenx) 0)
                     (<= (* (- 1) strleny) 0))
  $ Chro -no-over -bound -1 len1.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)
  (
     (define-fun x () String
      "00")
     (define-fun y () String
      "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
  )
