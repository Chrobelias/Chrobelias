; Instance 39
; Meaning: The valuations of x, 2x, 3x are all distinct — OR — they are all equal.
; But not a "mixed" case where exactly two coincide.
; This is an XOR-like condition: either all-distinct or all-equal.
; In base 2: v_2(x) ≠ v_2(2x) always (doubling adds one factor of 2),
;   and v_2(3x) = v_2(x) always (3 is odd). So v_2(x)=v_2(3x) ≠ v_2(2x): always mixed! UNSAT.
; In base 3: v_3(2x)=v_3(x), v_3(3x) = 3*v_3(x) ≠ v_3(x) for x>0.
;   So v_3(x)=v_3(2x) ≠ v_3(3x): always mixed. UNSAT.
; In base 5: v_5(2x)=v_5(x), v_5(3x)=v_5(x). All equal. SAT!

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun v1 () Int)
(declare-fun v2 () Int)
(declare-fun v3 () Int)
(assert
  (and
    (> x 0)
    (int.v x v1)
    (int.v (+ x x) v2)
    (int.v (+ x (+ x x)) v3)
    (or
      (and (= v1 v2) (= v2 v3))
      (and (not (= v1 v2)) (not (= v2 v3)) (not (= v1 v3)))
    )
  )
)
(check-sat)
