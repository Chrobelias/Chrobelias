#!/usr/bin/env python3
"""Run Chrobelias on SMT-LIB files and check every model it prints.

Usage: check_models_z3.py CHRO FILE...
Environment: Z3 (default "_build/default/bin/z3"), TIMEOUT in seconds for each run (default 60).

For each FILE, prints  FILE<TAB>ANSWER<TAB>RESULT  where ANSWER is the first
line of the output of "CHRO -q" (e.g. "sat (nfa)") and RESULT is
  ok          the model satisfies the formula
  WRONG       the model violates the formula
  huge        Chrobelias answered sat with "no short model" (Sect. 4)
  not-sat     Chrobelias did not answer sat
  no-model    sat, but no model could be parsed
  unchecked   the model could not be checked (Z3 gave no answer in time)
QF_SLIA files are checked by Z3 with the model added as equalities.
QF_EIA files with one integer variable, +, -, *, mod, exp base 2, =, >=
(the Sierpinski set) are evaluated directly, with modular exponentiation for
powers whose exponents are too large to compute.
Every solver run gets its own process group, which is killed on timeout, so
that the processes of the portfolio do not survive the run.
"""
import os, re, signal, subprocess, sys, tempfile

Z3 = os.environ.get("Z3", "_build/default/bin/z3")
LIMIT = int(os.environ.get('TIMEOUT', '60'))
MAX_BITS = 10_000_000          # largest exact power computed: 2^MAX_BITS


def run(cmd, text):
    """Run cmd on a temporary file holding text; return stdout ('' on timeout)."""
    with tempfile.NamedTemporaryFile('w', suffix='.smt2', delete=False) as t:
        t.write(text)
    p = subprocess.Popen(cmd + [t.name], stdout=subprocess.PIPE, stderr=subprocess.DEVNULL,
                         text=True, errors='surrogateescape', start_new_session=True)
    try:
        out, _ = p.communicate(timeout=LIMIT)
    except subprocess.TimeoutExpired:
        out = ''
    finally:
        try:
            os.killpg(p.pid, signal.SIGKILL)
        except ProcessLookupError:
            pass
        p.wait()
        os.unlink(t.name)
    return out


# ---------------------------------------------------------------- s-expressions
TOK = re.compile(r'"(?:[^"]|"")*"|\(|\)|[^\s()]+')


def parse(text):
    stack = [[]]
    for tok in TOK.findall(text):
        if tok == '(':
            stack.append([])
        elif tok == ')':
            x = stack.pop()
            stack[-1].append(x)
        else:
            stack[-1].append(tok)
    return stack[0]


# ------------------------------------------------- evaluation of the EIA formulas
class TooBig(Exception):
    pass


def order2(m):
    """Multiplicative order of 2 modulo an odd m > 1."""
    k, v = 1, 2 % m
    while v != 1:
        v = v * 2 % m
        k += 1
    return k


def ev(t, env, m=None):
    """Value of term t, exactly (m is None) or modulo m."""
    if isinstance(t, str):
        v = env[t] if t in env else int(t)
        return v if m is None else v % m
    op, args = t[0], t[1:]
    if op == '+':
        s = sum(ev(a, env, m) for a in args)
        return s if m is None else s % m
    if op == '*':
        r = 1
        for a in args:
            r = r * ev(a, env, m)
            if m is not None:
                r %= m
        return r
    if op == '-':
        if len(args) == 1:
            v = -ev(args[0], env, m)
        else:
            v = ev(args[0], env, m) - sum(ev(a, env, m) for a in args[1:])
        return v if m is None else v % m
    if op == 'mod':
        k = ev(args[1], env)
        v = ev(args[0], env, k) % k
        return v if m is None else v % m
    if op in ('exp', '**'):
        if ev(args[0], env) != 2:
            raise ValueError('base other than 2')
        return pow2(args[1], env, m)
    raise ValueError('unsupported operator ' + op)


def pow2(e, env, m):
    """2^e (0 for e < 0, the semantics of the paper), exactly or modulo m."""
    try:
        E = ev(e, env)
    except TooBig:
        E = None
    if E is not None:
        if E < 0:
            return 0
        if m is not None:
            return pow(2, E, m)
        if E > MAX_BITS:
            raise TooBig()
        return 1 << E
    # e itself is a huge power 2^e2 > 0, so E is huge and positive
    if m is None:
        raise TooBig()
    if not (isinstance(e, list) and e[0] in ('exp', '**')):
        raise ValueError('huge exponent that is not a power')
    s = (m & -m).bit_length() - 1        # m = 2^s * odd
    odd = m >> s
    r_odd = 0 if odd == 1 else pow(2, ev(e, env, order2(odd)), odd)
    # 2^E mod 2^s is 0 (E >= s); combine with r_odd by CRT
    for v in range(r_odd, m, odd):
        if v % (1 << s) == 0:
            return v
    raise AssertionError('CRT')


def holds(f, env):
    op, args = f[0], f[1:]
    if op == 'and':
        return all(holds(a, env) for a in args)
    if op == 'or':
        return any(holds(a, env) for a in args)
    if op == 'not':
        return not holds(args[0], env)
    a, b = ev(args[0], env), ev(args[1], env)
    return {'=': a == b, '>=': a >= b, '<=': a <= b, '>': a > b, '<': a < b}[op]


def check_eia(body, model):
    env = {}
    for v, _, val in model:
        x = parse(val)[0]
        env[v] = -int(x[1]) if isinstance(x, list) else int(x)
    asserts = [x[1] for x in parse(body) if isinstance(x, list) and x and x[0] == 'assert']
    return 'ok' if all(holds(a, env) for a in asserts) else 'WRONG'


# ------------------------------------------------------------------- the check
def smt_string(lit):
    return '"' + ''.join(c if 32 <= ord(c) < 127 else '\\u{%x}' % ord(c)
                         for c in lit[1:-1]) + '"'


def check(chro, path):
    body = re.sub(r'\(\s*(check-sat|get-model|exit)\s*\)', '', open(path).read())
    out = run([chro, '-q'], body + '(check-sat)\n(get-model)\n')
    answer = out.strip().split('\n')[0] if out.strip() else 'timeout'
    if not answer.startswith('sat'):
        return answer, 'not-sat'
    if 'no short model' in out:
        return answer, 'huge'
    model = re.findall(r'\(define-fun\s+(\S+)\s+\(\)\s+(Int|String|Bool)\s+'
                       r'("(?:[^"]|"")*"|\(-\s*\d+\)|-?\d+|true|false)\s*\)', out)
    if not model:
        return answer, 'no-model'
    if 'QF_SLIA' not in body:
        try:
            return answer, check_eia(body, model)
        except (TooBig, ValueError, KeyError):
            return answer, 'unchecked'
    asserts = ''.join('(assert (= %s %s))\n' % (v, smt_string(x) if ty == 'String' else x)
                      for v, ty, x in model)
    z3 = run([Z3], body + asserts + '(check-sat)\n').strip().split('\n')[0]
    return answer, {'sat': 'ok', 'unsat': 'WRONG'}.get(z3, 'unchecked')


if __name__ == '__main__':
    chro = sys.argv[1]
    for path in sys.argv[2:]:
        answer, result = check(chro, path)
        print('%s\t%s\t%s' % (path, answer, result), flush=True)
