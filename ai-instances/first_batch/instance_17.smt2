; Instance 17
; Meaning: RANDOM instance.
; No particular semantic intent — randomly mixed constraints on 4 variables
; with 3 int.v atoms and several linear inequalities.
; Generated to stress-test the solver on a tangled constraint graph.

(set-logic QF_SLIA)
(declare-fun a () Int)
(declare-fun b () Int)
(declare-fun c () Int)
(declare-fun d () Int)
(assert
  (and
    (> a 0)
    (> b 0)
    (int.v a b)
    (int.v b c)
    (int.v (+ a b) d)
    (<= c d)
    (<= b (+ a a))
    (not (= c b))
  )
)
(check-sat)
