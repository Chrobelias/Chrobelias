Two atoms whose rewrites undo each other: the order of the terms of a sum
alternates between iterations, and the simplifier used to iterate until
killed (reduced from LoAT heapsort.c.koat_158).

  $ cat > cycle.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun i10 () Int)
  > (declare-fun a () Int)
  > (declare-fun b () Int)
  > (assert (>= a 1))
  > (assert (>= b 1))
  > (assert (<= (+ (- i10) (- (exp 2 b)) (* 2 (exp 2 (+ a b)))) 0))
  > (assert (<= (+ (- i10) (- (exp 2 (- b 1))) (exp 2 (+ a b))) 0))
  > (check-sat)
  > EOF

  $ timeout 10 Chro -no-model cycle.smt2
  sat (under int)
