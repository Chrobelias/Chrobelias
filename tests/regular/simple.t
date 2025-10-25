  $ CHRO_DEBUG=1 Chro simple.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (str.in_re a (re.++ (re.++ (str.to.re "c") (re.++ (str.to.re "b") (str.to.re "a"))) (re.* (str.to.re ""))))
             (= a "abc"))
  Something ready to substitute:  a ->s "abc";
  iter(2)= (and
             (str.in_re a (re.++ (re.++ (str.to.re "c") (re.++ (str.to.re "b") (str.to.re "a"))) (re.* (str.to.re ""))))
             (= a "abc"))
  iter(3)= True
  sat (presimpl)
  iter(1)= (and
             (= a "-1099")
             (str.in_re a (re.++ (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (str.to.re "-")) (re.* (str.to.re "")))))
  Something ready to substitute:  a ->s "-1099";
  iter(2)= (and
             (str.in_re a (re.++ (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (str.to.re "-")) (re.* (str.to.re ""))))
             (= a "-1099"))
  iter(3)= True
  sat (presimpl)
