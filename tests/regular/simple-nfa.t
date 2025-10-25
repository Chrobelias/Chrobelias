  $ Chro -pre-simpl -dsimpl simple-nfa.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)
  (assert (exists (a)
          (and
            (exists (y) (= (+ (* (- 1) a) (* (- 1) y) )  -1099) )
            (str.in.re a (re.++ (re.* (re.union (re.++ (str.to.re "0") (str.to.re "1")) (re.++ (str.to.re "9") (str.to.re "9")))) (re.* (str.to.re "")))))
  )
  sat (nfa)
