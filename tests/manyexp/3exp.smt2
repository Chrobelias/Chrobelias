(set-logic ALL)

(declare-const x Int)
(declare-const y Int)
(declare-const z Int)
(declare-const u Int)

(push 1)
  (assert (and
            (<= (+ (** 2 (+ u z)) (** 2 z)) 21)
            (<= 2 z)
            (>= (** 2 u) 4)
            ))
  (check-sat) ; sat
  (get-model)
(pop 1)

(push 1)
  (assert (and
            (<= (+ (** 2 (+ u z)) (** 2 z)) 21)
            (<= 3 z)
            (>= (** 2 u) 4)
            ))
  (check-sat) ; unsat
(pop 1)

(push 1)
    (assert (and
            (= (* (** 2 z) (+ 1 (** 2 u))) y)
            (<= y 275)
            (<= 4 z)
            (>= (** 2 u) 9)
            ))
    (check-sat) ; sat
(pop 1)