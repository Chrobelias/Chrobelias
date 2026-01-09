(set-logic QF_SLIA)

(declare-fun x () String)
(declare-fun u () String)

(assert (str.in.re x (re.++ (str.to.re "12345") (re.* (re.range "0" "9"))(str.to.re "6789"))))
(assert (< (+ (str.len x) (str.len u)) 50))
(assert (< (str.len x) 5))
(check-sat)
(get-model)