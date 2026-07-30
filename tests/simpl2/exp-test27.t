  $ export CHRO_TRACE_OPT=1
  $ export CHRO_DEBUG=simpl:over

  $ Chro -huge-c 100 --dpresimpl --stop-after simpl ../examples/exp-test27.smt2
  [+simpl]
    iter(1)= (and
             (<= (+ (- 99) (str.len x)) 0)
             (= (mod (mod (str.to.int x) 29) 11) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    Alphabet with extra char:  0 1 2 3 4 5 6 8
  
  [+simpl]
    iter(2)= (and
             (= (mod (mod (str.to.int x) 29) 11) 0)
             (<= (+ (- 99) (str.len x)) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (and
             (= (mod (mod (str.to.int x) 29) 11) 0)
             (<= (+ (- 99) (str.len x)) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    Alphabet with extra char:  0 1 2 3 4 5 6 8
  
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (and
             (= (mod (mod @stoix 29) 11) 0)
             (<= (+ (- 99) @strlenx) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    Alphabet with extra char:  0 1 2 3 4 5 6 8
  
  [+simpl]
    fixed-point
  
  [+over]
    CHECK OVER  (and
                (= (mod (mod (str.to.int x) 29) 11) 0)
                (<= (+ (- 99) strlenx) 0)
                (<= (* (- 1) @@re_len1) 0)
                (= (+ (- 9) strlenx (* (- 2) @@re_len1)) 0)
                (<= (* (- 1) strlenx) 0)) 
  [+over]
    whole: (bool.and
          (bool.and
           (bool.and (int.le_s (int.add -99 strlenx) 0)
            (int.le_s (int.mul -1 @@re_len1) 0))
           (bool.eq (int.add (int.add -9 strlenx) (int.mul -2 @@re_len1)) 0))
          (int.le_s (int.mul -1 strlenx) 0))
  
  Early SAT in lib/Overapprox.ml ~~> Unknown
  (model
    (@@re_len1 int 0)
    (strlenx int 9))
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re ""))))))))))))))
             (= %r3 0)
             (<= (+ (- 99) (str.len x)) 0)
             (<= (* (- 1) (str.to.int x)) 0)
             (= (+ %r1 (* (- 11) %q4) (* (- 1) %r3)) 0)
             (<= (+ (- 10) %r3) 0)
             (<= (* (- 1) %r3) 0)
             (= (+ (str.to.int x) (* (- 29) %q2) (* (- 1) %r1)) 0)
             (<= (+ (- 28) %r1) 0)
             (<= (* (- 1) %r1) 0))
  [+simpl]
    Alphabet with extra char:  0 1 2 3 4 5 6 8
  
  [+simpl]
    Something ready to substitute
        %r3 -> 0;
        
  [+simpl]
    iter(2)= (and
             (= %r3 0)
             (= (+ (* (- 29) %q2) (* (- 1) %r1) (str.to.int x)) 0)
             (= (+ (* (- 11) %q4) %r1 (* (- 1) %r3)) 0)
             (<= (+ (- 99) (str.len x)) 0)
             (<= (+ (- 28) %r1) 0)
             (<= (+ (- 10) %r3) 0)
             (<= (* (- 1) %r1) 0)
             (<= (* (- 1) %r3) 0)
             (<= (* (- 1) (str.to.int x)) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    Something ready to substitute
        %r1 -> (* 11 %q4);
        %r3 -> 0;
        
  [+simpl]
    iter(3)= (and
             (= (+ (* (- 29) %q2) (* (- 1) %r1) (str.to.int x)) 0)
             (= (+ (* (- 11) %q4) %r1) 0)
             (<= (+ (- 99) (str.len x)) 0)
             (<= (+ (- 28) %r1) 0)
             (<= (* (- 1) %r1) 0)
             (<= (* (- 1) (str.to.int x)) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    iter(4)= (and
             (= (+ (* (- 29) %q2) (* (- 11) %q4) (str.to.int x)) 0)
             (<= (+ (- 99) (str.len x)) 0)
             (<= (+ (- 28) (* 11 %q4)) 0)
             (<= (* (- 11) %q4) 0)
             (<= (* (- 1) (str.to.int x)) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (and
             (= (+ (* (- 29) %q2) (* (- 11) %q4) (str.to.int x)) 0)
             (<= (+ (- 99) (str.len x)) 0)
             (<= (+ (- 28) (* 11 %q4)) 0)
             (<= (* (- 11) %q4) 0)
             (<= (* (- 1) (str.to.int x)) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    Alphabet with extra char:  0 1 2 3 4 5 6 8
  
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ (* (- 29) %q2) (* (- 11) %q4) x) 0)
             (<= (* (- 1) x) 0)
             (<= (+ (- 99) strlenx) 0)
             (chrob.len x (exp 10 strlenx))
             (<= (+ 1 (* (- 1) strlenx)) 0)
             (<= (+ (- 28) (* 11 %q4)) 0)
             (<= (* (- 11) %q4) 0)
             (<= (* (- 1) x) 0)
             (<= (* (- 1) x) 0)
             (str.in_re.raw x))
  [+simpl]
    Alphabet with extra char:  0 1 2 3 4 5 6 8
  
  [+simpl]
    iter(2)= (and
             (= (+ (* (- 29) %q2) (* (- 11) %q4) x) 0)
             (<= (+ (- 99) strlenx) 0)
             (<= (+ (- 28) (* 11 %q4)) 0)
             (<= (+ 1 (* (- 1) strlenx)) 0)
             (<= (* (- 11) %q4) 0)
             (<= (* (- 1) x) 0)
             (str.in_re.raw x)
             (chrob.len x (exp 10 strlenx)))
  [+simpl]
    fixed-point
  
  (and
    (= (+ (* (- 29) %q2) (* (- 11) %q4) x) 0)
    (<= (+ (- 99) strlenx) 0)
    (<= (+ (- 28) (* 11 %q4)) 0)
    (<= (+ 1 (* (- 1) strlenx)) 0)
    (<= (* (- 11) %q4) 0)
    (<= (* (- 1) x) 0)
    (str.in_re.raw x)
    (chrob.len x (exp 10 strlenx)))

  $ unset CHRO_TRACE_OPT
  $ timeout 15 Chro ../examples/exp-test27.smt2 -huge-c 99
  [+simpl]
    iter(1)= (and
             (<= (+ (- 99) (str.len x)) 0)
             (= (mod (mod (str.to.int x) 29) 11) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    Alphabet with extra char:  0 1 2 3 4 5 6 8
  
  [+simpl]
    iter(2)= (and
             (= (mod (mod (str.to.int x) 29) 11) 0)
             (<= (+ (- 99) (str.len x)) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (and
             (= (mod (mod (str.to.int x) 29) 11) 0)
             (<= (+ (- 99) (str.len x)) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    Alphabet with extra char:  0 1 2 3 4 5 6 8
  
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (and
             (= (mod (mod @stoix 29) 11) 0)
             (<= (+ (- 99) @strlenx) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    Alphabet with extra char:  0 1 2 3 4 5 6 8
  
  [+simpl]
    fixed-point
  
  [+over]
    CHECK OVER  (and
                (= (mod (mod (str.to.int x) 29) 11) 0)
                (<= (+ (- 99) strlenx) 0)
                (<= (* (- 1) @@re_len1) 0)
                (= (+ (- 9) strlenx (* (- 2) @@re_len1)) 0)
                (<= (* (- 1) strlenx) 0)) 
  [+over]
    whole: (bool.and
          (bool.and
           (bool.and (int.le_s (int.add -99 strlenx) 0)
            (int.le_s (int.mul -1 @@re_len1) 0))
           (bool.eq (int.add (int.add -9 strlenx) (int.mul -2 @@re_len1)) 0))
          (int.le_s (int.mul -1 strlenx) 0))
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re ""))))))))))))))
             (= %r3 0)
             (<= (+ (- 99) (str.len x)) 0)
             (<= (* (- 1) (str.to.int x)) 0)
             (= (+ %r1 (* (- 11) %q4) (* (- 1) %r3)) 0)
             (<= (+ (- 10) %r3) 0)
             (<= (* (- 1) %r3) 0)
             (= (+ (str.to.int x) (* (- 29) %q2) (* (- 1) %r1)) 0)
             (<= (+ (- 28) %r1) 0)
             (<= (* (- 1) %r1) 0))
  [+simpl]
    Alphabet with extra char:  0 1 2 3 4 5 6 8
  
  [+simpl]
    Something ready to substitute
        %r3 -> 0;
        
  [+simpl]
    iter(2)= (and
             (= %r3 0)
             (= (+ (* (- 29) %q2) (* (- 1) %r1) (str.to.int x)) 0)
             (= (+ (* (- 11) %q4) %r1 (* (- 1) %r3)) 0)
             (<= (+ (- 99) (str.len x)) 0)
             (<= (+ (- 28) %r1) 0)
             (<= (+ (- 10) %r3) 0)
             (<= (* (- 1) %r1) 0)
             (<= (* (- 1) %r3) 0)
             (<= (* (- 1) (str.to.int x)) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    Something ready to substitute
        %r1 -> (* 11 %q4);
        %r3 -> 0;
        
  [+simpl]
    iter(3)= (and
             (= (+ (* (- 29) %q2) (* (- 1) %r1) (str.to.int x)) 0)
             (= (+ (* (- 11) %q4) %r1) 0)
             (<= (+ (- 99) (str.len x)) 0)
             (<= (+ (- 28) %r1) 0)
             (<= (* (- 1) %r1) 0)
             (<= (* (- 1) (str.to.int x)) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    iter(4)= (and
             (= (+ (* (- 29) %q2) (* (- 11) %q4) (str.to.int x)) 0)
             (<= (+ (- 99) (str.len x)) 0)
             (<= (+ (- 28) (* 11 %q4)) 0)
             (<= (* (- 11) %q4) 0)
             (<= (* (- 1) (str.to.int x)) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    fixed-point
  
  [+simpl]
    iter(0)= (and
             (= (+ (* (- 29) %q2) (* (- 11) %q4) (str.to.int x)) 0)
             (<= (+ (- 99) (str.len x)) 0)
             (<= (+ (- 28) (* 11 %q4)) 0)
             (<= (* (- 11) %q4) 0)
             (<= (* (- 1) (str.to.int x)) 0)
             (str.in_re x (re.++ (str.to.re "6") (re.++ (str.to.re "2") (re.++ (re.* (re.++ (str.to.re "6") (str.to.re "2"))) (re.++ (str.to.re "2") (re.++ (str.to.re "8") (re.++ (re.* (re.++ (str.to.re "2") (str.to.re "8"))) (re.++ (str.to.re "5") (re.++ (str.to.re "4") (re.++ (str.to.re "3") (re.++ (str.to.re "2") (re.++ (str.to.re "1") (re.* (str.to.re "")))))))))))))))
  [+simpl]
    Alphabet with extra char:  0 1 2 3 4 5 6 8
  
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (= (+ (* (- 29) %q2) (* (- 11) %q4) x) 0)
             (<= (* (- 1) x) 0)
             (<= (+ (- 99) strlenx) 0)
             (chrob.len x (exp 10 strlenx))
             (<= (+ 1 (* (- 1) strlenx)) 0)
             (<= (+ (- 28) (* 11 %q4)) 0)
             (<= (* (- 11) %q4) 0)
             (<= (* (- 1) x) 0)
             (<= (* (- 1) x) 0)
             (str.in_re.raw x))
  [+simpl]
    Alphabet with extra char:  0 1 2 3 4 5 6 8
  
  [+simpl]
    iter(2)= (and
             (= (+ (* (- 29) %q2) (* (- 11) %q4) x) 0)
             (<= (+ (- 99) strlenx) 0)
             (<= (+ (- 28) (* 11 %q4)) 0)
             (<= (+ 1 (* (- 1) strlenx)) 0)
             (<= (* (- 11) %q4) 0)
             (<= (* (- 1) x) 0)
             (str.in_re.raw x)
             (chrob.len x (exp 10 strlenx)))
  [+simpl]
    fixed-point
  
  [+over]
    whole: (bool.and
          (exists (%q2 %q4 x)
           (bool.and
            (bool.and
             (bool.and
              (bool.and
               (bool.and
                (bool.eq
                 (int.add (int.add x (int.mul -11 %q4)) (int.mul -29 %q2)) 0)
                (int.le_s (int.mul -1 x) 0))
               (int.le_s (int.add 1 (int.mul -1 strlenx)) 0))
              (int.le_s (int.add -99 strlenx) 0))
             (int.le_s (int.mul -1 %q4) 0)) (int.le_s (int.add -2 %q4) 0)))
          (int.le_s (int.add (int.add 1 (int.mul -1 exp_10_strlenx)) strlenx)
           0))
         (int.lt_s (int.mul 9 strlenx) exp_10_strlenx)
  
  sat (nfa)
  (
     (define-fun x () String
      "1234582822626262626262626262626262626262626262626262626262626262626262626262626")
  )
