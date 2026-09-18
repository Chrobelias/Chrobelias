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

A value that exists but cannot be written down reports the same way. Model
construction used to substitute x = 100 into z and evaluate 2^(2^100) through
Utils.powz, which squares its way up and exhausts memory: the answer was
printed and (get-model) never returned. SimplII.pow now declines to build a
constant past the path budget, and the power left symbolic is reported instead
of being dropped from the model.

  $ cat > tower.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (declare-const z Int)
  > (assert (= z (** 2 (** 2 x))))
  > (assert (>= x 100))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro tower.smt2
  sat (under int)
  no short model

With the integer under-approximation off the same formula is decided by
equality propagation, which reaches model construction by another route and
needs the same guard:

  $ Chro -bound -1 tower.smt2
  sat (simpl)
  no short model

A tower that does fit is still evaluated and printed in full:

  $ cat > small.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (declare-const z Int)
  > (assert (= z (** 2 (** 2 x))))
  > (assert (>= x 3))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro small.smt2
  sat (under int)
  (
     (define-fun x () Int
      3)
     (define-fun z () Int
      256)
  )

Evaluating a constant power is bounded separately from [-huge], and not by a
flag. [-huge] bounds how long a printed model may be and gets lowered by anyone
who wants a short one; tying the two together would mean that asking for a
shorter model stops the simplifier from working out 2 ** 40.

  $ cat > small-pow.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const y Int)
  > (assert (= y (** 2 40)))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro -huge 16 small-pow.smt2
  sat (presimpl int)
  (
     (define-fun y () Int
      1099511627776)
  )

The same holds the other way round: a formula is decided through a power far
wider than the model it answers with, so the two bounds cannot be one number.
This one is settled through 2 ** 20000, six thousand digits, and reports two
five-digit values.

  $ cat > gap.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const x Int)
  > (declare-const y Int)
  > (assert (= (** 2 y) (* 4 (** 2 x))))
  > (assert (>= x 20000))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro gap.smt2
  sat (nfa)
  (
     (define-fun x () Int
      20000)
     (define-fun y () Int
      20002)
  )

[-huge n] says what may be printed, and it is now measured on the finished
model rather than left to the constraints the re-solve adds: nothing reported
holds a string of more than n characters, or an integer whose decimal expansion
runs past n digits. 2 ** 100 needs 31 of them.

  $ cat > pow100.smt2 <<-EOF
  > (set-logic QF_EIA)
  > (declare-const y Int)
  > (assert (= y (** 2 100)))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro -huge 30 pow100.smt2
  sat (under int)
  no short model
  $ Chro -huge 31 pow100.smt2
  sat (under int)
  (
     (define-fun y () Int
      1267650600228229401496703205376)
  )

Strings are measured the same way, in characters.

  $ cat > twelve.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const s String)
  > (assert (>= (str.len s) 12))
  > (check-sat)
  > (get-model)
  > EOF
  $ Chro -huge 11 twelve.smt2
  sat (under int)
  no short model
  $ Chro -huge 12 twelve.smt2
  sat (under int)
  (
     (define-fun s () String
      "000000000000")
  )
