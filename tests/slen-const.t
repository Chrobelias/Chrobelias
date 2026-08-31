Regression suite for the [SLenConst] length pinning in string model
reconstruction (see also tests/short-model.t). Once the eliminated
exponent values are known, the residual re-solve pins every string's
length through one joint linear-chain automaton instead of a fresh
variable equal to 10^length. Each test validates the produced model
in-place: the length arithmetic and the regex membership are checked by
awk on the actual model, so a wrong reconstruction fails loudly rather
than by eyeballing thousand-character strings.

Two strings under a rigid length coupling. The joint chain must hold
their end-anchored offset (separate per-string chains would not
synchronize in the product); the regexes force len y = 0 (mod 3) and
len x even on top of the coupling.

  $ cat > t1.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (>= (str.to_int x) 0))
  > (assert (>= (str.to_int y) 0))
  > (assert (>= (str.len y) 1000))
  > (assert (str.in_re x (re.* (str.to_re "52"))))
  > (assert (str.in_re y (re.* (str.to_re "901"))))
  > (assert (= (str.len x) (+ (str.len y) 6)))
  > (check-sat)
  > (get-model)
  > EOF
  $ CHRO_NO_PARALLEL=1 Chro t1.smt2 | awk '
  >   NR==1 { print }
  >   /define-fun x/ { getline; gsub(/[ ")]/,""); lx=length($0);
  >     print "x len:", lx, ($0 ~ /^(52)+$/) ? "regex-ok" : "REGEX-VIOLATION" }
  >   /define-fun y/ { getline; gsub(/[ ")]/,""); ly=length($0);
  >     print "y len:", ly, ($0 ~ /^(901)+$/) ? "regex-ok" : "REGEX-VIOLATION" }
  >   END { print "len x = len y + 6:", (lx == ly + 6) ? "yes" : "NO" }'
  sat (nfa)
  x len: 2010 regex-ok
  y len: 2004 regex-ok
  len x = len y + 6: yes

A run of a single repeated character. This guards the chain's all-eos
boundary step: the Msb invariant closure shortcuts equal-label runs
hanging off the start state, so a chain whose char steps were
start-adjacent would let "999...9" skip positions and print a string
shorter than the pinned length.

  $ cat > t2.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-const x String)
  > (assert (>= (str.to_int x) 0))
  > (assert (>= (str.len x) 1000))
  > (assert (<= (str.len x) 1005))
  > (assert (str.in_re x (re.+ (str.to_re "9"))))
  > (check-sat)
  > (get-model)
  > EOF
  $ CHRO_NO_PARALLEL=1 Chro t2.smt2 | awk '
  >   NR==1 { print }
  >   /define-fun x/ { getline; gsub(/[ ")]/,"");
  >     print "x len:", length($0), ($0 ~ /^9+$/) ? "all-nines" : "WRONG-CONTENT" }'
  sat (nfa)
  x len: 1000 all-nines

Three strings sharing one chain, one of them pinned to length zero (the
empty string is the n = 0 edge of the joint automaton and must not
disturb the others' offsets).

  $ cat > t3.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-const x String)
  > (declare-const y String)
  > (declare-const z String)
  > (assert (>= (str.to_int x) 0))
  > (assert (>= (str.to_int y) 0))
  > (assert (>= (str.len x) 1000))
  > (assert (str.in_re x (re.* (str.to_re "14"))))
  > (assert (str.in_re y (re.* (str.to_re "263"))))
  > (assert (str.in_re z (re.* (str.to_re "7"))))
  > (assert (= (str.len x) (* 2 (str.len y))))
  > (assert (= (str.len z) (- (str.len x) (* 2 (str.len y)))))
  > (check-sat)
  > (get-model)
  > EOF
  $ CHRO_NO_PARALLEL=1 Chro t3.smt2 | awk '
  >   NR==1 { print }
  >   /define-fun x/ { getline; gsub(/[ ")]/,""); lx=length($0);
  >     print "x len:", lx, ($0 ~ /^(14)+$/) ? "regex-ok" : "REGEX-VIOLATION" }
  >   /define-fun y/ { getline; gsub(/[ ")]/,""); ly=length($0);
  >     print "y len:", ly, ($0 ~ /^(263)+$/) ? "regex-ok" : "REGEX-VIOLATION" }
  >   /define-fun z/ { getline; gsub(/[ ")]/,""); lz=length($0);
  >     print "z len:", lz }
  >   END { print "len x = 2 len y:", (lx == 2 * ly) ? "yes" : "NO",
  >         "| len z = 0:", (lz == 0) ? "yes" : "NO" }'
  sat (nfa)
  x len: 4008 regex-ok
  y len: 2004 regex-ok
  z len: 0
  len x = 2 len y: yes | len z = 0: yes
