
  $ CHRO_DEBUG=1 Chro -no-over -bound -1 --dpresimpl --dir --stop-after simpl ../examples/issue150.smt2 2>&1 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (<= (+ (str.len x) 1) 100)
             (= v (* u 444))
             (= (* 1171 w) (+ (str.to.int x) v))
             (<= (+ v 1) 1171)
             (<= 0 v)
             (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  Something ready to substitute
        v -> (* 444 u);
  
  iter(2)= (and
             (= (* 1171 w) (+ v (str.to.int x)))
             (<= 0 v)
             (<= v 1170)
             (<= (str.len x) 99)
             (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  iter(3)= (and
             (= (* 1171 w) (+ (* 444 u) (str.to.int x)))
             (<= 0 (* 444 u))
             (<= u 2)
             (<= (str.len x) 99)
             (str.in_re x (re.++ (re.++ (re.++ (re.++ (str.to.re "9") (re.++ (str.to.re "8") (re.++ (str.to.re "7") (str.to.re "6")))) (re.* (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (re.union (str.to.re "0") (str.to.re "1")) (str.to.re "2")) (str.to.re "3")) (str.to.re "4")) (str.to.re "5")) (str.to.re "6")) (str.to.re "7")) (str.to.re "8")) (str.to.re "9")))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (str.to.re "1")))))) (re.* (str.to.re "")))))
  fixed-point
  
  Arithmetization gives 2 asts...
  Arithmetized: (and
                  (= (* 1171 w) (+ (* 444 u) x))
                  (<= 0 (* 444 u))
                  (<= u 2)
                  (<= strlenx 99)
                  (chrob.len x (exp 10 strlenx))
                  (<= 0 strlenx)
                  True
                  True
                  True
                  (str.in_re.raw x))
  
  Basic simplifications:
  
  iter(1)= (and
             (= (* 1171 w) (+ (* 444 u) x))
             (<= 0 (* 444 u))
             (<= u 2)
             (<= strlenx 99)
             (chrob.len x (exp 10 strlenx))
             (<= 0 strlenx)
             True
             True
             True
             (str.in_re.raw x))
  iter(2)= (and
             (= (* 1171 w) (+ x (* 444 u)))
             (<= 0 strlenx)
             (<= 0 (* 444 u))
             (<= strlenx 99)
             (<= u 2)
             (str.in_re.raw x)
             (chrob.len x (exp 10 strlenx)))
  fixed-point
  
  Post-simplification: (and
                         (= (* 1171 w) (+ x (* 444 u)))
                         (<= (exp 10 0) (exp 10 strlenx))
                         (<= 0 (* 444 u))
                         (<= strlenx 99)
                         (<= u 2)
                         (str.in_re.raw x)
                         (chrob.len x (exp 10 strlenx)))
  
  New info:
    Exp: strlenx
    Str:
    ALL: strlenx u w x
  
  (and
    (= (* 1171 w) (+ x (* 444 u)))
    (<= (exp 10 0) (exp 10 strlenx))
    (<= 0 (* 444 u))
    (<= strlenx 99)
    (<= u 2)
    (str.in_re.raw x)
    (chrob.len x (exp 10 strlenx)))
$ Chro -no-over-approx -bound -1 issue117.smt2 | sed 's/[[:space:]]*$//'


  $ timeout 5 Chro -no-over -bound -1 ../examples/issue150.smt2 2>&1 | sed 's/[[:space:]]*$//'
  timeout
