$ export CHRO_DEBUG=1
  $ export OCAMLRUNPARAM='b=0'
  $ cat > TODO1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (* x1 x2) 52))
  > (check-sat)
  > EOF
  $ Chro -bound 0 --dsimpl TODO1.smt2 | sed 's/[[:space:]]*$//'
  sat (under int)


$ export OCAMLRUNPARAM='b=0'
  $ cat > TODO1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (<= (** x1 2) 124))
  > (check-sat)
  > EOF
  $ Chro -bound 0 --dsimpl TODO1.smt2 | sed 's/[[:space:]]*$//'
  sat (under int)



  $ Chro --dsimpl ../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_83.smt2 | sed 's/[[:space:]]*$//'
  unsat (presimpl int)

  $ cat > TODO1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x1 () Int)
  > (declare-fun x2 () Int)
  > (assert (and
  >    (<= (* x1 x2) 52)
  >    (= 1 2)
  > ))
  > (check-sat)
  > EOF
  $ Chro -bound 0 --dsimpl TODO1.smt2 | sed 's/[[:space:]]*$//'
  unsat (presimpl int)


  $ cat > UnderDoesntHelp1.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun x () Int)
  > (declare-fun y () Int)
  > (declare-fun z () Int)
  > (assert (and
  >        (<= (* z y) 0)
  >        (<= (** 2 x) (- 1))
  > ))
  > (check-sat)
  > EOF
  $ export CHRO_DEBUG=simpl
  $ Chro -bound 2 --dsimpl UnderDoesntHelp1.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (* z y) 0)
             (<= (+ 1 %stdexp2) 0)
             (<= (* (- 1) x) 0)
             (= (+ %stdexp1 (* (- 1) x)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp1 -> x;
        %stdexp2 -> (** 2 %stdexp1);
        
  [+simpl]
    iter(2)= (and
             (= (+ %stdexp1 (* (- 1) x)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (<= (+ 1 %stdexp2) 0)
             (<= (* (- 1) x) 0)
             (<= (* y z) 0))
  [+simpl]
    iter(3)= (and
             (= (+ (** 2 %stdexp1) (* (- 1) (** 2 x))) 0)
             (<= (+ 1 (** 2 %stdexp1)) 0)
             (<= (* (- 1) x) 0)
             (<= (* y z) 0))
  [+simpl]
    iter(4)= (and
             (<= (+ 1 (** 2 x)) 0)
             (<= (* (- 1) x) 0)
             (<= (* y z) 0))
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (* z y) 0)
             (<= (+ 1 %stdexp2) 0)
             (<= (* (- 1) x) 0)
             (= (+ %stdexp1 (* (- 1) x)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    Something ready to substitute
        %stdexp1 -> x;
        %stdexp2 -> (** 2 %stdexp1);
        
  [+simpl]
    iter(2)= (and
             (= (+ %stdexp1 (* (- 1) x)) 0)
             (= (+ %stdexp2 (* (- 1) (** 2 %stdexp1))) 0)
             (<= (+ 1 %stdexp2) 0)
             (<= (* (- 1) x) 0)
             (<= (* y z) 0))
  [+simpl]
    iter(3)= (and
             (= (+ (** 2 %stdexp1) (* (- 1) (** 2 x))) 0)
             (<= (+ 1 (** 2 %stdexp1)) 0)
             (<= (* (- 1) x) 0)
             (<= (* y z) 0))
  [+simpl]
    iter(4)= (and
             (<= (+ 1 (** 2 x)) 0)
             (<= (* (- 1) x) 0)
             (<= (* y z) 0))
  [+simpl]
    fixed-point
  
  [+simpl]
    Basic simplifications:
  
  unsat (over)
The single exponent is not bad
  $ cat > TODO3.smt2 <<-EOF
  > (set-logic ALL)
  > (declare-fun it57 () Int)
  > (declare-fun it383 () Int)
  > (assert (and
  >        (<= (+ (* (- 1) it383) (** 2 it57)) 0)
  >        (<= (* (- 1) it57) (- 1))
  > ))
  > (check-sat)
  > EOF
  $ Chro -bound 2 --dsimpl TODO3.smt2 | sed 's/[[:space:]]*$//'
  [+simpl]
    Basic simplifications:
  
  [+simpl]
    iter(1)= (and
             (<= (+ (* (- 1) it383) (** 2 it57)) 0)
             (<= (+ 1 (* (- 1) it57)) 0))
  [+simpl]
    Alphabet with extra char: 0
  
  [+simpl]
    iter(2)= (and
             (<= (+ 1 (* (- 1) it57)) 0)
             (<= (+ (* (- 1) it383) (** 2 it57)) 0))
  [+simpl]
    fixed-point
  
  sat (under int)


