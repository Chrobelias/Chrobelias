#!/usr/bin/env python3
"""Check the output of smoke-test.sh and make_tables.py (see BENCHES.md).

    python3 scripts/check_smoke.py RESULTS_DIR STATS_DIR TABLES_DIR

Prints every failure and exits with 1 if there is any.  bench.sh always exits
with 0 and records a solver that crashes as "unknown", so the exit codes of the
smoke test and the tables say little.  Exact sat/unsat counts are not checked:
they depend on the machine at the 1 s timeout of the smoke test.
"""
import collections
import csv
import glob
import os
import sys

# 3 eia families * 2 solvers + 4 slia families * 5 solvers, see bench.sh.
EXPECTED_STATS = 26
# Exit codes of timeout(1) and time(1): the solver could not be started.
LAUNCH_FAILURES = {'125', '126', '127'}
TABLE_FILES = ('table-eia.tex', 'table-slia.tex', 'table-reln-vars.tex', 'table-fullstrint.tex',
               'table-stages.tex', 'summary.csv', 'stages.csv', 'cactus-eia.pdf', 'cactus-slia.pdf')
EIA_SOLVERS = {'chro_-q', 'swine'}
SLIA_SOLVERS = {'chro_-q', 'cvc5', 'ostrich2', 'z3', 'z3-noodler'}
FAMILY_SOLVERS = {
    'Sierpinski': EIA_SOLVERS,
    'LoAT': EIA_SOLVERS,
    'PURRS': EIA_SOLVERS,
    'Hash2': SLIA_SOLVERS,
    'StringFuzz': SLIA_SOLVERS,
    'REln': SLIA_SOLVERS,
    'RElnC': SLIA_SOLVERS,
    'FullStrInt': SLIA_SOLVERS,
}


def check_stats(stats_dir):
    stats = glob.glob(os.path.join(stats_dir, '*'))
    if len(stats) != EXPECTED_STATS:
        yield 'expected %d files in %s, found %d' % (EXPECTED_STATS, stats_dir, len(stats))
    for path in stats:
        with open(path) as fh:
            if 'missing' in fh.read():
                yield '%s reports missing results' % path


def check_launches(results_dir):
    paths = glob.glob(os.path.join(results_dir, 'res-*.tsv'))
    if not paths:
        yield 'no res-*.tsv files in %s' % results_dir
    for path in paths:
        with open(path) as fh:
            for line in fh:
                cols = line.rstrip('\n').split('\t')
                if len(cols) < 9:
                    yield '%s: malformed line: %r' % (path, line)
                elif cols[8] in LAUNCH_FAILURES:
                    yield '%s: %s could not run %s (exit %s)' % (path, cols[0], cols[2], cols[8])


def check_table_files(tables_dir):
    for name in TABLE_FILES:
        path = os.path.join(tables_dir, name)
        if not os.path.isfile(path) or os.path.getsize(path) == 0:
            yield '%s is missing or empty' % path


def check_summary(tables_dir):
    path = os.path.join(tables_dir, 'summary.csv')
    if not os.path.isfile(path):
        return  # Already reported by check_table_files.
    solvers = collections.defaultdict(set)
    decided = collections.Counter()
    with open(path, newline='') as fh:
        for row in csv.DictReader(fh):
            solvers[row['family']].add(row['config'])
            decided[row['config']] += int(row['sat']) + int(row['unsat'])
    for family, expected in FAMILY_SOLVERS.items():
        for solver in sorted(expected - solvers[family]):
            yield 'summary.csv: no row for %s on %s' % (solver, family)
    for solver in sorted(EIA_SOLVERS | SLIA_SOLVERS):
        if decided[solver] == 0:
            yield 'summary.csv: %s gave no sat or unsat answer' % solver


def main(argv):
    if len(argv) != 3:
        sys.exit(__doc__)
    results_dir, stats_dir, tables_dir = argv
    failures = [*check_stats(stats_dir), *check_launches(results_dir),
                *check_table_files(tables_dir), *check_summary(tables_dir)]
    for failure in failures:
        print('FAILED:', failure)
    if failures:
        sys.exit(1)
    print('smoke test output is ok')


if __name__ == '__main__':
    main(sys.argv[1:])
