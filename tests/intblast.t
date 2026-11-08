  $ cat > query.smt2 <<-'EOF'
  > (set-info :status unknown)
  > (set-logic QF_ABV)
  > (declare-sort Address 0)
  >  (declare-fun value!0 () Address)
  > (declare-fun |inputField<TvmFieldImpl(enclosingType=TvmCellType, name=dataLength)>()| () (Array Address (_ BitVec 32)))
  > (declare-fun value!2 () Address)
  > (declare-fun |inputField<TvmFieldImpl(enclosingType=TvmCellType, name=refsLength)>()| () (Array Address (_ BitVec 32)))
  > (declare-fun |tracked#0| () (_ BitVec 257))
  > (declare-fun value!3 () Address)
  > (declare-fun |tracked#6| () (_ BitVec 257))
  > (declare-fun value!4 () Address)
  > (declare-fun null () Address)
  > (declare-fun |tracked#3| () (_ BitVec 8))
  > (declare-fun |tracked#2| () (_ BitVec 257))
  > (assert
  >  (let ((?x8 (select |inputField<TvmFieldImpl(enclosingType=TvmCellType, name=dataLength)>()| value!0)))
  >  (let (($x10 (bvsle (_ bv0 32) ?x8)))
  >  (let ((?x14 (select |inputField<TvmFieldImpl(enclosingType=TvmCellType, name=refsLength)>()| value!2)))
  >  (let (($x15 (= (_ bv0 32) ?x14)))
  >  (let (($x18 (bvsle |tracked#0| (_ bv4102444800 257))))
  >  (let ((?x22 (select |inputField<TvmFieldImpl(enclosingType=TvmCellType, name=dataLength)>()| value!3)))
  >  (let (($x23 (bvsle ?x22 (_ bv1023 32))))
  >  (let (($x24 (bvsle (_ bv0 32) ?x22)))
  >  (let (($x27 (bvsle (_ bv0 257) |tracked#6|)))
  >  (let (($x31 (= null value!4)))
  >  (let ((?x32 (select |inputField<TvmFieldImpl(enclosingType=TvmCellType, name=refsLength)>()| value!3)))
  >  (let (($x33 (bvsle (_ bv0 32) ?x32)))
  >  (let (($x35 (bvsle (_ bv1712318909 257) |tracked#0|)))
  >  (let ((?x37 (select |inputField<TvmFieldImpl(enclosingType=TvmCellType, name=refsLength)>()| value!0)))
  >  (let (($x38 (bvsle ?x37 (_ bv4 32))))
  >  (let (($x39 (bvsle ?x8 (_ bv1023 32))))
  >  (let ((?x41 ((_ sign_extend 249) |tracked#3|)))
  >  (let (($x42 (= (_ bv0 257) ?x41)))
  >  (let (($x44 (= (_ bv231584178474632390847141970017375815706539969331281128078915168015826259279871 257) ?x41)))
  >  (let (($x45 (or $x44 $x42)))
  >  (let ((?x46 (select |inputField<TvmFieldImpl(enclosingType=TvmCellType, name=dataLength)>()| value!2)))
  >  (let (($x48 (= (_ bv267 32) ?x46)))
  >  (let (($x50 (bvsle (_ bv0 257) |tracked#2|)))
  >  (let (($x51 (bvsle ?x32 (_ bv4 32))))
  >  (let (($x52 (bvsle (_ bv0 32) ?x37)))
  >  (and $x52 $x51 $x50 $x48 $x45 $x39 $x38 $x35 $x33 $x31 $x27 $x24 $x23 $x18 $x15 $x10)))))))))))))))))))))))))))
  > (check-sat)
  > 
  > EOF

  $ Chro query.smt2
  sat (under int)

  $ cat > slt_wrap.smt2 <<-'EOF'
  > (set-logic QF_BV)
  > (declare-fun x () (_ BitVec 8))
  > (declare-fun y () (_ BitVec 8))
  > (assert (bvsle (_ bv128 8) (_ bv0 8)))
  > (check-sat)
  > EOF

  $ Chro slt_wrap.smt2
  sat (under int)

  $ cat > sext_neg.smt2 <<-'EOF'
  > (set-logic QF_BV)
  > (declare-fun x () (_ BitVec 8))
  > (declare-fun y () (_ BitVec 8))
  > (assert (= ((_ sign_extend 8) (_ bv255 8)) (_ bv1 16)))
  > (check-sat)
  > EOF

  $ Chro sext_neg.smt2
  unsat (presimpl int)

  $ cat > add_ovf2.smt2 <<-'EOF'
  > (set-logic QF_BV)
  > (declare-fun x () (_ BitVec 8))
  > (declare-fun y () (_ BitVec 8))
  > (assert (and (= x (_ bv200 8)) (= (bvadd x x) (_ bv145 8))))
  > (check-sat)
  > EOF

  $ Chro add_ovf2.smt2
  unsat (nia)

  $ cat > ext2.smt2 <<-'EOF'
  > (set-logic QF_BV)
  > (declare-fun x () (_ BitVec 8))
  > (declare-fun y () (_ BitVec 8))
  > (assert (and (= x #xA5) (= ((_ extract 6 3) x) #b0101)))
  > (check-sat)
  > EOF

  $ Chro ext2.smt2
  unsat (nia)

  $ cat > mul.smt2 <<-'EOF'
  > (set-logic QF_BV)
  > (declare-fun x () (_ BitVec 8))
  > (declare-fun y () (_ BitVec 8))
  > (assert (and (= x (_ bv100 8)) (= (bvmul x (_ bv3 8)) (_ bv44 8))))
  > (check-sat)
  > EOF

  $ Chro mul.smt2
  sat (under int)

  $ cat > udiv.smt2 <<-'EOF'
  > (set-logic QF_BV)
  > (declare-fun x () (_ BitVec 8))
  > (declare-fun y () (_ BitVec 8))
  > (assert (and (= x (_ bv100 8)) (= (bvudiv x (_ bv7 8)) (_ bv14 8)) (= (bvurem x (_ bv7 8)) (_ bv2 8))))
  > (check-sat)
  > EOF

  $ Chro udiv.smt2
  sat (under int)

  $ cat > sel_unsat.smt2 <<-'EOF'
  > (set-logic QF_ABV)
  > (declare-sort S 0)
  > (declare-fun i () S)
  > (declare-fun j () S)
  > (declare-fun A () (Array S (_ BitVec 32)))
  > (assert (= i j))
  > (assert (distinct (select A i) (select A j)))
  > (check-sat)
  > EOF

  $ Chro sel_unsat.smt2
  unsat (nia)

  $ cat > sel_sat.smt2 <<-'EOF'
  > (set-logic QF_ABV)
  > (declare-sort S 0)
  > (declare-fun i () S)
  > (declare-fun j () S)
  > (declare-fun A () (Array S (_ BitVec 32)))
  > (assert (distinct (select A i) (select A j)))
  > (check-sat)
  > EOF

  $ Chro sel_sat.smt2
  sat (under int)

  $ cat > big.smt2 <<-'EOF'
  > (declare-fun x () Int)
  > (assert (<= 0 x))
  > (assert (<= x 9223372036854775808))
  > (check-sat)
  > EOF

  $ Chro big.smt2
  sat (under int)

