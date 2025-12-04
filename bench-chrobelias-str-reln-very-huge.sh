#!/usr/bin/env bash

export OCAMLRUNPARAM='b=0'
dune b bin/chro.exe --profile=release || exit 1
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n01.smt2 (0/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n02.smt2 (1/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n03.smt2 (2/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n04.smt2 (3/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n05.smt2 (4/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n06.smt2 (5/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n07.smt2 (6/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n08.smt2 (7/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n09.smt2 (8/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n10.smt2 (9/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n11.smt2 (10/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n12.smt2 (11/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n13.smt2 (12/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n14.smt2 (13/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n15.smt2 (14/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n16.smt2 (15/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w02_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n01.smt2 (16/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n02.smt2 (17/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n03.smt2 (18/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n04.smt2 (19/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n05.smt2 (20/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n06.smt2 (21/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n07.smt2 (22/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n08.smt2 (23/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n09.smt2 (24/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n10.smt2 (25/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n11.smt2 (26/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n12.smt2 (27/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n13.smt2 (28/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n14.smt2 (29/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n15.smt2 (30/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n16.smt2 (31/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w03_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n01.smt2 (32/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n02.smt2 (33/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n03.smt2 (34/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n04.smt2 (35/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n05.smt2 (36/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n06.smt2 (37/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n07.smt2 (38/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n08.smt2 (39/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n09.smt2 (40/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n10.smt2 (41/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n11.smt2 (42/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n12.smt2 (43/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n13.smt2 (44/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n14.smt2 (45/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n15.smt2 (46/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n16.smt2 (47/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w04_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n01.smt2 (48/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n02.smt2 (49/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n03.smt2 (50/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n04.smt2 (51/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n05.smt2 (52/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n06.smt2 (53/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n07.smt2 (54/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n08.smt2 (55/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n09.smt2 (56/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n10.smt2 (57/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n11.smt2 (58/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n12.smt2 (59/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n13.smt2 (60/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n14.smt2 (61/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n15.smt2 (62/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n16.smt2 (63/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w05_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n01.smt2 (64/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n02.smt2 (65/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n03.smt2 (66/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n04.smt2 (67/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n05.smt2 (68/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n06.smt2 (69/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n07.smt2 (70/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n08.smt2 (71/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n09.smt2 (72/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n10.smt2 (73/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n11.smt2 (74/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n12.smt2 (75/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n13.smt2 (76/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n14.smt2 (77/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n15.smt2 (78/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n16.smt2 (79/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v2_w06_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n01.smt2 (80/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n02.smt2 (81/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n03.smt2 (82/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n04.smt2 (83/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n05.smt2 (84/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n06.smt2 (85/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n07.smt2 (86/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n08.smt2 (87/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n09.smt2 (88/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n10.smt2 (89/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n11.smt2 (90/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n12.smt2 (91/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n13.smt2 (92/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n14.smt2 (93/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n15.smt2 (94/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n16.smt2 (95/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w02_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n01.smt2 (96/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n02.smt2 (97/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n03.smt2 (98/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n04.smt2 (99/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n05.smt2 (100/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n06.smt2 (101/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n07.smt2 (102/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n08.smt2 (103/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n09.smt2 (104/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n10.smt2 (105/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n11.smt2 (106/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n12.smt2 (107/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n13.smt2 (108/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n14.smt2 (109/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n15.smt2 (110/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n16.smt2 (111/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w03_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n01.smt2 (112/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n02.smt2 (113/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n03.smt2 (114/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n04.smt2 (115/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n05.smt2 (116/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n06.smt2 (117/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n07.smt2 (118/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n08.smt2 (119/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n09.smt2 (120/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n10.smt2 (121/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n11.smt2 (122/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n12.smt2 (123/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n13.smt2 (124/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n14.smt2 (125/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n15.smt2 (126/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n16.smt2 (127/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w04_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n01.smt2 (128/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n02.smt2 (129/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n03.smt2 (130/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n04.smt2 (131/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n05.smt2 (132/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n06.smt2 (133/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n07.smt2 (134/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n08.smt2 (135/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n09.smt2 (136/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n10.smt2 (137/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n11.smt2 (138/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n12.smt2 (139/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n13.smt2 (140/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n14.smt2 (141/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n15.smt2 (142/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n16.smt2 (143/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w05_n16.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n01.smt2 (144/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n01.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n01.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n01.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n01.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n01.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n01.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n01.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n01.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n01.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n01.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n01.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n02.smt2 (145/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n02.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n02.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n02.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n02.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n02.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n02.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n02.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n02.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n02.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n02.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n02.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n03.smt2 (146/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n03.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n03.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n03.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n03.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n03.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n03.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n03.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n03.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n03.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n03.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n03.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n04.smt2 (147/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n04.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n04.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n04.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n04.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n04.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n04.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n04.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n04.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n04.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n04.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n04.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n05.smt2 (148/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n05.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n05.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n05.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n05.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n05.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n05.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n05.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n05.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n05.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n05.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n05.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n06.smt2 (149/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n06.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n06.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n06.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n06.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n06.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n06.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n06.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n06.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n06.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n06.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n06.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n07.smt2 (150/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n07.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n07.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n07.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n07.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n07.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n07.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n07.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n07.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n07.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n07.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n07.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n08.smt2 (151/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n08.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n08.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n08.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n08.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n08.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n08.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n08.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n08.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n08.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n08.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n08.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n09.smt2 (152/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n09.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n09.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n09.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n09.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n09.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n09.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n09.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n09.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n09.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n09.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n09.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n10.smt2 (153/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n10.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n10.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n10.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n10.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n10.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n10.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n10.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n10.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n10.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n10.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n10.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n11.smt2 (154/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n11.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n11.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n11.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n11.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n11.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n11.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n11.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n11.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n11.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n11.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n11.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n12.smt2 (155/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n12.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n12.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n12.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n12.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n12.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n12.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n12.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n12.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n12.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n12.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n12.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n13.smt2 (156/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n13.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n13.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n13.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n13.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n13.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n13.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n13.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n13.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n13.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n13.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n13.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n14.smt2 (157/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n14.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n14.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n14.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n14.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n14.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n14.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n14.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n14.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n14.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n14.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n14.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n15.smt2 (158/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n15.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n15.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n15.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n15.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n15.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n15.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n15.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n15.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n15.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n15.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n15.smt2}"
fi
#
export TIMEOUT=60
printf '
benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n16.smt2 (159/160)...
'
APPROX='-bound 10 -over-early'
FLAT='-flat 0 -amin 0 -amax 100000'
if timeout $TIMEOUT time -f 'THETIME %U' dune exec Chro --profile=release -- $APPROX $FLAT benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n16.smt2 --q  > .log 2> .errlog
then
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo " \CHROUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n16.smt2}"
    grep '^unsat' -A 1 .log || true
  elif grep -q '^sat' .log; then
    echo "\CHROSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n16.smt2}"
    grep '^sat' -A 1 .log || true
  elif grep -q '^unknown' .log; then
    echo "\CHROUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n16.smt2}"
  fi
else
    echo "\CHROTIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n16.smt2}"
fi
echo '
Executing Swine on benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n16.smt2'
echo '' > .log
if timeout $TIMEOUT time -f 'THETIME %U' dune exec bin/swine --profile=release -- benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n16.smt2 > .log 2> .errlog
then
  #pr -T -o 11 .log
  TIME=$(grep THETIME .errlog | awk '{print $2}')
  echo time is "$TIME"
  if grep -q '^unsat' .log; then
    echo "\SWINEUNSAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n16.smt2}"
  elif grep -q '^sat' .log; then
    echo "\SWINESAT{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n16.smt2}"
  elif grep -q '^unknown' .log; then
    echo "\SWINEUNK{$TIME}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n16.smt2}"
  else
    echo 'BAD'
  fi
else
    echo "\SWINETIMEOUT{$TIMEOUT}{benchmarks/chrobelias/QF_SLIA/2025-generated-strreln/str-reln-very-huge//benchmark_v3_w06_n16.smt2}"
fi
