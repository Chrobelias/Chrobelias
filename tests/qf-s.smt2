(set-logic QF_S)

(declare-const x String)
(declare-const y String)
(declare-const a Int)
(declare-const b Int)
(declare-const c Int)

(push 1)
  (assert (str.in.re x (str.to.re "abc")))
  (check-sat) ; sat
  (get-model) ; abc
(pop 1)

(push 1)
  ; FIXME: support base 10
  (assert (str.in.re x (str.to.re "100")))
  (assert (= (str.to.int x) 100))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (str.in.re x (str.to.re "000000100")))
  (assert (= (str.to.int x) 100))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (str.in.re x (str.to.re "10")))
  (assert (= (str.to.int x) 100))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (str.in.re x (str.to.re "10")))
  (assert (= (str.len x) 2))
  (check-sat) ; sat
(pop 1)

; 6

(push 1)
  (assert (str.in.re x (str.to.re "10"))) ; FIXME
  (assert (= (str.len x) 1))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (str.in.re x (str.to.re "10")))
  (assert (= (str.len x) 3))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (str.in.re x (str.to.re "00001")))
  (assert (= (str.len x) 5))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (str.in.re x (str.to.re "100")))
  (assert (str.in.re y (str.to.re "10")))
  (assert (> (str.to.int x) (str.to.int y)))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (str.in.re x (str.to.re "100")))
  (assert (str.in.re y (str.to.re "100")))
  (assert (> (str.to.int x) (str.to.int y)))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (str.in.re x (re.++ (str.to.re "10") (re.* (str.to.re "0")))))
  (assert (str.in.re y (str.to.re "10000")))
  (assert (> (str.to.int x) (str.to.int y)))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (str.in.re x (re.* (str.to.re "10"))))
  (assert (= (str.len x) (+ (* 2 y) 1)))
  (check-sat) ; unsat
(pop 1)
