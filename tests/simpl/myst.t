  $ export CHRO_DEBUG=simpl:under
  $ Chro -bound 0 --dsimpl --stop-after simpl ../../benchmarks/MysteriousProgram.jar-obl-12.smt2_9.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ 1 (* (- 1) it206)) 0)
             (<= (+ 1 (* (- 1) it223)) 0)
             (<= (+ (- 3) it205) 0)
             (<= (+ 3 (* (- 1) it205)) 0)
             (<= (+ 1 (* (- 1) it208) it207) 0)
             (<= (+ (* (- 1) it206) it25) 0)
             (<= (* (- 1) it207) 0)
             (<= (+ (* (- 1) it208) it223 it207) 0)
             (<= (* (- 1) it208) 0)
             (<= (+ 1 (* (- 1) it25)) 0)
             (= (+ (* (- 1) it16) it210) 0)
             (= (+ (* (- 1) it17) it209) 0)
             (= (+ (* (- 1) it197) it208) 0)
             (= it207 0)
             (= (+ (* (- 1) it20) it206) 0)
             (= (+ (- 3) it205) 0)
             (= (+ (- 2) it195) 0)
             (<= (* (- 1) it197) 0)
             (<= (+ (* (- 1) it198) it199) 0)
             (<= (+ it20 (* (- 1) it196)) 0)
             (<= (+ 1 (* (- 1) it196)) 0)
             (<= (+ 1 (* (- 1) it20)) 0)
             (= (+ it200 (* (- 1) it11)) 0)
             (= (+ (* (- 1) it179) it199) 0)
             (= (+ (* (- 1) it192) (* (- 1) it178) it198) 0)
             (= (+ it197 (* (- 1) it177 (exp 2 it192))) 0)
             (= (+ (* (- 1) it15) it196) 0)
             (= (+ (* (- 1) it175) it195) 0)
             (<= (+ 1 (* (- 1) it192)) 0)
             (<= (* (- 1) it179) 0)
             (<= (+ (- 2) it175) 0)
             (<= (+ 1 (* (- 1) it176)) 0)
             (<= (+ (* (- 1) it176) it15) 0)
             (<= (+ 2 (* (- 1) it177)) 0)
             (<= (+ 1 it178 (* (- 1) it179)) 0)
             (<= (+ 2 (* (- 1) it175)) 0)
             (<= (+ it192 it178 (* (- 1) it179)) 0)
             (<= (+ 1 (* (- 1) it15)) 0)
             (= (+ it180 (* (- 1) it6)) 0)
             (= (+ (* (- 1) it144) it179) 0)
             (= it178 0)
             (= (+ (- 2) it177) 0)
             (= (+ (* (- 1) it10) it176) 0)
             (= (+ (- 2) it175) 0)
             (<= (* (- 1) it144) 0)
             (= (+ (- 13) i1) 0)
             (<= (+ 1 (* (- 1) it10)) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        i1 -> 13;
        it176 -> it10;
        it177 -> 2;
        it178 -> 0;
        it179 -> it144;
        it180 -> it6;
        it195 -> 2;
        it196 -> it15;
        it197 -> (* it177 (exp 2 it192));
        it198 -> (+ it178 it192);
        it199 -> it179;
        it200 -> it11;
        it206 -> it20;
        it207 -> 0;
        it208 -> it197;
        it209 -> it17;
        it210 -> it16;
        
  [+simpl]
    iter(2)= (and
             (= it178 0)
             (= it207 0)
             (= (+ (- 13) i1) 0)
             (= (+ (- 3) it205) 0)
             (= (+ (- 2) it175) 0)
             (= (+ (- 2) it177) 0)
             (= (+ (- 2) it195) 0)
             (= (+ it180 (* (- 1) it6)) 0)
             (= (+ it197 (* (- 1) it177 (exp 2 it192))) 0)
             (= (+ (* (- 1) it10) it176) 0)
             (= (+ (* (- 1) it11) it200) 0)
             (= (+ (* (- 1) it144) it179) 0)
             (= (+ (* (- 1) it15) it196) 0)
             (= (+ (* (- 1) it16) it210) 0)
             (= (+ (* (- 1) it17) it209) 0)
             (= (+ (* (- 1) it175) it195) 0)
             (= (+ (* (- 1) it179) it199) 0)
             (= (+ (* (- 1) it192) (* (- 1) it178) it198) 0)
             (= (+ (* (- 1) it197) it208) 0)
             (= (+ (* (- 1) it20) it206) 0)
             (<= (+ (- 3) it205) 0)
             (<= (+ (- 2) it175) 0)
             (<= (+ 1 it178 (* (- 1) it179)) 0)
             (<= (+ 1 it207 (* (- 1) it208)) 0)
             (<= (+ 1 (* (- 1) it10)) 0)
             (<= (+ 1 (* (- 1) it15)) 0)
             (<= (+ 1 (* (- 1) it176)) 0)
             (<= (+ 1 (* (- 1) it192)) 0)
             (<= (+ 1 (* (- 1) it196)) 0)
             (<= (+ 1 (* (- 1) it20)) 0)
             (<= (+ 1 (* (- 1) it206)) 0)
             (<= (+ 1 (* (- 1) it223)) 0)
             (<= (+ 1 (* (- 1) it25)) 0)
             (<= (+ 2 (* (- 1) it175)) 0)
             (<= (+ 2 (* (- 1) it177)) 0)
             (<= (+ 3 (* (- 1) it205)) 0)
             (<= (+ it15 (* (- 1) it176)) 0)
             (<= (+ it178 (* (- 1) it179) it192) 0)
             (<= (+ it207 (* (- 1) it208) it223) 0)
             (<= (+ (* (- 1) it196) it20) 0)
             (<= (+ (* (- 1) it198) it199) 0)
             (<= (+ (* (- 1) it206) it25) 0)
             (<= (* (- 1) it144) 0)
             (<= (* (- 1) it179) 0)
             (<= (* (- 1) it197) 0)
             (<= (* (- 1) it207) 0)
             (<= (* (- 1) it208) 0))
  [+simpl]
    iter(3)= (and
             (= it178 0)
             (= (+ (- 3) it205) 0)
             (= (+ (- 2) it175) 0)
             (= (+ 2 (* (- 1) it175)) 0)
             (= (+ it197 (* (- 1) it177 (exp 2 it192))) 0)
             (= (+ (* (- 1) it144) it179) 0)
             (= (+ (* it177 (exp 2 it192)) (* (- 2) (exp 2 it192))) 0)
             (<= (+ (- 3) it205) 0)
             (<= (+ (- 2) it175) 0)
             (<= (+ 1 (* (- 1) it10)) 0)
             (<= (+ 1 (* (- 1) it144)) 0)
             (<= (+ 1 (* (- 1) it15)) 0)
             (<= (+ 1 (* (- 1) it192)) 0)
             (<= (+ 1 (* (- 1) it197)) 0)
             (<= (+ 1 (* (- 1) it20)) 0)
             (<= (+ 1 (* (- 1) it223)) 0)
             (<= (+ 1 (* (- 1) it25)) 0)
             (<= (+ 2 (* (- 1) it175)) 0)
             (<= (+ 3 (* (- 1) it205)) 0)
             (<= (+ it179 (* it178 (- 1)) (* it192 (- 1))) 0)
             (<= (+ (* (- 1) it10) it15) 0)
             (<= (+ (* (- 1) it144) it192) 0)
             (<= (+ (* (- 1) it15) it20) 0)
             (<= (+ (* (- 1) it197) it223) 0)
             (<= (+ (* (- 1) it20) it25) 0)
             (<= (* (- 1) it144) 0)
             (<= (* (- 1) it177 (exp 2 it192)) 0)
             (<= (* (- 1) it197) 0))
  [+simpl]
    iter(4)= (and
             (= (+ (- 3) it205) 0)
             (= (+ (- 2) it175) 0)
             (= (+ 2 (* (- 1) it175)) 0)
             (= (+ (* it177 (exp 2 it192)) (* (- 2) (exp 2 it192))) 0)
             (<= (+ 1 (* (- 1) it10)) 0)
             (<= (+ 1 (* (- 1) it144)) 0)
             (<= (+ 1 (* (- 1) it15)) 0)
             (<= (+ 1 (* (- 1) it177 (exp 2 it192))) 0)
             (<= (+ 1 (* (- 1) it192)) 0)
             (<= (+ 1 (* (- 1) it20)) 0)
             (<= (+ 1 (* (- 1) it223)) 0)
             (<= (+ 1 (* (- 1) it25)) 0)
             (<= (+ 3 (* (- 1) it205)) 0)
             (<= (+ it144 (* (- 1) it192)) 0)
             (<= (+ it223 (* (- 1) it177 (exp 2 it192))) 0)
             (<= (+ (* (- 1) it10) it15) 0)
             (<= (+ (* (- 1) it144) it192) 0)
             (<= (+ (* (- 1) it15) it20) 0)
             (<= (+ (* (- 1) it20) it25) 0)
             (<= (* (- 2) (exp 2 it192)) 0)
             (<= (* (- 1) it144) 0)
             (<= (* (- 1) it177 (exp 2 it192)) 0))
  [+simpl]
    Something ready to substitute
        i1 -> 13;
        it175 -> 2;
        it176 -> it10;
        it177 -> 2;
        it178 -> 0;
        it179 -> it144;
        it180 -> it6;
        it195 -> 2;
        it196 -> it15;
        it197 -> (* it177 (exp 2 it192));
        it198 -> (+ it178 it192);
        it199 -> it179;
        it200 -> it11;
        it205 -> 3;
        it206 -> it20;
        it207 -> 0;
        it208 -> it197;
        it209 -> it17;
        it210 -> it16;
        
  [+simpl]
    iter(5)= (and
             (= (+ (- 3) it205) 0)
             (= (+ (- 2) it175) 0)
             (= (+ 2 (* (- 1) it175)) 0)
             (<= (+ 1 (* (- 2) (exp 2 it192))) 0)
             (<= (+ 1 (* (- 1) it10)) 0)
             (<= (+ 1 (* (- 1) it144)) 0)
             (<= (+ 1 (* (- 1) it15)) 0)
             (<= (+ 1 (* (- 1) it192)) 0)
             (<= (+ 1 (* (- 1) it20)) 0)
             (<= (+ 1 (* (- 1) it223)) 0)
             (<= (+ 1 (* (- 1) it25)) 0)
             (<= (+ 3 (* (- 1) it205)) 0)
             (<= (+ it144 (* (- 1) it192)) 0)
             (<= (+ it223 (* (- 2) (exp 2 it192))) 0)
             (<= (+ (* (- 1) it10) it15) 0)
             (<= (+ (* (- 1) it144) it192) 0)
             (<= (+ (* (- 1) it15) it20) 0)
             (<= (+ (* (- 1) it20) it25) 0)
             (<= (* (- 2) (exp 2 it192)) 0)
             (<= (* (- 1) it144) 0))
  [+simpl]
    iter(6)= (and
             (<= (+ 1 (* (- 2) (exp 2 it192))) 0)
             (<= (+ 1 (* (- 1) it10)) 0)
             (<= (+ 1 (* (- 1) it144)) 0)
             (<= (+ 1 (* (- 1) it15)) 0)
             (<= (+ 1 (* (- 1) it192)) 0)
             (<= (+ 1 (* (- 1) it20)) 0)
             (<= (+ 1 (* (- 1) it223)) 0)
             (<= (+ 1 (* (- 1) it25)) 0)
             (<= (+ it144 (* (- 1) it192)) 0)
             (<= (+ it223 (* (- 2) (exp 2 it192))) 0)
             (<= (+ (* (- 1) it10) it15) 0)
             (<= (+ (* (- 1) it144) it192) 0)
             (<= (+ (* (- 1) it15) it20) 0)
             (<= (+ (* (- 1) it20) it25) 0)
             (<= (* (- 2) (exp 2 it192)) 0)
             (<= (* (- 1) it144) 0))
  [+simpl]
    fixed-point
  
  [+under]
    Bound for underapproximation: 2
  
  [+under]
    Interesting: it192
  
  [+under]
    Expecting 2 choices ...
  
  [+under]
    Into Z3 goes: (bool.and (bool.eq it192 0)
                 (bool.and
                  (bool.and
                   (bool.and
                    (bool.and
                     (bool.and
                      (bool.and
                       (bool.and
                        (bool.and
                         (bool.and
                          (bool.and
                           (bool.and
                            (bool.and
                             (bool.and
                              (bool.and
                               (bool.and
                                (int.le_s
                                 (int.add 1 (int.mul -2 (int.pow 2 it192))) 0)
                                (int.le_s (int.add 1 (int.mul -1 it10)) 0))
                               (int.le_s (int.add 1 (int.mul -1 it144)) 0))
                              (int.le_s (int.add 1 (int.mul -1 it15)) 0))
                             (int.le_s (int.add 1 (int.mul -1 it192)) 0))
                            (int.le_s (int.add 1 (int.mul -1 it20)) 0))
                           (int.le_s (int.add 1 (int.mul -1 it223)) 0))
                          (int.le_s (int.add 1 (int.mul -1 it25)) 0))
                         (int.le_s (int.add it144 (int.mul -1 it192)) 0))
                        (int.le_s
                         (int.add it223 (int.mul -2 (int.pow 2 it192))) 0))
                       (int.le_s (int.add (int.mul -1 it10) it15) 0))
                      (int.le_s (int.add (int.mul -1 it144) it192) 0))
                     (int.le_s (int.add (int.mul -1 it15) it20) 0))
                    (int.le_s (int.add (int.mul -1 it20) it25) 0))
                   (int.le_s (int.mul -2 (int.pow 2 it192)) 0))
                  (int.le_s (int.mul -1 it144) 0)))
  
  [+under]
    Into Z3 goes: (bool.and (bool.eq it192 0)
                 (bool.and
                  (bool.and
                   (bool.and
                    (bool.and
                     (bool.and
                      (bool.and
                       (bool.and
                        (bool.and
                         (bool.and
                          (bool.and
                           (bool.and
                            (bool.and
                             (bool.and
                              (bool.and
                               (bool.and
                                (int.le_s
                                 (int.add 1 (int.mul -2 (int.pow 2 it192))) 0)
                                (int.le_s (int.add 1 (int.mul -1 it10)) 0))
                               (int.le_s (int.add 1 (int.mul -1 it144)) 0))
                              (int.le_s (int.add 1 (int.mul -1 it15)) 0))
                             (int.le_s (int.add 1 (int.mul -1 it192)) 0))
                            (int.le_s (int.add 1 (int.mul -1 it20)) 0))
                           (int.le_s (int.add 1 (int.mul -1 it223)) 0))
                          (int.le_s (int.add 1 (int.mul -1 it25)) 0))
                         (int.le_s (int.add it144 (int.mul -1 it192)) 0))
                        (int.le_s
                         (int.add it223 (int.mul -2 (int.pow 2 it192))) 0))
                       (int.le_s (int.add (int.mul -1 it10) it15) 0))
                      (int.le_s (int.add (int.mul -1 it144) it192) 0))
                     (int.le_s (int.add (int.mul -1 it15) it20) 0))
                    (int.le_s (int.add (int.mul -1 it20) it25) 0))
                   (int.le_s (int.mul -2 (int.pow 2 it192)) 0))
                  (int.le_s (int.mul -1 it144) 0)))
  
  [+under]
    Into Z3 goes: (bool.and (bool.eq it192 1)
                 (bool.and
                  (bool.and
                   (bool.and
                    (bool.and
                     (bool.and
                      (bool.and
                       (bool.and
                        (bool.and
                         (bool.and
                          (bool.and
                           (bool.and
                            (bool.and
                             (bool.and
                              (bool.and
                               (bool.and
                                (int.le_s
                                 (int.add 1 (int.mul -2 (int.pow 2 it192))) 0)
                                (int.le_s (int.add 1 (int.mul -1 it10)) 0))
                               (int.le_s (int.add 1 (int.mul -1 it144)) 0))
                              (int.le_s (int.add 1 (int.mul -1 it15)) 0))
                             (int.le_s (int.add 1 (int.mul -1 it192)) 0))
                            (int.le_s (int.add 1 (int.mul -1 it20)) 0))
                           (int.le_s (int.add 1 (int.mul -1 it223)) 0))
                          (int.le_s (int.add 1 (int.mul -1 it25)) 0))
                         (int.le_s (int.add it144 (int.mul -1 it192)) 0))
                        (int.le_s
                         (int.add it223 (int.mul -2 (int.pow 2 it192))) 0))
                       (int.le_s (int.add (int.mul -1 it10) it15) 0))
                      (int.le_s (int.add (int.mul -1 it144) it192) 0))
                     (int.le_s (int.add (int.mul -1 it15) it20) 0))
                    (int.le_s (int.add (int.mul -1 it20) it25) 0))
                   (int.le_s (int.mul -2 (int.pow 2 it192)) 0))
                  (int.le_s (int.mul -1 it144) 0)))
  
  [+under]
    Into Z3 goes: (bool.and (bool.eq it192 1)
                 (bool.and
                  (bool.and
                   (bool.and
                    (bool.and
                     (bool.and
                      (bool.and
                       (bool.and
                        (bool.and
                         (bool.and
                          (bool.and
                           (bool.and
                            (bool.and
                             (bool.and
                              (bool.and
                               (bool.and
                                (int.le_s
                                 (int.add 1 (int.mul -2 (int.pow 2 it192))) 0)
                                (int.le_s (int.add 1 (int.mul -1 it10)) 0))
                               (int.le_s (int.add 1 (int.mul -1 it144)) 0))
                              (int.le_s (int.add 1 (int.mul -1 it15)) 0))
                             (int.le_s (int.add 1 (int.mul -1 it192)) 0))
                            (int.le_s (int.add 1 (int.mul -1 it20)) 0))
                           (int.le_s (int.add 1 (int.mul -1 it223)) 0))
                          (int.le_s (int.add 1 (int.mul -1 it25)) 0))
                         (int.le_s (int.add it144 (int.mul -1 it192)) 0))
                        (int.le_s
                         (int.add it223 (int.mul -2 (int.pow 2 it192))) 0))
                       (int.le_s (int.add (int.mul -1 it10) it15) 0))
                      (int.le_s (int.add (int.mul -1 it144) it192) 0))
                     (int.le_s (int.add (int.mul -1 it15) it20) 0))
                    (int.le_s (int.add (int.mul -1 it20) it25) 0))
                   (int.le_s (int.mul -2 (int.pow 2 it192)) 0))
                  (int.le_s (int.mul -1 it144) 0)))
  
  [+under]
    lib/Underapprox.ml gives early Sat on (and
                                          (<= (+ 1 (* (- 2) (exp 2 it192))) 0)
                                          (<= (+ 1 (* (- 1) it10)) 0)
                                          (<= (+ 1 (* (- 1) it144)) 0)
                                          (<= (+ 1 (* (- 1) it15)) 0)
                                          (<= (+ 1 (* (- 1) it192)) 0)
                                          (<= (+ 1 (* (- 1) it20)) 0)
                                          (<= (+ 1 (* (- 1) it223)) 0)
                                          (<= (+ 1 (* (- 1) it25)) 0)
                                          (<= (+ it144 (* (- 1) it192)) 0)
                                          (<= (+ it223 (* (- 2) (exp 2 it192))) 0)
                                          (<= (+ (* (- 1) it10) it15) 0)
                                          (<= (+ (* (- 1) it144) it192) 0)
                                          (<= (+ (* (- 1) it15) it20) 0)
                                          (<= (+ (* (- 1) it20) it25) 0)
                                          (<= (* (- 2) (exp 2 it192)) 0)
                                          (<= (* (- 1) it144) 0)).
  sat (under int)
