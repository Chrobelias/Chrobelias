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
  $ CHRO_DEBUG=1 Chro -no-over -bound -1 --pre-simpl --dpresimpl --stop-after presimpl len1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (<= (+ 1 1) (str.len x))
             (<= (+ (str.len x) 1) (str.len y))
             (<= (+ 1000 1) (str.len y)))
  iter(2)= (and
             (<= 2 (str.len x))
             (<= 1001 (str.len y))
             (<= (+ 1 (str.len x)) (str.len y)))
  fixed-point
  
  Alphapbet with extra char: #
  Alphapbet with extra char: #
  Arithmetization gives 1 asts...
  Arithmetized: (and
                  (<= 2 strlenx)
                  (<= 0 strlenx)
                  (<= 1001 strleny)
                  (<= 0 strleny)
                  (<= (+ 1 strlenx) strleny)
                  (<= 0 strlenx)
                  (<= 0 strleny))
  
  Basic simplifications:
  
  iter(1)= (and
             (<= 2 strlenx)
             (<= 0 strlenx)
             (<= 1001 strleny)
             (<= 0 strleny)
             (<= (+ 1 strlenx) strleny)
             (<= 0 strlenx)
             (<= 0 strleny))
  iter(2)= (and
             (<= 0 strlenx)
             (<= 0 strleny)
             (<= 2 strlenx)
             (<= 1001 strleny)
             (<= (+ 1 strlenx) strleny))
  fixed-point
  
  Light run:
  (and
               (<= 0 strlenx)
               (<= 0 strleny)
               (<= 2 strlenx)
               (<= 1001 strleny)
               (<= (+ 1 strlenx) strleny))
  $ Chro -no-over -bound -1 len1.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)
  (
     (define-fun x () String
      "00")
     (define-fun y () String
      "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
  )
