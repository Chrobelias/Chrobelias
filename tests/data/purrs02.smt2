; "Spanish" recurrence n. 2 
; x(n) = 2 * x(n-1) + 2^n
; Solution: x(n) = (x(0) + n) * 2^n

(set-logic ALL)
(set-option :produce-models true)
(declare-fun x () Int)
(declare-fun n () Int)

(assert (> n 0))
(assert (distinct
  (* (+ x n) (exp 2 n))
  (+ (* 2 (* (+ x (- n 1)) (exp 2 (- n 1)))) (exp 2 n))
))

(check-sat)

