  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= (+ z y) 52))
  > (assert (= (+ z x) 32))
  > (assert (< 111111 (+ (** 2 x) (** 2 y)) ))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro -no-over -bound -1 --dsimpl --stop-after pre-simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ 111112 (* (- 1) (** 2 x)) (* (- 1) (** 2 y))) 0)
             (= (+ (- 32) z x) 0)
             (= (+ (- 52) z y) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (and
             (= (+ (- 52) y z) 0)
             (= (+ (- 32) x z) 0)
             (<= (+ 111112 (* (- 1) (** 2 x)) (* (- 1) (** 2 y))) 0))
  [+simpl]
    fixed-point
  
