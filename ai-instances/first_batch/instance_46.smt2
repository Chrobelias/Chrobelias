; Instance 46
; Meaning: RANDOM — A large Boolean combination across 6 variables and 4 int.v atoms,
; mixing implications, disjunctions, and negations with coefficient arithmetic.
; No specific semantic intent beyond stressing the Boolean reasoning layer.

(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun d () Int)
(declare-fun e () Int)
(declare-fun f () Int)
(assert
  (and
    (> a 0) (> c 0) (> e 0)
    (int.v a b)
    (int.v c d)
    (int.v e f)
    (int.v (+ a c) d)
    (or
      (and (< b d) (=> (< d f) (= (+ a e) (* 5 c))))
      (and (= b f) (not (= d b)) (<= (* 7 c) (+ a e)))
      (and (< f b) (< f d) (= (+ b f) d))
    )
    (not (and (= b d) (= d f)))
  )
)
(check-sat)
