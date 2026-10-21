#!/usr/bin/env python3
"""Cross-check the results written by .github/workflows/run-benchmarks.sh.

    python3 scripts/check_results.py RESULTS_DIR [BENCH_ROOT]

RESULTS_DIR holds the res-*.tsv files of all solver configurations; each line
is  label suite file verdict stage wall_s cpu_s maxrss_kb exit.
BENCH_ROOT is the directory the file paths are relative to (default: the
current directory, i.e. the repository root), used to read the
(set-info :status ...) lines of the benchmarks.

Prints
  1. every instance on which one configuration says sat and another unsat;
  2. every answer that contradicts a (set-info :status ...) line;
  3. per configuration and suite: sat, unsat, unknown, timeout, the number of
     instances decided by this configuration only, and the wall time on the
     decided instances;
  4. per suite: the number of instances decided by at least one configuration;
  5. for every Chrobelias configuration (label starting with "chro"): the
     deciding stages, over all decided instances and over the instances that
     no other configuration decides.
Exit status 1 if section 1 or 2 is not empty.
"""
import collections
import glob
import os
import re
import sys

STATUS = re.compile(r'\(set-info\s+:status\s+(sat|unsat|unknown)\s*\)')
DECIDED = ('sat', 'unsat')


def main():
    rdir = sys.argv[1]
    root = sys.argv[2] if len(sys.argv) > 2 else '.'
    # rows[(label, suite)][file] = (verdict, stage, wall)
    rows = collections.defaultdict(dict)
    for path in sorted(glob.glob(os.path.join(rdir, 'res-*.tsv'))):
        for line in open(path):
            f = line.rstrip('\n').split('\t')
            if len(f) < 9:
                continue
            label, suite, inst, verdict, stage, wall = f[:6]
            try:
                wall = float(wall)
            except ValueError:
                wall = float('nan')
            rows[(label, suite)][os.path.normpath(inst)] = (verdict, stage, wall)

    by_inst = collections.defaultdict(dict)      # file -> label -> verdict
    suite_of = {}
    for (label, suite), res in rows.items():
        for inst, (v, _, _) in res.items():
            by_inst[inst][label] = v
            suite_of[inst] = suite

    bad = 0
    print('== 1. sat/unsat conflicts between configurations')
    for inst, vs in sorted(by_inst.items()):
        if 'sat' in vs.values() and 'unsat' in vs.values():
            bad += 1
            print('CONFLICT', inst, vs)
    print('conflicts:', bad)

    print('\n== 2. answers contradicting (set-info :status ...)')
    n = 0
    for inst, vs in sorted(by_inst.items()):
        try:
            m = STATUS.search(open(os.path.join(root, inst), errors='replace').read())
        except OSError:
            continue
        if not m or m.group(1) == 'unknown':
            continue
        for label, v in vs.items():
            if v in DECIDED and v != m.group(1):
                n += 1
                print('WRONG', label, inst, 'answered', v, 'status', m.group(1))
    print('contradictions:', n)
    bad += n

    def only(label, inst):
        return all(w not in DECIDED for o, w in by_inst[inst].items() if o != label)

    print('\n== 3. per configuration and suite')
    print(f'{"label":14s} {"suite":28s} {"sat":>6s} {"unsat":>6s} {"unkn":>6s} '
          f'{"t/o":>6s} {"only":>5s} {"time(s)":>9s}')
    for (label, suite), res in sorted(rows.items(), key=lambda x: (x[0][1], x[0][0])):
        c = collections.Counter(v for v, _, _ in res.values())
        o = sum(1 for inst, (v, _, _) in res.items() if v in DECIDED and only(label, inst))
        t = sum(w for v, _, w in res.values() if v in DECIDED)
        print(f'{label:14s} {suite:28s} {c["sat"]:6d} {c["unsat"]:6d} {c["unknown"]:6d} '
              f'{c["timeout"]:6d} {o:5d} {t:9.1f}')

    print('\n== 4. instances decided by at least one configuration')
    tot = collections.Counter(suite_of.values())
    vbs = collections.Counter(suite_of[i] for i, vs in by_inst.items()
                              if any(v in DECIDED for v in vs.values()))
    for suite in sorted(tot):
        print(f'{suite:28s} {vbs[suite]} of {tot[suite]}')

    print('\n== 5. Chrobelias deciding stages (all decided | decided by no other configuration)')
    for (label, suite), res in sorted(rows.items()):
        if not label.startswith('chro'):
            continue
        allc = collections.Counter(f'{v} ({s})' for v, s, _ in res.values() if v in DECIDED)
        onlyc = collections.Counter(f'{v} ({s})' for inst, (v, s, _) in res.items()
                                    if v in DECIDED and only(label, inst))
        print(f'{label} {suite}: {dict(allc.most_common())} | {dict(onlyc.most_common())}')

    sys.exit(1 if bad else 0)


if __name__ == '__main__':
    main()
