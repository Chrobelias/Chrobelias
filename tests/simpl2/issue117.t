
  $ CHRO_DEBUG=simpl:nfa Chro -no-over -bound -1 --dpresimpl --stop-after presimpl issue117.smt2  | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ 100 (* (- 1) x) (* (- 1) y) (* (- 1) z) (* (- 1) u)
                 (* (- 1) v)) 0)
             (= (+ %stdexp2 (* (- 1) v)) 0)
             (= (+ %stdexp4 (* (- 1) u)) 0)
             (= (+ %stdexp6 (* (- 1) z)) 0)
             (= (+ %stdexp8 (* (- 1) y)) 0)
             (<= (* (- 1) x) 0)
             (= (+ %stdexp7 (* (- 1) x)) 0)
             (= (+ %stdexp8 (* (- 1) (** 2 %stdexp7))) 0)
             (<= (+ 1 (* (- 1) x)) 0)
             (= (+ 1 %stdexp5 (* (- 1) x)) 0)
             (= (+ %stdexp6 (* (- 1) (** 2 %stdexp5))) 0)
             (<= (+ 3 (* (- 1) x)) 0)
             (= (+ 3 %stdexp3 (* (- 1) x)) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (<= (+ 5 (* (- 1) x)) 0)
             (= (+ 5 %stdexp1 (* (- 1) x)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp2 -> v;
        %stdexp4 -> u;
        %stdexp6 -> z;
        %stdexp7 -> x;
        %stdexp8 -> y;
        
  [+simpl]
    iter(2)= (and
             (= (+ 1 %stdexp5 (* (- 1) x)) 0)
             (= (+ 3 %stdexp3 (* (- 1) x)) 0)
             (= (+ 5 %stdexp1 (* (- 1) x)) 0)
             (= (+ %stdexp2 (* (- 1) v)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (= (+ %stdexp4 (* (- 1) u)) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (= (+ %stdexp6 (* (- 1) z)) 0)
             (= (+ %stdexp6 (* (- 1) (** 2 %stdexp5))) 0)
             (= (+ %stdexp7 (* (- 1) x)) 0)
             (= (+ %stdexp8 (* (- 1) y)) 0)
             (= (+ %stdexp8 (* (- 1) (** 2 %stdexp7))) 0)
             (<= (+ 1 (* (- 1) x)) 0)
             (<= (+ 3 (* (- 1) x)) 0)
             (<= (+ 5 (* (- 1) x)) 0)
             (<= (+ 100 (* (- 1) x) (* (- 1) y) (* (- 1) z) (* (- 1) u)
                 (* (- 1) v)) 0)
             (<= (* (- 1) x) 0))
  [+simpl]
    Something ready to substitute
        %stdexp2 -> v;
        %stdexp4 -> u;
        %stdexp6 -> z;
        %stdexp7 -> x;
        %stdexp8 -> y;
        u -> (** 2 %stdexp3);
        v -> (** 2 %stdexp1);
        y -> (** 2 x);
        z -> (** 2 %stdexp5);
        
  [+simpl]
    iter(3)= (and
             (= (+ 1 %stdexp5 (* (- 1) x)) 0)
             (= (+ 3 %stdexp3 (* (- 1) x)) 0)
             (= (+ 5 %stdexp1 (* (- 1) x)) 0)
             (= (+ u (* (- 1) (** 2 %stdexp3))) 0)
             (= (+ v (* (- 1) (** 2 %stdexp1))) 0)
             (= (+ y (* (- 1) (** 2 x))) 0)
             (= (+ z (* (- 1) (** 2 %stdexp5))) 0)
             (<= (+ 1 (* (- 1) x)) 0)
             (<= (+ 3 (* (- 1) x)) 0)
             (<= (+ 5 (* (- 1) x)) 0)
             (<= (+ 100 (* (- 1) x) (* (- 1) y) (* (- 1) z) (* (- 1) u)
                 (* (- 1) v)) 0)
             (<= (* (- 1) x) 0))
  [+simpl]
    iter(4)= (and
             (= (+ 1 %stdexp5 (* (- 1) x)) 0)
             (= (+ 3 %stdexp3 (* (- 1) x)) 0)
             (= (+ 5 %stdexp1 (* (- 1) x)) 0)
             (<= (+ 1 (* (- 1) x)) 0)
             (<= (+ 3 (* (- 1) x)) 0)
             (<= (+ 5 (* (- 1) x)) 0)
             (<= (+ 100 (* (- 1) x) (* (- 1) (** 2 x))
                 (* (- 1) (** 2 %stdexp5)) (* (- 1) (** 2 %stdexp3))
                 (* (- 1) (** 2 %stdexp1))) 0)
             (<= (* (- 1) x) 0))
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ 100 (* (- 1) x) (* (- 1) y) (* (- 1) z) (* (- 1) u)
                 (* (- 1) v)) 0)
             (= (+ %stdexp2 (* (- 1) v)) 0)
             (= (+ %stdexp4 (* (- 1) u)) 0)
             (= (+ %stdexp6 (* (- 1) z)) 0)
             (= (+ %stdexp8 (* (- 1) y)) 0)
             (<= (* (- 1) x) 0)
             (= (+ %stdexp7 (* (- 1) x)) 0)
             (= (+ %stdexp8 (* (- 1) (** 2 %stdexp7))) 0)
             (<= (+ 1 (* (- 1) x)) 0)
             (= (+ 1 %stdexp5 (* (- 1) x)) 0)
             (= (+ %stdexp6 (* (- 1) (** 2 %stdexp5))) 0)
             (<= (+ 3 (* (- 1) x)) 0)
             (= (+ 3 %stdexp3 (* (- 1) x)) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (<= (+ 5 (* (- 1) x)) 0)
             (= (+ 5 %stdexp1 (* (- 1) x)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp2 -> v;
        %stdexp4 -> u;
        %stdexp6 -> z;
        %stdexp7 -> x;
        %stdexp8 -> y;
        
  [+simpl]
    iter(2)= (and
             (= (+ 1 %stdexp5 (* (- 1) x)) 0)
             (= (+ 3 %stdexp3 (* (- 1) x)) 0)
             (= (+ 5 %stdexp1 (* (- 1) x)) 0)
             (= (+ %stdexp2 (* (- 1) v)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (= (+ %stdexp4 (* (- 1) u)) 0)
             (= (+ %stdexp4 (* (- 1) (** 2 %stdexp3))) 0)
             (= (+ %stdexp6 (* (- 1) z)) 0)
             (= (+ %stdexp6 (* (- 1) (** 2 %stdexp5))) 0)
             (= (+ %stdexp7 (* (- 1) x)) 0)
             (= (+ %stdexp8 (* (- 1) y)) 0)
             (= (+ %stdexp8 (* (- 1) (** 2 %stdexp7))) 0)
             (<= (+ 1 (* (- 1) x)) 0)
             (<= (+ 3 (* (- 1) x)) 0)
             (<= (+ 5 (* (- 1) x)) 0)
             (<= (+ 100 (* (- 1) x) (* (- 1) y) (* (- 1) z) (* (- 1) u)
                 (* (- 1) v)) 0)
             (<= (* (- 1) x) 0))
  [+simpl]
    Something ready to substitute
        %stdexp2 -> v;
        %stdexp4 -> u;
        %stdexp6 -> z;
        %stdexp7 -> x;
        %stdexp8 -> y;
        u -> (** 2 %stdexp3);
        v -> (** 2 %stdexp1);
        y -> (** 2 x);
        z -> (** 2 %stdexp5);
        
  [+simpl]
    iter(3)= (and
             (= (+ 1 %stdexp5 (* (- 1) x)) 0)
             (= (+ 3 %stdexp3 (* (- 1) x)) 0)
             (= (+ 5 %stdexp1 (* (- 1) x)) 0)
             (= (+ u (* (- 1) (** 2 %stdexp3))) 0)
             (= (+ v (* (- 1) (** 2 %stdexp1))) 0)
             (= (+ y (* (- 1) (** 2 x))) 0)
             (= (+ z (* (- 1) (** 2 %stdexp5))) 0)
             (<= (+ 1 (* (- 1) x)) 0)
             (<= (+ 3 (* (- 1) x)) 0)
             (<= (+ 5 (* (- 1) x)) 0)
             (<= (+ 100 (* (- 1) x) (* (- 1) y) (* (- 1) z) (* (- 1) u)
                 (* (- 1) v)) 0)
             (<= (* (- 1) x) 0))
  [+simpl]
    iter(4)= (and
             (= (+ 1 %stdexp5 (* (- 1) x)) 0)
             (= (+ 3 %stdexp3 (* (- 1) x)) 0)
             (= (+ 5 %stdexp1 (* (- 1) x)) 0)
             (<= (+ 1 (* (- 1) x)) 0)
             (<= (+ 3 (* (- 1) x)) 0)
             (<= (+ 5 (* (- 1) x)) 0)
             (<= (+ 100 (* (- 1) x) (* (- 1) (** 2 x))
                 (* (- 1) (** 2 %stdexp5)) (* (- 1) (** 2 %stdexp3))
                 (* (- 1) (** 2 %stdexp1))) 0)
             (<= (* (- 1) x) 0))
  [+simpl]
    fixed-point
  
  (and
    (= (+ 1 %stdexp5 (* (- 1) x)) 0)
    (= (+ 3 %stdexp3 (* (- 1) x)) 0)
    (= (+ 5 %stdexp1 (* (- 1) x)) 0)
    (<= (+ 1 (* (- 1) x)) 0)
    (<= (+ 3 (* (- 1) x)) 0)
    (<= (+ 5 (* (- 1) x)) 0)
    (<= (+ 100 (* (- 1) x) (* (- 1) (** 2 x)) (* (- 1) (** 2 %stdexp5))
        (* (- 1) (** 2 %stdexp3)) (* (- 1) (** 2 %stdexp1))) 0)
    (<= (* (- 1) x) 0))
  $ Chro -no-over -bound -1 issue117.smt2 | sed 's/[[:space:]]*$//'
  sat (nfa)

