(set-logic QF_S)

(declare-const a String)
(declare-const b String)
(declare-const x Int)
(declare-const q Int)

(push 1)
  (assert (str.in.re a (str.to.re "abc")))
  (check-sat) ; sat
  (get-model) ; abc
(pop 1)

(push 1)
  (assert (str.in.re a (str.to.re "100")))
  (assert (= (str.to.int a) 100))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (str.in.re a (str.to.re "000000100")))
  (assert (= (str.to.int a) 100))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (str.in.re a (str.to.re "10")))
  (assert (= (str.to.int a) 100))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (str.in.re a (str.to.re "10")))
  (assert (= (str.len a) 2))
  (check-sat) ; sat
(pop 1)

; 6

(push 1)
  (assert (str.in.re a (str.to.re "10"))) ; FIXME
  (assert (= (str.len a) 1))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (str.in.re a (str.to.re "10")))
  (assert (= (str.len a) 3))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (str.in.re a (str.to.re "00001")))
  (assert (= (str.len a) 5))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (str.in.re a (str.to.re "100")))
  (assert (str.in.re b (str.to.re "10")))
  (assert (> (str.to.int a) (str.to.int b)))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (str.in.re a (str.to.re "100")))
  (assert (str.in.re a (str.to.re "100")))
  (assert (> (str.to.int a) (str.to.int a)))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (str.in.re a (re.++ (str.to.re "10") (re.* (str.to.re "0")))))
  (assert (str.in.re b (str.to.re "10000")))
  (assert (> (str.to.int a) (str.to.int b)))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (str.in.re a (re.* (str.to.re "10"))))
  (assert (= (str.len a) (+ (* 2 x) 1)))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (str.in.re a (re.* (str.to.re "100"))))
  (assert (= (str.len a) 12))
  (check-sat) ; sat
  (get-model)
(pop 1)

(push 1)
  (assert (str.in.re a (re.+ (re.union (str.to.re "Ba") (str.to.re "Lyu")))))
  (assert (= (str.len a) x))
  (assert (= x 23))
  (get-model)
(pop 1)

(push 1)
  (assert (str.in.re a (str.to.re "Ba")))
  (assert (str.in.re b (str.to.re "20")))
  (assert (= (str.len a) (str.len b)))
  (get-model)
(pop 1)

(push 1)
  (assert (str.in.re a (re.+ (re.union (str.to.re "Ba") (str.to.re "Lyu")))))
  (assert (str.in.re b (re.+ (re.union (str.to.re "1") (str.to.re "0")))))
  (assert (= q (str.len a)))
  (assert (= q (+ 1 (str.to.int b))))
  (assert (= q (str.len b)))
  (get-model)
(pop 1)

(push 1)
  (assert (str.in.re a (re.+ (re.union (str.to.re "Bab") (str.to.re "Lyuba")))))
  (assert (str.in.re b (re.+ (re.union (str.to.re "3") (str.to.re "2")))))
  (assert (= q (str.len a)))
  (assert (= q (+ (str.len b) 23)))
  (get-model)
(pop 1)
