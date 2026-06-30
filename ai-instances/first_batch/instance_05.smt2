; Instance 05
; Meaning: Are there x, y with v(x, y) and v(y, x)?
; i.e. x and y are each other's valuation — a "fixed point pair".
; In base 2: SAT — x=1, y=1: v_2(1)=1.
; Interesting to check whether non-trivial solutions exist across bases.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(assert
  (and
    (> x 0)
    (> y 0)
    (int.v x y)
    (int.v y x)
  )
)
(check-sat)
