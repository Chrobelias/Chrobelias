Model extraction prefers the numerically smallest witness (sorted BFS in
Nfa.any_path); the StrRElnc long benchmarks used to print ~9000-character
models for a 1000-character bound, or "no short model" outright.

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

Formerly failing (StrRElnc/REln/long benchmark_long_v2_w02_n01): the
rebuild encoded each length as a 10^5031 constant automaton and gave up
with "no short model found (nfa)". Lengths are now pinned by a single
SLenConst chain and the minimal model comes out.

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
  $ CHRO_NO_PARALLEL=1 Chro gap.smt2 | awk 'NR==1 {print} /define-fun/ {name=$2; getline; gsub(/[ ")]/,""); print name, "length:", length($0)}'
  sat (nfa)
  x length: 5031
  y length: 1000
