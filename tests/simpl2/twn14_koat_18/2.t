$ cat input2.smt2
  $ CHRO_DEBUG=1 Chro --dsimpl --stop-after pre-simpl input2.smt2 | sed 's/[[:space:]]*$//'

$ /usr/bin/time -f "TIME: %U"
  $ timeout 5 Chro input2.smt2 || echo "timeout"
  sat (under int)

$ CHRO_DEBUG=1
$ /usr/bin/time -f "TIME: %U"
  $ Chro input2.smt2 | sed 's/[[:space:]]*$//'
  sat (under int)


