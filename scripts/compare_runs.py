#!/usr/bin/env python3
"""Compare a new run with the results of the paper, instance by instance.

    python3 scripts/compare_runs.py [--map NEW=PAPER ...] PAPER_DIR NEW_DIR

PAPER_DIR and NEW_DIR hold res-*.tsv files (paper-results/ of the artifact and
the results/ directory of your run).  For every configuration and benchmark
subset of NEW_DIR, only the instances that occur in both directories are
compared (so a run with SAMPLE=10 is compared with the same 10% of the paper's
run).  --map compares the configuration NEW of your run with the configuration
PAPER of the paper, e.g. --map chro-1.2.2_-q=chro_-q.

Prints per subset: the instances compared, sat and unsat in the paper and in
your run, the instances solved in only one of the two runs, and the number of
contradictions (sat in one run, unsat in the other), which must be 0.
Problem sets as in the paper: REln with 1-3 variables, RElnC with 2-3.
"""
import collections
import glob
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from stages_table import classify, problem_key  # noqa: E402


def load(d):
    """{label: {(set, subset, problem): verdict}}"""
    res = collections.defaultdict(dict)
    for f in glob.glob(os.path.join(d, 'res-*.tsv')):
        for line in open(f):
            c = line.rstrip('\n').split('\t')
            if len(c) < 4:
                continue
            key = classify(c[2])
            if key:
                res[c[0]][key + (problem_key(c[2]),)] = c[3]
    return res


def main(argv):
    mapping, dirs = {}, []
    it = iter(argv)
    for a in it:
        if a == '--map':
            new, paper = next(it).split('=')
            mapping[new] = paper
        else:
            dirs.append(a)
    if len(dirs) != 2:
        sys.exit(__doc__)
    paper, new = load(dirs[0]), load(dirs[1])
    total_contra = 0
    print('%-16s %-11s %-22s %6s %11s %11s %7s %7s %7s' % (
        'configuration', 'set', 'subset', 'inst', 'paper s/u', 'yours s/u', 'only p', 'only y', 'contra'))
    for label in sorted(new):
        plabel = mapping.get(label, label)
        if plabel not in paper:
            print('%-16s (no results of %s in %s)' % (label, plabel, dirs[0]))
            continue
        groups = collections.defaultdict(list)
        for key, v in new[label].items():
            if key in paper[plabel]:
                groups[key[0], key[1]].append((paper[plabel][key], v))
        for (s, sub), pairs in sorted(groups.items()):
            c = collections.Counter()
            for p, y in pairs:
                c['ps'] += p == 'sat'
                c['pu'] += p == 'unsat'
                c['ys'] += y == 'sat'
                c['yu'] += y == 'unsat'
                dp, dy = p in ('sat', 'unsat'), y in ('sat', 'unsat')
                c['op'] += dp and not dy
                c['oy'] += dy and not dp
                c['x'] += dp and dy and p != y
            total_contra += c['x']
            print('%-16s %-11s %-22s %6d %5d/%-5d %5d/%-5d %7d %7d %7d' % (
                label, s, sub, len(pairs), c['ps'], c['pu'], c['ys'], c['yu'], c['op'], c['oy'], c['x']))
    print('contradictions: %d' % total_contra)
    return 1 if total_contra else 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
