(set-logic QF_SLIA)

(declare-const x String)
(declare-const y String)

(assert (= (+ (* 2 (str.len x)) (* (- 4) (str.len y))) 62))
(assert (= (+ (* (- 2) (str.len x)) (* 9 (str.len y))) 12))

(check-sat)