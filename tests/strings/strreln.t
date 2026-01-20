  $ cat > test1.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (set-info :status unsat)
  > (declare-const x String)
  > (declare-const y String)
  > 
  > (assert (>= (str.to_int x) 0))
  > (assert (> (str.len x) 0))
  > (assert (>= (str.to_int y) 0))
  > (assert (> (str.len y) 0))
  > 
  > (assert (str.in_re (str.++ x y) (re.* (re.+ (re.++ (str.to_re "55") (str.to_re "405"))))))
  > 
  > (assert (= (+ (* 5 (str.len x)) (* 3 (str.len y)) (* 4 (str.to_int y))) 85))
  > 
  > (check-sat)
  > EOF
  $ Chro test1.smt2
  unsat (nfa)

  $ cat > test2.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (set-info :status sat)
  > 
  > (declare-const x String)
  > (declare-const y String)
  > 
  > (assert (>= (str.to_int x) 0))
  > (assert (> (str.len x) 0))
  > (assert (>= (str.to_int y) 0))
  > (assert (> (str.len y) 0))
  > 
  > (assert (str.in_re (str.++ x y) (re.+ (re.++ (str.to_re "62") (str.to_re "52")))))
  > 
  > (assert (>= (+ (* 7 (str.len y)) (* (- 10) (str.to_int x))) 57))
  > 
  > (check-sat)
  > EOF
  $ Chro test2.smt2
  sat (nfa)

