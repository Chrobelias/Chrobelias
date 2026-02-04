Basic QF_EIA tests

  $ Chro ./qf-eia.smt2
  sat (under I)
  unsat (nfa)
  unsat (nfa)
  sat (presimpl)
  unsat (nfa)
  sat (under I)
  unsat (nfa)
  unsat (presimpl)
  unsat (presimpl)
  sat (presimpl)
  unsat (nfa)
  sat (under I)
  unsat (nfa)
  sat (presimpl)

Basic QF_EIA tests using only NFAs

  $ Chro -bound -1 -no-over ./qf-eia.smt2
  sat (nfa)
  unsat (nfa)
  unsat (nfa)
  sat (presimpl)
  unsat (nfa)
  sat (nfa)
  unsat (nfa)
  unsat (presimpl)
  unsat (presimpl)
  sat (presimpl)
  unsat (nfa)
  sat (nfa)
  unsat (nfa)
  sat (presimpl)

Same basic QF_EIA tests using only NFAs but in the LSB mode

  $ Chro -lsb -bound -1 -no-over ./qf-eia.smt2
  sat (nfa)
  unsat (nfa)
  unsat (nfa)
  sat (presimpl)
  unsat (nfa)
  sat (nfa)
  unsat (nfa)
  unsat (presimpl)
  unsat (presimpl)
  sat (presimpl)
  unsat (nfa)
  sat (nfa)
  unsat (nfa)
  sat (presimpl)

Test ExEy y >=0 x & 2**y = x & x > 4

  $ Chro ./examples/QF_EIA/basic-exp-sat.smt2
  sat (nfa)

Test Ex x > 2**x

  $ Chro ./examples/QF_EIA/basic-exp-unsat.smt2
  unsat (over)

Test ExEyEz y = 2**x & z = 2**y & z mod 10 = 6

  $ Chro -bound -1 ./examples/QF_EIA/double_exp-10-sat.smt2
  sat (nfa)

Test ExEyEz y = 2**x & z = 2**y & z mod 100 = 36

  $ Chro ./examples/QF_EIA/double_exp-100-sat.smt2
  sat (nfa)
  (
     (define-fun x () Int
      12)
     (define-fun y () Int
      4096)
     (define-fun z () Int
      1044388881413152506691752710716624382579964249047383780384233483283953907971557456848826811934997558340890106714439262837987573438185793607263236087851365277945956976543709998340361590134383718314428070011855946226376318839397712745672334684344586617496807908705803704071284048740118609114467977783598029006686938976881787785946905630190260940599579453432823469303026696443059025015972399867714215541693835559885291486318237914434496734087811872639496475100189041349008417061675093668333850551032972088269550769983616369411933015213796825837188091833656751221318492846368125550225998300412344784862595674492194617023806505913245610825731835380087608622102834270197698202313169017678006675195485079921636419370285375124784014907159135459982790513399611551794271106831134090584272884279791554849782954323534517065223269061394905987693002122963395687782878948440616007412945674919823050571642377154816321380631045902916136926708342856440730447899971901781465763473223850267253059899795996090799469201774624817718449867455659250178329070473119433165550807568221846571746373296884912819520317457002440926616910874148385078411929804522981857338977648103126085903001302413467189726673216491511131602920781738033436090243804708340403154190336)
  )

Test ExEyEz y = 2**x & z = 2**y & z mod 100 = 36 with -lsb

  $ Chro ./examples/QF_EIA/double_exp-100-sat.smt2 -lsb
  sat (nfa)
  (
     (define-fun x () Int
      4)
     (define-fun y () Int
      16)
     (define-fun z () Int
      65536)
  )

Test Frobenius coin problem with exponential restrictions (MS: omit due to quantifier alternations)

$ timeout 2 Chro -bound 0 -no-over ./examples/fcp_7_11_with_exps.smt2
sat (nfa)

Test Double exponent theorem

  $ Chro ./examples/double_exp.smt2
  unsat (nfa)

Test EXP-solver simplified problems

  $ Chro ./examples/hash_3_6.smt2
  sat (nfa)
  (
     (define-fun u () Int
      1)
     (define-fun v () Int
      0)
     (define-fun w () Int
      20576111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111112)
     (define-fun x () String
      "123456666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666669")
  )

  $ Chro ./examples/hash_130_137.smt2
  sat (nfa)
  (
     (define-fun u () Int
      0)
     (define-fun v () Int
      0)
     (define-fun w () Int
      89655680896556808965568089655680896556808965568089655680896556808965568089655680896556808965597)
     (define-fun x () String
      "12282828282828282828282828282828282828282828282828282828282828282828282828282828282828282828286789")
  )
