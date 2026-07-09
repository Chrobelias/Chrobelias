
(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun x1 () Int)
(declare-fun y1 () Int)
(declare-fun x2 () Int)
(declare-fun y2 () Int)
(assert
  (and
    (int.v (* 3 a) x1)
    (int.v (* 3 b) y1)
    (<= x1 y1)
    (int.v (+ a 1) x2)
    (int.v (- b 1) y2)
    (<= x2 y2)
  )
)
(check-sat)
