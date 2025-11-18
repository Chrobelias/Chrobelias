(set-logic QF_SLIA)
(declare-const x String)
(declare-const y String)
(declare-const z Int)
 
(assert (str.in_re x (re.++ (str.to_re "16") (re.* (re.union (str.to_re "000") (str.to_re "999"))))))
(assert (str.in_re y (re.+ (str.to_re "9"))))
(assert (= (* 9 (str.len x)) (str.to_int y)))
 
(check-sat)
(get-model)