  $ export CHRO_DEBUG=simpl
  $ timeout 2 Chro -no-over -bound 0 --dsimpl ../../benchmarks/QF_LIA/PURRS/purrs02.smt2 --stop-after presimpl #| sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (distinct (+ (* (+ x n) (** 2 n))
                       (* (- 2) (+ (- 1) x n) (** 2 (+ (- 1) n)))
                       (* (- 1) (** 2 n))) 0)
             (<= (+ 1 (* (- 1) n)) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (and
             (distinct (+ (* n (** 2 n)) (* x (** 2 n))
                       (* (* (- 1) (** 2 (+ (- 1) n))) (- 2))
                       (* (* n (** 2 (+ (- 1) n))) (- 2))
                       (* (* x (** 2 (+ (- 1) n))) (- 2)) (* (- 1) (** 2 n))) 0)
             (<= (+ 1 (* (- 1) n)) 0))
  [+simpl]
    iter(3)= (and
             (distinct (+ (* (- 2) n (** 2 (+ (- 1) n)))
                       (* (- 2) x (** 2 (+ (- 1) n))) (* n (** 2 n))
                       (* x (** 2 n))) 0)
             (<= (+ 1 (* (- 1) n)) 0))
  [+simpl]
    iter(4)= (not True)
  [+simpl]
    fixed-point
  
  [+simpl]
    contradicting clause: (distinct (+ (* (+ x n) (** 2 n))
                                  (* (- 2) (+ (- 1) x n) (** 2 (+ (- 1) n)))
                                  (* (- 1) (** 2 n))) 0)
  [+simpl]
    contradicting env:  
  [+simpl]
    unsat core: (distinct (+ (* (+ x n) (** 2 n))
                        (* (- 2) (+ (- 1) x n) (** 2 (+ (- 1) n)))
                        (* (- 1) (** 2 n))) 0)
  
  [+simpl]
    Basic simplifications:
  


