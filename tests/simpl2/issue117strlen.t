  $ cat > len1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > 
  > (assert (< 1000 (str.len y)))
  > (assert (< (str.len x) (str.len y)))
  > (assert (< 1 (str.len x)))
  > (check-sat)
  > EOF
$ ls
$ cat len1.smt2
  $ CHRO_DEBUG=1 Chro -no-over-approx -bound -1 -pre-simpl -dpresimpl -stop-after presimpl len1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= %1 (str.len y))
             (= %0 (str.len x))
             (<= (+ 1 1) %0)
             (<= (+ %0 1) %1)
             (<= (+ 1000 1) %1))
  iter(2)= (and
             (= %0 (str.len x))
             (= %1 (str.len y))
             (<= 2 %0)
             (<= 1001 %1)
             (<= (+ 1 %0) %1))
  (and
    (= %0 (str.len x))
    (= %1 (str.len y))
    (<= 2 %0)
    (<= 1001 %1)
    (<= (+ 1 %0) %1))
