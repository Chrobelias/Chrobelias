  $ cat issue92.smt2

  $ export CHRO_DEBUG=1
  $ Chro -no-over-approx -bound 0 -dsimpl -under2 issue92.smt2 | sed 's/[[:space:]]*$//'
  asdf