
  $ cat > test1.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-const x String) 
  > (assert (str.in_re x (re.* (re.++ (str.to_re "a") (re.+ (str.to_re "aa"))))))
  > (check-sat)
  > EOF
  $ Chro test1.smt2
  sat (under int)

  $ cat > test2.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-const x String)
  > (assert (str.in_re x (re.+ (re.* (re.union (re.+ (str.to_re "6")) (re.range "4" "7"))))))
  > (check-sat)
  > EOF
  $ Chro test2.smt2
  sat (under int)
