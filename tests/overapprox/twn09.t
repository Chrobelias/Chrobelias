LoAT twn09.koat_2 reduced: unsat, because 5^(n-1) <= 16^(n-1) and
16^(n-1) = (4^(n-1))^2. The NIA formula that overapproximates it gets these
as constraints between powers; before them there was no answer within 20 s.

  $ cat > twn09.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun n () Int)
  > (declare-fun a () Int)
  > (declare-fun i () Int)
  > (declare-fun j () Int)
  > (declare-fun k () Int)
  > (assert (>= n 1))
  > (assert (> i 0))
  > (assert (>= j 1))
  > (assert (= (* 2 a) (+ (* 2 i) j (* j j))))
  > (assert (< a (* k k)))
  > (assert (> (+ (* 528 (exp 4 (- n 1)) k k)
  >               (* 60 (exp 5 (- n 1)) k k k k)
  >               (* (- 192) (exp 16 (- n 1)) k k k k)
  >               (* (- 660) a (exp 5 (- n 1))))
  >            0))
  > (check-sat)
  > EOF

  $ timeout 10 Chro -no-model twn09.smt2
  unsat (over)
