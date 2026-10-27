; Sect. 6: the system used as the template of REln/RElnc; among the compared
; solvers only OSTRICH decides it within 60 s, Chrobelias needs less than 1 s.
(set-logic QF_SLIA)
(declare-fun x () String)
(declare-fun y () String)
(assert (= (str.++ "0" x) (str.++ x "0")))
(assert (= (str.to_int x) (str.to_int y)))
(assert (> (str.len x) 1))
(assert (< (str.len x) (str.len y)))
(assert (> (str.len y) 1000))
(check-sat)
