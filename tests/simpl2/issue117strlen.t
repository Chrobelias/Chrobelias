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
  $ CHRO_DEBUG=simpl:nfa Chro -no-over -bound -1 --dpresimpl --stop-after presimpl len1.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    iter(1)= (and
             (<= (+ 2 (* (- 1) (str.len x))) 0)
             (<= (+ 1 (str.len x) (* (- 1) (str.len y))) 0)
             (<= (+ 1001 (* (- 1) (str.len y))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (and
             (<= (+ 1 (str.len x) (* (- 1) (str.len y))) 0)
             (<= (+ 2 (* (- 1) (str.len x))) 0)
             (<= (+ 1001 (* (- 1) (str.len y))) 0))
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (and
             (<= (+ 1 (str.len x) (* (- 1) (str.len y))) 0)
             (<= (+ 2 (* (- 1) (str.len x))) 0)
             (<= (+ 1001 (* (- 1) (str.len y))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (and
             (<= (+ 1 @strlenx (* (- 1) @strleny)) 0)
             (<= (+ 2 (* (- 1) @strlenx)) 0)
             (<= (+ 1001 (* (- 1) @strleny)) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ 1001 (* (- 1) (str.len y))) 0)
             (<= (+ 1 (str.len x) (* (- 1) (str.len y))) 0)
             (<= (+ 2 (* (- 1) (str.len x))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (and
             (<= (+ 1 (str.len x) (* (- 1) (str.len y))) 0)
             (<= (+ 2 (* (- 1) (str.len x))) 0)
             (<= (+ 1001 (* (- 1) (str.len y))) 0))
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (and
             (<= (+ 1 (str.len x) (* (- 1) (str.len y))) 0)
             (<= (+ 2 (* (- 1) (str.len x))) 0)
             (<= (+ 1001 (* (- 1) (str.len y))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ 1 strlenx (* (- 1) strleny)) 0)
             (<= (* (- 1) strlenx) 0)
             (<= (* (- 1) strleny) 0)
             (<= (+ 2 (* (- 1) strlenx)) 0)
             (<= (+ 1001 (* (- 1) strleny)) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (and
             (<= (+ 1 strlenx (* (- 1) strleny)) 0)
             (<= (+ 2 (* (- 1) strlenx)) 0)
             (<= (+ 1001 (* (- 1) strleny)) 0)
             (<= (* (- 1) strlenx) 0)
             (<= (* (- 1) strleny) 0))
  [+simpl]
    fixed-point
  
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
