(set-logic QF_S)
(declare-const x String)
(declare-const y String)
(declare-const z Int)
 
(assert (str.in.re x (re.++ (str.to.re "1") (re.* (re.union (str.to.re "00") (str.to.re "99"))))))
(assert (str.in.re y (re.+ (str.to.re "9"))))
(assert (= (+ 2 (str.len x)) (str.to.int y)))
(assert (= (str.len y) (* 3 z)))
(assert (<= (str.len x) 990))
 
(check-sat)
(get-model)