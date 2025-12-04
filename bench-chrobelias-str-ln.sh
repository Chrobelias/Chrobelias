#!/usr/bin/env bash

export OCAMLRUNPARAM='b=0'
dune b bin/chro.exe --profile=release || exit 1
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n01.smt2 (0/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n02.smt2 (1/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n03.smt2 (2/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n04.smt2 (3/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n05.smt2 (4/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w02_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n01.smt2 (5/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n02.smt2 (6/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n03.smt2 (7/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n04.smt2 (8/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n05.smt2 (9/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w03_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n01.smt2 (10/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n02.smt2 (11/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n03.smt2 (12/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n04.smt2 (13/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n05.smt2 (14/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w04_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n01.smt2 (15/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n02.smt2 (16/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n03.smt2 (17/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n04.smt2 (18/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n05.smt2 (19/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w05_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n01.smt2 (20/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n02.smt2 (21/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n03.smt2 (22/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n04.smt2 (23/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n05.smt2 (24/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v2_w06_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n01.smt2 (25/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n02.smt2 (26/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n03.smt2 (27/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n04.smt2 (28/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n05.smt2 (29/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w02_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n01.smt2 (30/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n02.smt2 (31/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n03.smt2 (32/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n04.smt2 (33/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n05.smt2 (34/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w03_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n01.smt2 (35/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n02.smt2 (36/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n03.smt2 (37/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n04.smt2 (38/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n05.smt2 (39/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w04_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n01.smt2 (40/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n02.smt2 (41/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n03.smt2 (42/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n04.smt2 (43/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n05.smt2 (44/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w05_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n01.smt2 (45/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n02.smt2 (46/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n03.smt2 (47/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n04.smt2 (48/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n05.smt2 (49/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v3_w06_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n01.smt2 (50/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n02.smt2 (51/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n03.smt2 (52/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n04.smt2 (53/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n05.smt2 (54/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w02_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n01.smt2 (55/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n02.smt2 (56/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n03.smt2 (57/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n04.smt2 (58/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n05.smt2 (59/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w03_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n01.smt2 (60/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n02.smt2 (61/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n03.smt2 (62/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n04.smt2 (63/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n05.smt2 (64/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w04_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n01.smt2 (65/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n02.smt2 (66/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n03.smt2 (67/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n04.smt2 (68/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n05.smt2 (69/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w05_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n01.smt2 (70/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n02.smt2 (71/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n03.smt2 (72/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n04.smt2 (73/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n05.smt2 (74/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v4_w06_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n01.smt2 (75/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n02.smt2 (76/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n03.smt2 (77/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n04.smt2 (78/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n05.smt2 (79/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w02_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n01.smt2 (80/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n02.smt2 (81/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n03.smt2 (82/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n04.smt2 (83/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n05.smt2 (84/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w03_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n01.smt2 (85/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n02.smt2 (86/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n03.smt2 (87/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n04.smt2 (88/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n05.smt2 (89/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w04_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n01.smt2 (90/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n02.smt2 (91/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n03.smt2 (92/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n04.smt2 (93/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n05.smt2 (94/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w05_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n01.smt2 (95/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n02.smt2 (96/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n03.smt2 (97/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n04.smt2 (98/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n05.smt2 (99/100)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-ln//benchmark_v5_w06_n05.smt2}"
fi
