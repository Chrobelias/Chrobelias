  $ CHRO_DEBUG=simpl Chro simple.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    iter(1)= (= a "abc")
  [+simpl]
    Alphabet with extra char: 0 a b c
  
  [+simpl]
    Something ready to substitute
        a -> "abc";
  
  [+simpl]
    iter(3)= True
  [+simpl]
    fixed-point
  
  sat (presimpl str)
  [+simpl]
    iter(1)= (and
             (= a "-1099")
             (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.++ (str.to.re "-") (re.* (str.to.re ""))))))
  [+simpl]
    Alphabet with extra char:    - 0 1 9
  
  [+simpl]
    Something ready to substitute
        a -> "-1099";
  
  [+simpl]
    iter(3)= True
  [+simpl]
    fixed-point
  
  sat (presimpl str)
  [+simpl]
    iter(1)= (and
             (= a "-1090")
             (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.++ (str.to.re "-") (re.* (str.to.re ""))))))
  [+simpl]
    Alphabet with extra char:    - 0 1 9
  
  [+simpl]
    Something ready to substitute
        a -> "-1090";
  
  [+simpl]
    iter(3)= (not True)
  [+simpl]
    fixed-point
  
  [+simpl]
    contradicting clause: (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.++ (str.to.re "-") (re.* (str.to.re "")))))
  [+simpl]
    contradicting env:  a -> "-1090";
  [+simpl]
    short env:  a -> "-1090";
  
  [+simpl]
    unsat core: (and
                (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.++ (str.to.re "-") (re.* (str.to.re "")))))
                (= a "-1090"))
  
  unsat (presimpl str)
