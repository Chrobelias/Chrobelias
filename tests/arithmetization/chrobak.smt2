(set-logic QF_SLIA)

(declare-fun x () String)
(declare-fun u () String)

(assert (str.in.re x (re.* (re.union (str.to.re "09") (str.to.re "019")))))
(assert (< (+ (str.len x) (str.len u)) 50))
(assert (= (str.len x) 5))
(check-sat)
(get-model)