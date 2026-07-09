
(set-logic QF_SLIA)
(declare-fun A () Int)
(declare-fun t2 () String)
(assert (str.in_re t2 (re.++ (re.* (str.to_re "0")) (str.to_re "100"))))
(assert (= (* 19 A)
           (+ (* 37 (str.to_int t2))
              (- 1))))
(check-sat)
