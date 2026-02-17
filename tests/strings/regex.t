
  $ cat > test1.smt2 <<-EOF
  > (set-logic QF_SLIA)
  > (declare-const x String) 
  > (assert (str.in_re x (re.* (re.++ (str.to_re "a") (re.+ (str.to_re "aa"))))))
  > (check-sat)
  > EOF
  $ Chro test1.smt2
  sat (under int)

