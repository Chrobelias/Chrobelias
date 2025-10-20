  $ Chro -flat 0 -amin 0 -amax 0 ./subst.smt2 
  unknown
  ; Under2 resigns
  sat ; under III

  $ Chro -flat 0 -amin 0 -amax 0 ./subst-2.smt2 
  unknown
  ; Under2 resigns
  unknown
  ; Under3 resigns

  $ Chro -flat 0 -amin 0 -amax 0 ./subst-3.smt2 
  unknown
  ; Under2 resigns
  unknown
  ; Under3 resigns
