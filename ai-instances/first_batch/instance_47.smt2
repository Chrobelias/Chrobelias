; Instance 47
; Meaning: Iterated valuation with a branching condition.
; Either the valuation tower x -> v(x) -> v(v(x)) stabilises in two steps (v(v(x)) = v(x)),
; OR it takes exactly three steps to stabilise (v(v(v(x))) = v(v(x)) but v(v(x)) ≠ v(x)).
; Combined with an arithmetic constraint tying the top and bottom of the tower.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun v1 () Int)
(declare-fun v2 () Int)
(declare-fun v3 () Int)
(assert
  (and
    (> x 0)
    (int.v x v1)
    (int.v v1 v2)
    (int.v v2 v3)
    (or
      (= v2 v1)
      (and (= v3 v2) (not (= v2 v1)))
    )
    (<= (* 6 v3) x)
    (not (= x v1))
  )
)
(check-sat)
