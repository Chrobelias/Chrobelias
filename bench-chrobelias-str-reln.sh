#!/usr/bin/env bash

export OCAMLRUNPARAM='b=0'
dune b bin/chro.exe --profile=release || exit 1
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n01.smt2 (0/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n02.smt2 (1/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n03.smt2 (2/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n04.smt2 (3/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n05.smt2 (4/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n06.smt2 (5/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n07.smt2 (6/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n08.smt2 (7/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n09.smt2 (8/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n10.smt2 (9/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n11.smt2 (10/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n12.smt2 (11/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n13.smt2 (12/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n14.smt2 (13/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n15.smt2 (14/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n16.smt2 (15/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w02_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n01.smt2 (16/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n02.smt2 (17/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n03.smt2 (18/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n04.smt2 (19/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n05.smt2 (20/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n06.smt2 (21/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n07.smt2 (22/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n08.smt2 (23/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n09.smt2 (24/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n10.smt2 (25/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n11.smt2 (26/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n12.smt2 (27/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n13.smt2 (28/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n14.smt2 (29/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n15.smt2 (30/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n16.smt2 (31/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w03_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n01.smt2 (32/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n02.smt2 (33/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n03.smt2 (34/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n04.smt2 (35/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n05.smt2 (36/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n06.smt2 (37/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n07.smt2 (38/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n08.smt2 (39/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n09.smt2 (40/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n10.smt2 (41/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n11.smt2 (42/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n12.smt2 (43/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n13.smt2 (44/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n14.smt2 (45/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n15.smt2 (46/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n16.smt2 (47/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w04_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n01.smt2 (48/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n02.smt2 (49/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n03.smt2 (50/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n04.smt2 (51/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n05.smt2 (52/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n06.smt2 (53/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n07.smt2 (54/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n08.smt2 (55/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n09.smt2 (56/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n10.smt2 (57/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n11.smt2 (58/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n12.smt2 (59/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n13.smt2 (60/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n14.smt2 (61/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n15.smt2 (62/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n16.smt2 (63/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w05_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n01.smt2 (64/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n02.smt2 (65/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n03.smt2 (66/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n04.smt2 (67/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n05.smt2 (68/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n06.smt2 (69/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n07.smt2 (70/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n08.smt2 (71/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n09.smt2 (72/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n10.smt2 (73/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n11.smt2 (74/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n12.smt2 (75/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n13.smt2 (76/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n14.smt2 (77/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n15.smt2 (78/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n16.smt2 (79/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v2_w06_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n01.smt2 (80/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n02.smt2 (81/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n03.smt2 (82/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n04.smt2 (83/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n05.smt2 (84/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n06.smt2 (85/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n07.smt2 (86/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n08.smt2 (87/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n09.smt2 (88/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n10.smt2 (89/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n11.smt2 (90/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n12.smt2 (91/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n13.smt2 (92/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n14.smt2 (93/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n15.smt2 (94/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n16.smt2 (95/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w02_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n01.smt2 (96/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n02.smt2 (97/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n03.smt2 (98/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n04.smt2 (99/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n05.smt2 (100/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n06.smt2 (101/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n07.smt2 (102/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n08.smt2 (103/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n09.smt2 (104/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n10.smt2 (105/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n11.smt2 (106/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n12.smt2 (107/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n13.smt2 (108/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n14.smt2 (109/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n15.smt2 (110/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n16.smt2 (111/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w03_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n01.smt2 (112/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n02.smt2 (113/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n03.smt2 (114/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n04.smt2 (115/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n05.smt2 (116/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n06.smt2 (117/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n07.smt2 (118/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n08.smt2 (119/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n09.smt2 (120/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n10.smt2 (121/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n11.smt2 (122/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n12.smt2 (123/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n13.smt2 (124/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n14.smt2 (125/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n15.smt2 (126/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n16.smt2 (127/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w04_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n01.smt2 (128/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n02.smt2 (129/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n03.smt2 (130/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n04.smt2 (131/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n05.smt2 (132/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n06.smt2 (133/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n07.smt2 (134/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n08.smt2 (135/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n09.smt2 (136/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n10.smt2 (137/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n11.smt2 (138/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n12.smt2 (139/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n13.smt2 (140/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n14.smt2 (141/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n15.smt2 (142/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n16.smt2 (143/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w05_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n01.smt2 (144/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n02.smt2 (145/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n03.smt2 (146/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n04.smt2 (147/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n05.smt2 (148/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n06.smt2 (149/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n07.smt2 (150/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n08.smt2 (151/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n09.smt2 (152/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n10.smt2 (153/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n11.smt2 (154/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n12.smt2 (155/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n13.smt2 (156/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n14.smt2 (157/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n15.smt2 (158/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n16.smt2 (159/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v3_w06_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n01.smt2 (160/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n02.smt2 (161/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n03.smt2 (162/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n04.smt2 (163/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n05.smt2 (164/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n06.smt2 (165/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n07.smt2 (166/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n08.smt2 (167/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n09.smt2 (168/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n10.smt2 (169/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n11.smt2 (170/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n12.smt2 (171/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n13.smt2 (172/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n14.smt2 (173/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n15.smt2 (174/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n16.smt2 (175/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w02_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n01.smt2 (176/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n02.smt2 (177/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n03.smt2 (178/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n04.smt2 (179/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n05.smt2 (180/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n06.smt2 (181/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n07.smt2 (182/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n08.smt2 (183/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n09.smt2 (184/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n10.smt2 (185/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n11.smt2 (186/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n12.smt2 (187/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n13.smt2 (188/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n14.smt2 (189/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n15.smt2 (190/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n16.smt2 (191/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w03_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n01.smt2 (192/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n02.smt2 (193/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n03.smt2 (194/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n04.smt2 (195/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n05.smt2 (196/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n06.smt2 (197/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n07.smt2 (198/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n08.smt2 (199/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n09.smt2 (200/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n10.smt2 (201/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n11.smt2 (202/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n12.smt2 (203/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n13.smt2 (204/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n14.smt2 (205/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n15.smt2 (206/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n16.smt2 (207/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w04_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n01.smt2 (208/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n02.smt2 (209/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n03.smt2 (210/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n04.smt2 (211/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n05.smt2 (212/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n06.smt2 (213/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n07.smt2 (214/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n08.smt2 (215/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n09.smt2 (216/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n10.smt2 (217/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n11.smt2 (218/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n12.smt2 (219/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n13.smt2 (220/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n14.smt2 (221/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n15.smt2 (222/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n16.smt2 (223/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w05_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n01.smt2 (224/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n02.smt2 (225/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n03.smt2 (226/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n04.smt2 (227/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n05.smt2 (228/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n06.smt2 (229/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n07.smt2 (230/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n08.smt2 (231/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n09.smt2 (232/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n10.smt2 (233/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n11.smt2 (234/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n12.smt2 (235/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n13.smt2 (236/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n14.smt2 (237/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n15.smt2 (238/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n16.smt2 (239/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v4_w06_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n01.smt2 (240/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n02.smt2 (241/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n03.smt2 (242/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n04.smt2 (243/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n05.smt2 (244/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n06.smt2 (245/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n07.smt2 (246/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n08.smt2 (247/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n09.smt2 (248/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n10.smt2 (249/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n11.smt2 (250/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n12.smt2 (251/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n13.smt2 (252/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n14.smt2 (253/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n15.smt2 (254/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n16.smt2 (255/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w02_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n01.smt2 (256/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n02.smt2 (257/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n03.smt2 (258/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n04.smt2 (259/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n05.smt2 (260/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n06.smt2 (261/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n07.smt2 (262/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n08.smt2 (263/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n09.smt2 (264/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n10.smt2 (265/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n11.smt2 (266/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n12.smt2 (267/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n13.smt2 (268/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n14.smt2 (269/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n15.smt2 (270/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n16.smt2 (271/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w03_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n01.smt2 (272/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n02.smt2 (273/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n03.smt2 (274/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n04.smt2 (275/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n05.smt2 (276/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n06.smt2 (277/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n07.smt2 (278/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n08.smt2 (279/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n09.smt2 (280/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n10.smt2 (281/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n11.smt2 (282/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n12.smt2 (283/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n13.smt2 (284/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n14.smt2 (285/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n15.smt2 (286/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n16.smt2 (287/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w04_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n01.smt2 (288/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n02.smt2 (289/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n03.smt2 (290/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n04.smt2 (291/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n05.smt2 (292/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n06.smt2 (293/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n07.smt2 (294/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n08.smt2 (295/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n09.smt2 (296/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n10.smt2 (297/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n11.smt2 (298/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n12.smt2 (299/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n13.smt2 (300/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n14.smt2 (301/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n15.smt2 (302/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n16.smt2 (303/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w05_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n01.smt2 (304/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n02.smt2 (305/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n03.smt2 (306/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n04.smt2 (307/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n05.smt2 (308/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n06.smt2 (309/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n07.smt2 (310/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n08.smt2 (311/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n09.smt2 (312/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n10.smt2 (313/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n11.smt2 (314/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n12.smt2 (315/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n13.smt2 (316/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n14.smt2 (317/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n15.smt2 (318/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n16.smt2 (319/320)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln//benchmark_v5_w06_n16.smt2}"
fi
