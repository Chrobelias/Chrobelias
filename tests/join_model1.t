  $ export CHRO_DEBUG=1
  $ cat > j1.smt2 <<-EOF
  > (set-logic ALL)
  > (assert (= (+ 5 y (* (- 7) u)) 0))
  > (assert (= (+ 2 y (* (- 3) x)) 0))
  > (assert (>= z 100))
  > (check-sat)
  > (get-model)
  > EOF

  $ Chro -pre-simpl -dsimpl -stop-after pre-simpl j1.smt2 | sed 's/[[:space:]]*$//'
