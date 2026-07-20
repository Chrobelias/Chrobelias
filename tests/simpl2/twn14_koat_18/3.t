$ cat input3.smt2
  $ CHRO_DEBUG=1 Chro --dsimpl --stop-after pre-simpl input3.smt2 | sed 's/[[:space:]]*$//'

$ /usr/bin/time -f "TIME: %U"
  $ timeout 5 Chro input3.smt2 || echo "timeout"
  sat (under int)

$ export CHRO_DEBUG=1
$ /usr/bin/time -f "TIME: %U"
  $ Chro input3.smt2 --dir --dsimpl 2>&1 | sed 's/[[:space:]]*$//'
  sat (under int)


