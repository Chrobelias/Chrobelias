  $ cp koat36mini.smt2 input.smt2

$ cat input.smt2
  $ export CHRO_DEBUG=simpl
  $ timeout 2 Chro -bound 0 --dsimpl input.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ 1 it88) 0)
             (<= (+ (- 1) i3) 0)
             (= (+ 2 (* (- 2) i3) (* 2 it64)) 0)
             (= (+ it64 (* (- 2) (exp 2 it57) i3)) 0)
             (= (+ it63 (* (- 1) (exp 2 it57) i3)) 0)
             (= (+ it60 (* (- 1) it21) (* (- 1) it57)) 0)
             (= (+ (- 2) it21 (* (- 3) it19) (* (- 1) i2)) 0)
             (= (+ 1 it19 it23 (* (- 1) i4)) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        it21 -> (+ 2 i2 (* 3 it19));
        it60 -> (+ it21 it57);
        it63 -> (* i3 (exp 2 it57));
        it64 -> (* 2 i3 (exp 2 it57));
        
  [+simpl]
    iter(2)= (and
             (= (+ (- 2) (* (- 3) it19) (* (- 1) i2) it21) 0)
             (= (+ 1 (* (- 1) i4) it19 it23) 0)
             (= (+ 2 (* (- 2) i3) (* 2 it64)) 0)
             (= (+ it63 (* (- 1) i3 (exp 2 it57))) 0)
             (= (+ it64 (* (- 2) i3 (exp 2 it57))) 0)
             (= (+ (* (- 1) it21) (* (- 1) it57) it60) 0)
             (<= (+ (- 1) i3) 0)
             (<= (+ 1 it88) 0))
  [+simpl]
    Something ready to substitute
        it19 -> (+ (- 1) i4 (- it23));
        it21 -> (+ 2 i2 (* 3 it19));
        it60 -> (+ it21 it57);
        it63 -> (* i3 (exp 2 it57));
        it64 -> (* 2 i3 (exp 2 it57));
        
  [+simpl]
    iter(3)= (and
             (= (+ 1 (* (- 1) i4) it19 it23) 0)
             (= (+ 2 (* (- 2) i3) (* 4 i3 (exp 2 it57))) 0)
             (= (+ it21 (* (- 1) it57) (* 2 (- 1)) it57 (* i2 (- 1))
                (* (* 3 it19) (- 1))) 0)
             (<= (+ (- 1) i3) 0)
             (<= (+ 1 it88) 0))
  [+simpl]
    iter(4)= (and
             (= (+ 2 (* (- 2) i3) (* 4 i3 (exp 2 it57))) 0)
             (= (+ (* (- 1) it57) (* 3 it19) it57 (* (* (- 1) 3) (- 1))
                (* (* i4 3) (- 1)) (* (* (* (- 1) it23) 3) (- 1))) 0)
             (<= (+ (- 1) i3) 0)
             (<= (+ 1 it88) 0))
  [+simpl]
    iter(5)= (and
             (= (+ 2 (* (- 2) i3) (* 4 i3 (exp 2 it57))) 0)
             (= (+ 3 (* (- 3) i4) (* 3 it23) (* (- 1) 3) (* i4 3)
                (* (* (- 1) it23) 3)) 0)
             (<= (+ (- 1) i3) 0)
             (<= (+ 1 it88) 0))
  [+simpl]
    iter(6)= (and
             (= (+ 2 (* (- 2) i3) (* 4 i3 (exp 2 it57))) 0)
             (<= (+ (- 1) i3) 0)
             (<= (+ 1 it88) 0))
  [+simpl]
    fixed-point
  
  sat (under int)
