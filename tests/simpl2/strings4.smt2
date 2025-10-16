(set-logic QF_S)
(declare-const x String)
(declare-const y String)

(assert (str.in.re x (re.++ (str.to.re "aa") (re.* (str.to.re "bbb")))))
(assert (str.in.re y (re.+ (str.to.re "9"))))
(assert (= (str.len x) (+ 2 (str.to.int y))))

(check-sat)
(get-model)