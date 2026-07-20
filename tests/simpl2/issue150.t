
  $ Chro -no-over -bound -1 --dpresimpl --dir --stop-after simpl ../examples/issue150.smt2 2>&1 | sed 's/[[:space:]]*$//'
  (and
    (= (+ (* 1171 w) (* (- 444) u) (* (- 1) x)) 0)
    (<= (+ (- 1170) (* 444 u)) 0)
    (<= (+ (- 99) strlenx) 0)
    (<= (+ 1 (* (- 1) strlenx)) 0)
    (<= (* (- 444) u) 0)
    (<= (* (- 1) x) 0)
    (str.in_re.raw x)
    (chrob.len x (exp 10 strlenx)))
$ Chro -no-over-approx -bound -1 issue117.smt2 | sed 's/[[:space:]]*$//'


  $ timeout 5 Chro -no-over -bound -1 -bstates 10 -bres 1 ../examples/issue150.smt2 2>&1 | sed 's/[[:space:]]*$//'
  timeout
