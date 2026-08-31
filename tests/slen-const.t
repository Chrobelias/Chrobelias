SLenConst regression suite: reconstruction pins string lengths through
one joint chain automaton (see tests/short-model.t). Each model is
validated in-place by awk -- lengths and regex membership.

Two strings under a rigid length coupling.

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

A run of one repeated character guards the chain's all-eos boundary
step: without it the start-state closure collapses equal-label runs
and the model comes out short.

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

Three strings sharing one chain, one pinned to length zero.

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
