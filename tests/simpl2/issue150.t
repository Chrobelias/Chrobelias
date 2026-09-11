
  $ Chro -no-over -bound -1 --no-parallel --dpresimpl --dir --stop-after simpl ../examples/issue150.smt2 2>&1 | sed 's/[[:space:]]*$//'
  (and
    (= (+ (* 1171 w) (* (- 444) u) (* (- 1) x)) 0)
    (<= (+ (- 1170) (* 444 u)) 0)
    (<= (+ (- 99) strlenx) 0)
    (<= (+ 1 (* (- 1) strlenx)) 0)
    (<= (* (- 444) u) 0)
    (<= (* (- 1) x) 0)
    (str.in_re.raw x)
    (chrob.len x (** 10 strlenx)))
$ Chro -no-over-approx -bound -1 issue117.smt2 | sed 's/[[:space:]]*$//'



The portfolio forks three strategies and two of them enable -under-all, which
on this instance costs ~5GB each and outruns its own budget; the answer comes
from the plain strategy anyway. --no-parallel takes the first command from
9.9GB to 0.03GB and lets the second finish inside its limit.

  $ timeout 60 Chro -no-over -bound -1 --no-parallel ../examples/issue150.smt2 2>&1 | sed 's/[[:space:]]*$//'
  sat (nfa)
  (
     (define-fun u () Int
      0)
     (define-fun v () Int
      0)
     (define-fun w () Int
      105428759)
     (define-fun x () String
      "123457076789")
  )
