; divisibility_29
; Two patterns, 4 shared vars a,b,c,d + x1,y1,x2,y2 = 8.
; The two G polynomials share coefficients with the F polynomials swapped,
; testing symmetry under the int.v predicate.
; F1 = 7*a + 11*b,        G1 = 11*c + 7*d
; F2 = c - a,             G2 = b - d

(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun d () Int)
(declare-fun x1 () Int)
(declare-fun y1 () Int)
(declare-fun x2 () Int)
(declare-fun y2 () Int)
(assert
  (and
    (int.v (+ (* 7 a) (* 11 b)) x1)
    (int.v (+ (* 11 c) (* 7 d)) y1)
    (<= x1 y1)
    (int.v (- c a) x2)
    (int.v (- b d) y2)
    (<= x2 y2)
  )
)
(check-sat)
