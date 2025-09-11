(set-logic LIA)

(declare-const x Int)
(declare-const y Int)
(declare-const z Int)
(declare-const a Int)
(declare-const b Int)
(declare-const c Int)

(push 1)
  (assert (= (+ 2 6) 8))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (<= (+ 3 5) (+ 16 (- 9))))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (>= (+ 3 5) (+ 16 (- 9))))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (= x 4))
  (assert (= y 3))
  (assert (= z 2))
  (assert (= (+ (* 2 x) (* 3 y) (* 5 z)) 27))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (forall ((x Int) (y Int)) (= (+ x y) (+ y x))))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (forall ((x Int) (y Int) (z Int)) (= (+ x y z) (+ x (+ y z)))))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (forall ((x Int) (y Int) (z Int)) (=> (and (>= (+ (* 2 x) (* 3 y) (* 4 z)) 43) (<= y 3) (<= z 5)) (>= x 7))))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (forall ((x Int) (y Int) (z Int)) (=> (and (>= (+ (* 2 x) (* 3 y) (* 4 z)) 40) (<= y 3) (<= z 5)) (>= x 7))))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (forall ((x Int) (y Int)) (=> (= x y) (not (distinct x y)))))
  (assert (forall ((x Int) (y Int)) (=> (distinct x y) (not (= x y)))))
  (assert (forall ((x Int) (y Int)) (=> (<= x y) (not (> x y)))))
  (assert (forall ((x Int) (y Int)) (=> (< x y) (not (>= x y)))))
  (assert (forall ((x Int) (y Int)) (=> (>= x y) (not (< x y)))))
  (assert (forall ((x Int) (y Int)) (=> (> x y) (not (<= x y)))))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (not (exists ((x Int) (y Int)) (and (> x 5) (>= y 3) (< (+ x y) 9)))))
  (assert (exists ((x Int) (y Int)) (and (> x 5) (>= y 3) (<= (+ x y) 9))))
  (assert (exists ((x Int) (y Int)) (and (> x 5) (>= y 3) (> (+ x y) 9))))
  (assert (exists ((x Int) (y Int)) (and (> x 5) (>= y 3) (>= (+ x y) 8))))
  (assert (exists ((x Int) (y Int)) (and (> x 5) (>= y 3) (= (+ x y) 9))))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (> x 4))
  (assert (< y 12))
  (assert (>= z 8))
  (assert (< z x))
  (assert (<= x y))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (> x 4))
  (assert (< y 12))
  (assert (>= z 8))
  (assert (< z x))
  (assert (<= x y))
  (assert (not (= x 9)))
  (assert (not (= x 10)))
  (assert (not (= x 11)))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (> x 4))
  (assert (< y 12))
  (assert (>= z 8))
  (assert (< z x))
  (assert (<= x y))
  (assert (not (= x 9)))
  (assert (not (= x 11)))
  (check-sat) ; sat
(pop 1)

(push 1)
  (assert (= z 3))
  (assert (= a z))
  (assert (= b a))
  (assert (= b 4))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (= z 3))
  (assert (= a z))
  (assert (= b a))
  (assert (>= b c))
  (assert (<= b c))
  (assert (= 17 c))
  (check-sat) ; unsat
(pop 1)

(push 1)
  (assert (forall ((x Int) (y Int)) (and (=> (= x y) (and (<= x y) (<= y x))) (=> (and (<= x y) (<= y x)) (= x y)))))
  (check-sat) ; sat
(pop 1)

; Addition of push/pop screws Z3
; (push 1)
;   (assert (forall ((x Int)) (exists ((y Int)) (or (= x (* 3 y)) (= x (+ (* 3 y) 1)) (= x (+ (* 3 y) 2))))))
;   (check-sat) ; sat
; (pop 1)

; (push 1)
;   (assert (forall ((x Int)) (exists ((y Int)) (or (= x (* 3 y)) (= x (+ (* 3 y) 2))))))
;   (check-sat) ; sat
; (pop 1)
