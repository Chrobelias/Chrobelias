#!/usr/bin/env python3
"""Syntactic statistics of the benchmark sets quoted in Sect. 6 of the paper.

    python3 scripts/set_stats.py stringfuzz DIR   # e.g. benchmarks/chrobelias/QF_SLIA/stringfuzz
    python3 scripts/set_stats.py fullstrint DIR   # e.g. benchmarks/chrobelias/QF_SLIA/FullStrInt
    python3 scripts/set_stats.py purrs DIR        # e.g. benchmarks/chrobelias/QF_EIA/PURRS

stringfuzz: the share of problems with regular constraints (str.in_re), length
  constraints (str.len), and str.to_int.
fullstrint: the share of problems with str.at or str.substr; every regular
  expression that occurs in a regular constraint, with its number of problems;
  the problems in which some str.to_int is compared with a non-constant integer
  term.  An atom (=, <, <=, >, >=) compares str.to_int with a term t if both
  occur in its integer skeleton: the leaves reached through +, -, *, div, mod,
  abs and the two branches of ite.  Numerals are constants; str.to_int terms
  are what is compared; every other leaf (str.len, str.indexof, a variable) is
  a non-constant term.
purrs: for every problem, why it lies outside ELIA (multiplication or division
  of variables, powers with a variable base or with several different bases),
  or "ELIA" if none of these occurs.
"""
import collections
import os
import re
import sys

TOK = re.compile(r'"(?:[^"]|"")*"|\|[^|]*\||;[^\n]*|\(|\)|[^\s()]+')
REL = {'=', 'distinct', '<', '<=', '>', '>='}
TO_INT = {'str.to_int', 'str.to.int'}
IN_RE = {'str.in_re', 'str.in.re'}


def parse(text):
    stack = [[]]
    for tok in TOK.findall(text):
        if tok.startswith(';'):
            continue
        if tok == '(':
            stack.append([])
        elif tok == ')':
            x = stack.pop()
            stack[-1].append(x)
        else:
            stack[-1].append(tok)
    return stack[0]


def show(t):
    return t if isinstance(t, str) else '(' + ' '.join(show(x) for x in t) + ')'


def is_int_const(t):
    if isinstance(t, str):
        return re.fullmatch(r'\d+', t) is not None
    return len(t) == 2 and t[0] == '-' and is_int_const(t[1])


def files(d):
    for root, _, fs in os.walk(d):
        for f in sorted(fs):
            if f.endswith('.smt2'):
                yield os.path.join(root, f)


def asserts(path):
    return [x[1] for x in parse(open(path, errors='ignore').read())
            if isinstance(x, list) and len(x) == 2 and x[0] == 'assert']


def nodes(t, parent=None):
    """All (node, parent) pairs of a term."""
    yield t, parent
    if isinstance(t, list):
        for x in t:
            yield from nodes(x, t)


def stringfuzz(d):
    ops = ['str.in_re', 'str.len', 'str.to_int']
    pat = {o: re.compile(r'\(\s*' + re.escape(o) + r'[\s)]') for o in ops}
    has, n = collections.Counter(), 0
    for f in files(d):
        body = open(f, errors='ignore').read().split('(check-sat')[0]
        n += 1
        for o in ops:
            has[o] += bool(pat[o].search(body))
    print('problems: %d' % n)
    for o in ops:
        print('%-12s %6d  %5.1f%%' % (o, has[o], 100 * has[o] / n))


ARITH = {'+', '-', '*', 'div', 'mod', 'abs'}


def skeleton(t, out):
    """Leaves of the integer skeleton of term t: ('const'|'to_int'|'other', text)."""
    if isinstance(t, str):
        out.append(('const' if re.fullmatch(r'\d+', t) else 'other', t))
    elif t and t[0] in TO_INT:
        out.append(('to_int', show(t)))
    elif t and t[0] in ARITH:
        for x in t[1:]:
            skeleton(x, out)
    elif t and t[0] == 'ite':
        skeleton(t[2], out)
        skeleton(t[3], out)
    elif t:
        out.append(('other', t[0]))


def fullstrint(d):
    n, at_substr, regexes, exceptions = 0, 0, collections.Counter(), []
    for f in files(d):
        n += 1
        text = open(f, errors='ignore').read()
        at_substr += bool(re.search(r'\(\s*str\.(at|substr)[\s)]', text))
        seen, compared = set(), set()
        for a in asserts(f):
            for t, _ in nodes(a):
                if not isinstance(t, list) or not t:
                    continue
                if t[0] in IN_RE and len(t) == 3:
                    seen.add(show(t[2]))
                if t[0] in REL and t[0] != 'distinct':
                    leaves = []
                    for x in t[1:]:
                        skeleton(x, leaves)
                    if any(k == 'to_int' for k, _ in leaves):
                        compared.update(v for k, v in leaves if k == 'other')
        regexes.update(seen)
        if compared:
            exceptions.append((f, sorted(compared)))
    print('problems: %d' % n)
    print('with str.at or str.substr: %d  (%.1f%%)' % (at_substr, 100 * at_substr / n))
    print('regular expressions in regular constraints (problems):')
    for r, k in regexes.most_common():
        print('  %6d  %s' % (k, r))
    print('problems where str.to_int is compared with a non-constant term: %d' % len(exceptions))
    for f, terms in exceptions:
        print('  %s  (%s)' % (f, ', '.join(terms)))


def purrs(d):
    for f in files(d):
        reasons, bases = set(), set()
        for a in asserts(f):
            for t, _ in nodes(a):
                if not isinstance(t, list) or not t:
                    continue
                if t[0] == '*' and sum(not is_int_const(x) for x in t[1:]) > 1:
                    reasons.add('multiplies variables')
                if t[0] in ('div', 'mod', '/') and not is_int_const(t[2]):
                    reasons.add('divides by a variable')
                if t[0] in ('exp', '**'):
                    if is_int_const(t[1]):
                        bases.add(show(t[1]))
                    else:
                        reasons.add('power with a variable base')
        if len(bases) > 1:
            reasons.add('powers with bases ' + ', '.join(sorted(bases)))
        print('%s\t%s' % (os.path.basename(f), '; '.join(sorted(reasons)) or 'ELIA'))


if __name__ == '__main__':
    if len(sys.argv) != 3 or sys.argv[1] not in ('stringfuzz', 'fullstrint', 'purrs'):
        sys.exit(__doc__)
    globals()[sys.argv[1]](sys.argv[2])
