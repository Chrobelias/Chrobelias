(set-logic QF_S)

(declare-const a String)
(declare-const b String)
(declare-const x Int)
(declare-const y Int)

(push 1)
    (assert (= a "abc"))
    (assert (str.in_re a (str.to_re "abc")))
    (check-sat)
(pop 1)

(push 1)
    (assert (str.in_re a (re.++ (str.to.re "-") (re.* (re.union (str.to.re "10") (str.to.re "99"))))))
    (assert (= a "-1099"))
    (check-sat)
(pop 1)

(push 1)
    (assert (str.in_re a (re.++ (str.to.re "-") (re.* (re.union (str.to.re "10") (str.to.re "99"))))))
    (assert (= a "-1090"))
    (check-sat)
(pop 1)