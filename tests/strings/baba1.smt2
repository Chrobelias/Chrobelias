(set-logic QF_S)

(declare-const a String)
(declare-const b String)

(push 1)
  (assert (str.in.re a (re.+ (re.union (str.to.re "Ba") (str.to.re "Lyu")))))
  (assert (str.in.re b (re.+ (re.union (str.to.re "20") (str.to.re "25")))))
  (assert (= (str.len b) (str.len a)))
  (assert (= (str.len a) (+ 1 (str.to.int b))))
  (check-sat)
  (get-model)
(pop 1)
