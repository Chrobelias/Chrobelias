  $ CHRO_DEBUG=1 Chro simple.smt2 | sed 's/[[:space:]]*$//'
  Base now is 10
  
  iter(1)= (and
             (= a "abc")
             (= a "abc"))
  Alphabet with extra char: 0 a b c
  
  Something ready to substitute
        a -> "abc";
  
  iter(2)= True
  fixed-point
  
  sat (presimpl str)
  Base now is 10
  
  iter(1)= (and
             (= a "-1099")
             (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.++ (str.to.re "-") (re.* (str.to.re ""))))))
  Alphabet with extra char:    - 0 1 9
  
  Something ready to substitute
        a -> "-1099";
  
  iter(2)= (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.++ (str.to.re "-") (re.* (str.to.re "")))))
  iter(3)= True
  fixed-point
  
  sat (presimpl str)
  Base now is 10
  
  iter(1)= (and
             (= a "-1090")
             (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.++ (str.to.re "-") (re.* (str.to.re ""))))))
  Alphabet with extra char:    - 0 1 9
  
  Something ready to substitute
        a -> "-1090";
  
  iter(2)= (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.++ (str.to.re "-") (re.* (str.to.re "")))))
  iter(3)= (not True)
  fixed-point
  
  unsat (presimpl str)
