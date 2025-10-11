(set-logic QF_S)

(declare-const a String)
(declare-const b String)

(assert (= a "1"))
(assert (= b "1"))
(assert (= c (str.++ a b)))
(assert (= c "11"))

(check-sat)
