
  $ CHRO_DEBUG=simpl:nfa Chro -no-over -bound -1 --dpresimpl --stop-after presimpl issue117.smt2  | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ 100 (* (- 1) x) (* (- 1) y) (* (- 1) z) (* (- 1) u)
                 (* (- 1) v)) 0)
             (= (+ (** 2 (+ (- 5) x)) (* (- 1) v)) 0)
             (= (+ (** 2 (+ (- 3) x)) (* (- 1) u)) 0)
             (= (+ (** 2 (+ (- 1) x)) (* (- 1) z)) 0)
             (= (+ (** 2 x) (* (- 1) y)) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        u -> (** 2 (+ (- 3) x));
        v -> (** 2 (+ (- 5) x));
        y -> (** 2 x);
        z -> (** 2 (+ (- 1) x));
        
  [+simpl]
    iter(2)= (and
             (= (+ (* (- 1) u) (** 2 (+ (- 3) x))) 0)
             (= (+ (* (- 1) v) (** 2 (+ (- 5) x))) 0)
             (= (+ (* (- 1) y) (** 2 x)) 0)
             (= (+ (* (- 1) z) (** 2 (+ (- 1) x))) 0)
             (<= (+ 100 (* (- 1) x) (* (- 1) y) (* (- 1) z) (* (- 1) u)
                 (* (- 1) v)) 0))
  [+simpl]
    iter(3)= (<= (+ 100 (* (- 1) x) (* (- 1) (** 2 x))
               (* (- 1) (** 2 (+ (- 1) x))) (* (- 1) (** 2 (+ (- 3) x)))
               (* (- 1) (** 2 (+ (- 5) x)))) 0)
  [+simpl]
    fixed-point
  
  (and
    (= (+ 5 %0flat_pow3 (* (- 1) x)) 0)
    (= (+ 3 %0flat_pow2 (* (- 1) x)) 0)
    (= (+ 1 %0flat_pow1 (* (- 1) x)) 0)
    (<= (+ 100 (* (- 1) x) (* (- 1) (** 2 x)) (* (- 1) (** 2 %0flat_pow1))
        (* (- 1) (** 2 %0flat_pow2)) (* (- 1) (** 2 %0flat_pow3))) 0))
  $ Chro -no-over -bound -1 issue117.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)

