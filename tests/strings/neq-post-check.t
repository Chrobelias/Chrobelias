  $ cat > neq-concat.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-fun x () String)
  > (declare-fun y () String)
  > (declare-fun z () String)
  > (declare-fun w () String)
  > (assert (= (str.++ x z) (str.++ y w)))
  > (assert (= (str.len x) (str.len y)))
  > (assert (not (= x y)))
  > (assert (str.in_re x (re.+ (re.range "a" "b"))))
  > (check-sat)
  > EOF

  $ Chro -no-parallel neq-concat.smt2 | cut -d' ' -f1
  unknown
