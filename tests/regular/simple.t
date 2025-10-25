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
  iter(1)= (and
             (= x (str.to.int a))
             (= x 1099)
             (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re "")))))
  Something ready to substitute:  x -> 1099;
  iter(2)= (and
             (= x 1099)
             (= x (str.to.int a))
             (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re "")))))
  iter(3)= (and
             (= 1099 (str.to.int a))
             (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re "")))))
  iter(1)= (and
             (and
               (= (+ (* (- 1) a)) (- 1099)))
             (and
               (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re ""))))))
  iter(2)= (and
             (= (* (- 1) a) (- 1099))
             (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re "")))))
  Something ready to substitute:  a -> 1099;
  iter(3)= (and
             (= (* (- 1) a) (- 1099))
             (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re "")))))
  iter(4)= True
  sat (nfa)
  iter(1)= (and
             (= x (str.to.int a))
             (= (+ x y) 1099)
             (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re "")))))
  Something ready to substitute:  x -> (+ 1099 (* (- 1) y));
  iter(2)= (and
             (= x (str.to.int a))
             (= (+ x y) 1099)
             (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re "")))))
  iter(3)= (and
             (= (+ 1099 (* (- 1) y)) (str.to.int a))
             (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re "")))))
  iter(1)= (and
             (and
               (= (+ (* (- 1) y) (* (- 1) a)) (- 1099)))
             (and
               (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re ""))))))
  iter(2)= (and
             (= (+ (* (- 1) a) (* (- 1) y)) (- 1099))
             (str.in_re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re "")))))
  Trying to use PrA deciding procedure over  (((-1a + -1y = -1099)) & ((str.in.re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re ""))))))
  states:[-1099; -109; -10; -1; 0; 1]
  Done (-1a + -1y = -1099)
  
  Evaluated debugs/268483/1.svg
  0 -> a
  1 -> y
  Done (exists (y) (-1a + -1y = -1099))
  
  Evaluated debugs/268483/2.svg
  0 -> a
  1 -> y
  SREG debugs/268483/3.svg
  0 -> a
  1 -> y
  Done (str.in.re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re ""))))
  
  Evaluated debugs/268483/4.svg
  0 -> a
  1 -> y
  Done ((exists (y) (-1a + -1y = -1099)) & (str.in.re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re "")))))
  
  Evaluated debugs/268483/5.svg
  0 -> a
  1 -> y
  Done (exists (a) ((exists (y) (-1a + -1y = -1099)) & (str.in.re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re ""))))))
  
  Evaluated debugs/268483/6.svg
  0 -> a
  1 -> y
  sat (nfa)
