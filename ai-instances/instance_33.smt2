; Instance 33
; Meaning: x has one of three possible "valuation profiles":
;   (a) v(x) = v(2x)  — doubling doesn't change valuation
;   (b) v(x) = v(3x)  — tripling doesn't change valuation
;   (c) v(x) = v(5x)  — multiplying by 5 doesn't change valuation
; In base 2: (a) is never true (doubling always increases 2-adic val), (b) and (c) are always true.
; In base 3: (a) and (c) are always true, (b) is never true.
; In base 5: (a) and (b) are always true, (c) is never true.
; So for any prime base p, exactly the non-p options hold.
; This instance is SAT in every base (trivially), but the *which disjunct* is
; base-dependent. More interesting as a negation: assert that NONE of the three hold.

(set-logic QF_SLIA)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun w () Int)
(declare-fun u () Int)
(assert
  (and
    (> x 0)
    (int.v x y)
    (int.v (+ x x) z)
    (int.v (+ x (+ x x)) w)
    (int.v (+ x (+ x (+ x (+ x x)))) u)
    (not (or
      (= y z)
      (= y w)
      (= y u)
    ))
  )
)
(check-sat)
