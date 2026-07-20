$ cat input1.smt2
  $ CHRO_DEBUG=1 Chro --dsimpl --stop-after pre-simpl input1.smt2 | sed 's/[[:space:]]*$//'

$ /usr/bin/time -f "TIME: %U"
  $ timeout 5 Chro input1.smt2 | echo "timeout"
  timeout

$ /usr/bin/time -f "TIME: %U"
  $ Chro input1.smt2 | sed 's/[[:space:]]*$//'
  sat (under int)

