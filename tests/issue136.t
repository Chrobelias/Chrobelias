  $ cat > testS1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (assert (str.in.re x (re.+ (str.to.re "0"))))
  > (assert (= (str.to.int x) (str.to.int y)))
  > (assert (< 1 (str.len x)))
  > (assert (< (str.len x) (str.len y)))
  > (assert (< 1000 (str.len y)))
  > (assert (>= (exp 10 n) (str.len x)))
  > (assert (>= (exp 10 n) (str.len y)))
  > ;(assert (= n 10))
  > (check-sat)
  > (get-model)
  > EOF
  $ timeout 2 Chro -no-over-approx -bound 0 testS1.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)
  ; model is TOO big
