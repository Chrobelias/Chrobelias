; Instance 41
; Meaning: RANDOM — A disjunction over three valuation chain shapes.
; We have a, b, c, d, e with valuation atoms, and assert that
; one of three "structural templates" holds, each with different arithmetic.
; No strong semantic intent — exploring the Boolean frontier.

(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun d () Int)
(declare-fun e () Int)
(assert
  (and
    (> a 0) (> c 0) (> e 0)
    (or
      (and
        (int.v a b)
        (int.v c d)
        (= (+ b d) e)
        (<= (* 3 e) (+ a c))
      )
      (and
        (int.v (+ a c) b)
        (int.v e d)
        (< d b)
        (<= a (* 4 c))
      )
      (and
        (int.v a b)
        (int.v b d)
        (int.v d e)
        (= (+ b d) (* 2 e))
      )
    )
  )
)
(check-sat)
