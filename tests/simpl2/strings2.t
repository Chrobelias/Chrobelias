  $ export CHRO_DEBUG=1
  $ cat > 1.smt2 <<-EOF
  > (set-logic QF_S)
  > (declare-const x String)
  > (declare-const y String)
  > (assert (= (str.++ "123" x) (str.++ y x)))
  > (assert (= y "321"))
  > (check-sat)
  > EOF

  $ Chro 1.smt2 | sed 's/[[:space:]]*$//'
  iter(1)= (and
             (= eeb6 (str.len x))
             (= eeb2 (str.len x))
             (= eeb6 eeb2)
             (= eeb5 (+ (* eeb7 (exp 10 eeb6)) eeb8))
             (= eeb8 (str.to.int x))
             (= eeb7 (str.to.int y))
             (= eeb2 eeb2)
             (= eeb1 (+ (* eeb3 (exp 10 eeb2)) eeb4))
             (= eeb4 (str.to.int x))
             (= eeb3 123)
             (= y "321")
             (= (str.from_int eeb1) (str.from_int eeb5)))
  Something ready to substitute:  eeb3 -> 123; eeb6 -> eeb2; y ->s "321";
  iter(2)= (and
             (= eeb1 (+ eeb4 (* eeb3 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb3 123)
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb6))))
             (= eeb6 eeb2)
             (= eeb6 (str.len x))
             (= eeb7 (str.to.int y))
             (= eeb8 (str.to.int x))
             (= eeb1 eeb5)
             (= y "321"))
  Something ready to substitute:  eeb1 ->s eeb5; eeb3 -> 123; eeb6 -> eeb2; y ->s
                                 "321";
  iter(3)= (and
             (= eeb1 (+ eeb4 (* 123 (exp 10 eeb2))))
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb2))))
             (= eeb7 (str.to.int "321"))
             (= eeb8 (str.to.int x))
             (= eeb1 eeb5))
  iter(4)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 123 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb2))))
             (= eeb7 321)
             (= eeb8 (str.to.int x)))
  Something ready to substitute:  eeb1 ->s eeb5; eeb3 -> 123; eeb6 -> eeb2; eeb7 ->
                                 321; y ->s "321";
  iter(5)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 123 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* eeb7 (exp 10 eeb2))))
             (= eeb7 321)
             (= eeb8 (str.to.int x)))
  iter(6)= (and
             (= eeb2 (str.len x))
             (= eeb4 (str.to.int x))
             (= eeb5 (+ eeb4 (* 123 (exp 10 eeb2))))
             (= eeb5 (+ eeb8 (* 321 (exp 10 eeb2))))
             (= eeb8 (str.to.int x)))
  iter(1)= (and
             (and
               (= (+ (* 1 eeb2) (* (- 1) %0)) 0)
               (= %1 (chrob.len x))
               (= (+ (* 1 (exp 10 %0)) (* (- 1) %1)) 1))
             (and
               (= eeb4 (str.to.int x)))
             (and
               (= (+ (* (- 123) (exp 10 eeb2)) (* 1 eeb5) (* (- 1) eeb4)) 0))
             (and
               (= (+ (* (- 321) (exp 10 eeb2)) (* (- 1) eeb8) (* 1 eeb5)) 0))
             (and
               (= eeb8 (str.to.int x))))
  iter(2)= (and
             (= %1 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ eeb2 (* (- 1) %0)) 0)
             (= (+ eeb5 (* (- 321) (exp 10 eeb2)) (* (- 1) eeb8)) 0)
             (= (+ eeb5 (* (- 123) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1))
  Something ready to substitute:  eeb2 -> %0; eeb5 -> (+ (* (* (- 321)
                                                            (exp 10 %0))
                                                         (- 1))
                                                      (* (* (- 1) eeb8) (- 1)));
  iter(3)= (and
             (= %1 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ eeb2 (* (- 1) %0)) 0)
             (= (+ eeb5 (* (- 321) (exp 10 eeb2)) (* (- 1) eeb8)) 0)
             (= (+ eeb5 (* (- 123) (exp 10 eeb2)) (* (- 1) eeb4)) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1))
  iter(4)= (and
             (= %1 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ (* (- 321) (exp 10 %0)) (* (- 1) eeb8)
                (* (* (- 321) (exp 10 %0)) (- 1)) (* (* (- 1) eeb8) (- 1))) 0)
             (= (+ (* (- 123) (exp 10 %0)) (* (- 1) eeb4)
                (* (* (- 321) (exp 10 %0)) (- 1)) (* (* (- 1) eeb8) (- 1))) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1))
  Something ready to substitute:  eeb2 -> %0; eeb4 -> (+ (* (- 123)
                                                         (exp 10 %0))
                                                      (* (* (- 321)
                                                         (exp 10 %0))
                                                      (- 1))
                                                      (* (* (- 1) eeb8) (- 1))); eeb5 ->
                                 (+ (* (* (- 321) (exp 10 %0)) (- 1))
                                 (* (* (- 1) eeb8) (- 1)));
  iter(5)= (and
             (= %1 (chrob.len x))
             (= eeb4 (str.to.int x))
             (= eeb8 (str.to.int x))
             (= (+ eeb8 (* (- 1) eeb4) (* 198 (exp 10 %0))) 0)
             (= (+ (* (- 1) %1) (exp 10 %0)) 1))
  iter(6)= (and
             (= %1 (chrob.len x))
             (= eeb8 (str.to.int x))
             (= (+ eeb8 (* 198 (exp 10 %0)) (* (* (- 123) (exp 10 %0)) (- 1))
                (* (* (* (- 321) (exp 10 %0)) (- 1)) (- 1))
                (* (* (* (- 1) eeb8) (- 1)) (- 1))) 0)
             (= (+ (* (- 123) (exp 10 %0)) (* (* (- 321) (exp 10 %0)) (- 1))
                (* (* (- 1) eeb8) (- 1))) (str.to.int x))
             (= (+ (* (- 1) %1) (exp 10 %0)) 1))
  iter(7)= (and
             (= %1 (chrob.len x))
             (= eeb8 (str.to.int x))
             (= (+ eeb8 (* 198 (exp 10 %0))) (str.to.int x))
             (= (+ (* (- 1) %1) (exp 10 %0)) 1))
  Done (= eeb8 (chrob.to.int x))
  
  Evaluated debugs/212531/1.svg
  0 -> %0
  1 -> %1
  2 -> eeb8
  3 -> x
  4 -> pow2(%0)
  states:[-198; -197; -196; -195; -194; -193; -192; -191; -190; -189; -188; -187; -186; -185; -184; -183; -182; -181; -180; -179; -178; -177; -176; -175; -174; -173; -172; -171; -170; -169; -168; -167; -166; -165; -164; -163; -162; -161; -160; -159; -158; -157; -156; -155; -154; -153; -152; -151; -150; -149; -148; -147; -146; -145; -144; -143; -142; -141; -140; -139; -138; -137; -136; -135; -134; -133; -132; -131; -130; -129; -128; -127; -126; -125; -124; -123; -122; -121; -120; -119; -118; -117; -116; -115; -114; -113; -112; -111; -110; -109; -108; -107; -106; -105; -104; -103; -102; -101; -100; -99; -98; -97; -96; -95; -94; -93; -92; -91; -90; -89; -88; -87; -86; -85; -84; -83; -82; -81; -80; -79; -78; -77; -76; -75; -74; -73; -72; -71; -70; -69; -68; -67; -66; -65; -64; -63; -62; -61; -60; -59; -58; -57; -56; -55; -54; -53; -52; -51; -50; -49; -48; -47; -46; -45; -44; -43; -42; -41; -40; -39; -38; -37; -36; -35; -34; -33; -32; -31; -30; -29; -28; -27; -26; -25; -24; -23; -22; -21; -20; -19; -18; -17; -16; -15; -14; -13; -12; -11; -10; -9; -8; -7; -6; -5; -4; -3; -2; -1; 0]
  Done (1eeb8 + -1x + 198pow2(%0) = 0)
  
  Evaluated debugs/212531/2.svg
  0 -> %0
  1 -> %1
  2 -> eeb8
  3 -> x
  4 -> pow2(%0)
  Done ((= eeb8 (chrob.to.int x)) & (1eeb8 + -1x + 198pow2(%0) = 0))
  
  Evaluated debugs/212531/3.svg
  0 -> %0
  1 -> %1
  2 -> eeb8
  3 -> x
  4 -> pow2(%0)
  Done (exists (eeb8) ((= eeb8 (chrob.to.int x)) & (1eeb8 + -1x + 198pow2(%0) = 0)))
  
  Evaluated debugs/212531/4.svg
  0 -> %0
  1 -> %1
  2 -> eeb8
  3 -> x
  4 -> pow2(%0)
  Done (= %1 (chrob.len x))
  
  Evaluated debugs/212531/5.svg
  0 -> %0
  1 -> %1
  2 -> eeb8
  3 -> x
  4 -> pow2(%0)
  states:[0; 1]
  Done (-1%1 + 1pow2(%0) = 1)
  
  Evaluated debugs/212531/6.svg
  0 -> %0
  1 -> %1
  2 -> eeb8
  3 -> x
  4 -> pow2(%0)
  Done ((= %1 (chrob.len x)) & (-1%1 + 1pow2(%0) = 1))
  
  Evaluated debugs/212531/7.svg
  0 -> %0
  1 -> %1
  2 -> eeb8
  3 -> x
  4 -> pow2(%0)
  Done (exists (%1) ((= %1 (chrob.len x)) & (-1%1 + 1pow2(%0) = 1)))
  
  Evaluated debugs/212531/8.svg
  0 -> %0
  1 -> %1
  2 -> eeb8
  3 -> x
  4 -> pow2(%0)
  Done ((exists (eeb8) ((= eeb8 (chrob.to.int x)) & (1eeb8 + -1x + 198pow2(%0) = 0))) & (exists (%1) ((= %1 (chrob.len x)) & (-1%1 + 1pow2(%0) = 1))))
  
  Evaluated debugs/212531/9.svg
  0 -> %0
  1 -> %1
  2 -> eeb8
  3 -> x
  4 -> pow2(%0)
  Done (exists (x) ((exists (eeb8) ((= eeb8 (chrob.to.int x)) & (1eeb8 + -1x + 198pow2(%0) = 0))) & (exists (%1) ((= %1 (chrob.len x)) & (-1%1 + 1pow2(%0) = 1)))))
  
  Evaluated debugs/212531/10.svg
  0 -> %0
  1 -> %1
  2 -> eeb8
  3 -> x
  4 -> pow2(%0)
  Minimized raw original nfa: debugs/212531/11.svg
  0 -> %0
  1 -> %1
  2 -> eeb8
  3 -> x
  4 -> pow2(%0)
  Minimized raw2 original nfa: debugs/212531/12.svg
  0 -> %0
  1 -> %1
  2 -> eeb8
  3 -> x
  4 -> pow2(%0)
  Minimized raw3 original nfa: debugs/212531/13.svg
  0 -> %0
  1 -> %1
  2 -> eeb8
  3 -> x
  4 -> pow2(%0)
  Minimized original nfa: debugs/212531/14.svg
  0 -> %0
  1 -> %1
  2 -> eeb8
  3 -> x
  4 -> pow2(%0)
  
  
  
  Trying order
  NFA taking order into account: debugs/212531/15.svg
  Nfa inside proof_order: debugs/212531/16.svg
  
  unsat
