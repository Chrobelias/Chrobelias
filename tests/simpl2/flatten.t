  $ cat > testS1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (= (** x 2) 32))
  > (check-sat)
  > EOF
  $ CHRO_DEBUG=simpl Chro -bound 1 --dsimpl --stop-after pre-simpl testS1.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (= (+ (- 32) (** x 2)) 0)
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    fixed-point
  
