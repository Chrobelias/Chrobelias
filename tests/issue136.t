  $ cat > 2.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (declare-const z Int)
  > (assert (str.in.re x (re.++ (str.to.re "1") (re.* (re.union (str.to.re "00") (str.to.re "99"))))))
  > (assert (str.in.re y (re.+ (str.to.re "9"))))
  > (assert (= (+ 2 (str.len x)) (str.to.int y)))
  > (assert (= (str.len y) (* 2 z)))
  > (check-sat)
  > (get-model)
  > EOF

  $ export CHRO_LONGEST_PATH=10
  $ timeout 2 Chro -no-over-approx -bound 0 2.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)
  ; model is TOO big
