(set-logic ALL)

(declare-const x Int)
(declare-const y Int)
(declare-const y Int)
(declare-const u Int)

(push 1)
  (assert (= (** 2 x) 16))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (= (** 2 x) 17))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (= (+ (** 2 x) 4) 16))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (= (** 2 x) (** 2 y)))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (= (** 2 x) (+ (** 2 y) 5)))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (= (+ (** 2 x) x) 6))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (= (+ (** 2 x) x) 5))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (= x y))
  (assert (not (= (** 2 x) (** 2 y))))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (not (= x y)))
  (assert (= (** 2 x) (** 2 y)))
  (assert (>= x 0))
  (assert (>= y 0))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (= x y))
  (assert (= (** 2 x) (** 2 y)))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (= (** 2 x) (+ (** 2 y) 5)))
  (check-sat) ; unsat
(pop 1)

(push 1)
    (assert (> x 10))
    (assert (= (** 2 x) (** 2 y)))
    (check-sat) ; sat
(pop 1)

(push 1)
  (assert (= x (+ y 1)))
  (assert (not (= (** 2 x) (* 2 (** 2 y)))))
  (assert (>= x 0))
  (assert (>= y 0))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (= x 10))
  (assert (= y (** 2 x)))
  (assert (<= y 10000))
  (check-sat) ; sat
(pop 1)

;(push 1)
;  (assert (= x 1000))
;  (assert (= y (** 2 x)))
;  (assert (<= y 10000))
;  (check-sat) ; unsat
;(pop 1)
