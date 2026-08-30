Model extraction prefers the numerically smallest witness: the BFS in
Nfa.any_path expands cheap symbols first, so among the shortest accepting
paths the lexicographically (and on Msb automata numerically) smallest one
wins. Before this, a length-bounded variable got an arbitrary value of the
minimal digit width -- the StrRElnc long benchmarks printed ~9000-character
models for a 1000-character bound, and the shrinking fallback's retry cap
of 120 then contradicted the explicit [str.len >= 1000], reporting the
misleading "no short model" on instances with plenty of short models.

A 1000-character length bound yields a near-minimal model, not one
inflated to the -huge cap:

  $ cat > long.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (assert (>= (str.to_int x) 0))
  > (assert (>= (str.len x) 1000))
  > (assert (str.in_re x (re.++ (re.* (str.to_re "0")) (str.to_re "4653"))))
  > (check-sat)
  > (get-model)
  > EOF
  $ CHRO_NO_PARALLEL=1 Chro long.smt2 | awk 'NR==1 {print} /define-fun/ {getline; gsub(/[ "]/,""); print "model length:", length($0)}'
  sat (nfa)
  model length: 1001

A known gap, kept as a TODO: this instance (StrRElnc/REln/long
benchmark_long_v2_w02_n01) provably has a short model -- the witness
x = "971" repeated 1677 times (5031 characters), y = "73" repeated 500
times (1000 characters) satisfies every assert and is accepted as a
ground model by both z3 and cvc5 -- yet we answer sat and then fail to
reconstruct any model. The exponent values are already committed
minimally (str.len x = 5031, str.len y = 1000), but the final string
rebuild pins a length by encoding the constant 10^5031 into an
automaton, which exceeds every size limit. We need a smarter way to
find short models: rebuild the string contents from the chosen path
pieces directly instead of round-tripping the length through a
10^length integer constant.

  $ cat > gap.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (>= (str.to_int x) 0))
  > (assert (>= (str.to_int y) 0))
  > (assert (>= (str.len y) 1000))
  > (assert (>= (str.len x) 1000))
  > (assert (str.in_re y (re.* (str.to_re "73"))))
  > (assert (str.in_re x (re.+ (re.+ (re.++ (re.+ (str.to_re "9")) (str.to_re "71"))))))
  > (assert (= (+ (str.len x) (* (- 5) (str.len y))) 31))
  > (assert (> (+ (* 9 (str.to_int x)) (- (str.to_int y))) 23))
  > (check-sat)
  > (get-model)
  > EOF
  $ CHRO_NO_PARALLEL=1 Chro gap.smt2
  sat (nfa)
  no short model found (nfa)
