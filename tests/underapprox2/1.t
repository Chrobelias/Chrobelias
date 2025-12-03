
  $ timeout 2 Chro -no-over -bound -1 -flat 0 -amin 0 -amax 0 -lsb --dsimpl issue92.smt2  | sed 's/[[:space:]]*$//'
  sat (non-linear)
