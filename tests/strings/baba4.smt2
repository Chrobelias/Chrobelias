(set-logic QF_S)

(declare-const a String)
(declare-const b String)
(declare-const q Int)

(push 1)
  (assert (str.in.re a (str.to.re "Ba")))
  (assert (str.in.re b (str.to.re "20")))
  (assert (= (str.len a) (str.len b)))
  (check-sat)
  (get-model)
(pop 1)