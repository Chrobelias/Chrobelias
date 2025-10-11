  $ Chro -under3 -flat 0 -amin 0 -amax 0 -no-pre-simpl ./subst.smt2 
  unknown
  ; Under2 resigns
  sat ; under III

  $ Chro -under3 -flat 0 -amin 0 -amax 0 -no-pre-simpl ./subst-2.smt2 
  unknown
  ; Under2 resigns
  unknown
  ; Under3 resigns

  $ Chro -under3 -flat 0 -amin 0 -amax 0 -no-pre-simpl ./subst-3.smt2 
  unknown
  ; Under2 resigns
  unknown
  ; Under3 resigns
