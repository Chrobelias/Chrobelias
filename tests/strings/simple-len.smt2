(set-logic QF_S)

(declare-const x String)
(declare-const y String)

(assert (str.in.re x (re.++ (str.to.re "1") (re.* (re.union (str.to.re "000") (str.to.re "999"))))))
(assert (str.in.re y (re.+ (str.to.re "9"))))
(assert (= (str.len x) (+ 1 (str.to.int y))))

(check-sat)
(get-model)
