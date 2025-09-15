(set-logic QF_S)

(declare-const x String)
(declare-const y String)
(declare-const a Int)
(declare-const b Int)
(declare-const c Int)


(push 1)
  (assert (str.in.re a (re.+ (re.union (str.to.re "Bab") (str.to.re "Lyuba")))))
  (assert (str.in.re b (re.+ (re.union (str.to.re "3") (str.to.re "2")))))
  (assert (= q (str.len a)))
  (assert (= q (+ (str.len b) 23)))
  (check-sat)
  (get-model)
(pop 1)