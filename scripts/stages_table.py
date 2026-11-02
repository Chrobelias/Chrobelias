#!/usr/bin/env python3
"""Table 2 of the paper ("Answers by stage") from the res-*.tsv files.

    python3 scripts/stages_table.py [--label chro_-q] [--subsets] RESULTS_DIR [RESULTS_DIR ...]

For every benchmark set, prints the number of problems Chrobelias solved,
how many of these answers come before and after the arithmetization, and how
many come from the NFA Solver (stage "nfa").  The stage of an answer is the
text in parentheses after it, column 5 of res-*.tsv.  Answers of the stages
presimpl str, lengths, under str, and bool come before the arithmetization;
all others (presimpl int, simpl, under int, over, nia, nfa) after it.  The
QF_EIA sets are not arithmetized, so "before" and "after" are "--" for them.

REln counts the problems with 1-3 variables (810), RElnC those with 2-3
variables (450), as in the paper.  FullStrInt (not in the tables) is the last
row when the results contain it.  With --subsets, one more line per subset
gives the same numbers and the counts of every stage.
"""
import collections
import glob
import os
import re
import sys

BEFORE = {'presimpl str', 'lengths', 'under str', 'bool'}
ORDER = ['Sierpinski', 'LoAT', 'PURRS', 'Hash2', 'StringFuzz', 'REln', 'RElnC', 'FullStrInt']
EIA = {'Sierpinski', 'LoAT', 'PURRS'}


def classify(path):
    """(set, subset) of a benchmark path, or None for problems outside the tables."""
    p = path.replace('\\', '/')
    m = re.search(r'QF_EIA/SIERPINSKI/([^/]+)/', p)
    if m:
        return 'Sierpinski', m.group(1)
    m = re.search(r'QF_EIA/LoAT/([^/]+)/', p)
    if m:
        return 'LoAT', m.group(1)
    if '/QF_EIA/PURRS/' in p:
        return 'PURRS', 'PURRS'
    m = re.search(r'QF_SLIA/Hash2/([^/]+)/', p)
    if m:
        return 'Hash2', m.group(1)
    m = re.search(r'QF_SLIA/stringfuzz/(generated|transformed)/([^/]+)/', p)
    if m:
        return 'StringFuzz', m.group(2)
    m = re.search(r'QF_SLIA/FullStrInt/py-conbyte_([^/]+)/', p)
    if m:
        return 'FullStrInt', m.group(1)
    m = re.search(r'QF_SLIA/StrRElnc/(REln|RElnc)(?:-\d+)?/([^/]+)/[^/]*_v(\d+)_', p)
    if m:
        name, sub, nvars = {'REln': 'REln', 'RElnc': 'RElnC'}[m.group(1)], m.group(2), int(m.group(3))
        if nvars > 3 or (name == 'RElnC' and nvars < 2):
            return None
        return name, '%d var %s' % (nvars, sub)
    return None


def problem_key(path):
    """The benchmark path from QF_ on, with REln-k/RElnc-k mapped to REln/RElnc,
    so that the two directory layouts of StrRElnc name a problem the same way."""
    p = path.replace('\\', '/')
    p = p[p.find('QF_'):] if 'QF_' in p else p
    return re.sub(r'(StrRElnc/(?:REln|RElnc))-\d+/', r'\1/', p)


def main(argv):
    label, subsets, dirs = 'chro_-q', False, []
    it = iter(argv)
    for a in it:
        if a == '--label':
            label = next(it)
        elif a == '--subsets':
            subsets = True
        else:
            dirs.append(a)
    if not dirs:
        sys.exit(__doc__)
    # The same problem can appear under two directory layouts (REln/long and
    # REln-1/long); count every problem once, the last run wins.
    answers = {}
    for d in dirs:
        for f in sorted(glob.glob(os.path.join(d, 'res-%s-*.tsv' % label))):
            for line in open(f):
                c = line.rstrip('\n').split('\t')
                if len(c) < 5 or c[0] != label:
                    continue
                key = classify(c[2])
                if key:
                    answers[key + (problem_key(c[2]),)] = (c[3], c[4])
    rows = collections.OrderedDict((s, collections.Counter()) for s in ORDER)
    subs = collections.defaultdict(collections.Counter)
    for (s, sub, _), (verdict, stage) in answers.items():
        for cnt in (rows[s], subs[s, sub]):
            cnt['total'] += 1
            if verdict in ('sat', 'unsat'):
                cnt['solved'] += 1
                cnt['before' if stage in BEFORE else 'after'] += 1
                cnt['nfa'] += stage == 'nfa'
                cnt['stage:%s %s' % (verdict, stage or '?')] += 1
    print('%-24s %8s %7s %7s %7s %7s' % ('benchmark', 'problems', 'solved', 'before', 'after', 'NFA'))
    for s, cnt in rows.items():
        if not cnt['total']:
            continue
        ba = ('--', '--') if s in EIA else (cnt['before'], cnt['after'])
        print('%-24s %8d %7d %7s %7s %7d' % (s, cnt['total'], cnt['solved'], ba[0], ba[1], cnt['nfa']))
        if subsets:
            for (s2, sub), c2 in sorted(subs.items()):
                if s2 != s:
                    continue
                ba2 = ('--', '--') if s in EIA else (c2['before'], c2['after'])
                st = ', '.join('%d %s' % (n, k[6:]) for k, n in sorted(c2.items()) if k.startswith('stage:'))
                print('  %-22s %8d %7d %7s %7s %7d   %s' % (sub, c2['total'], c2['solved'], ba2[0], ba2[1], c2['nfa'], st))


if __name__ == '__main__':
    main(sys.argv[1:])
