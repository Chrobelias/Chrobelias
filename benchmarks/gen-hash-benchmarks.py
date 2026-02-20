#!/usr/bin/env python3
"""
SMT2 Benchmark Generator for QF_SLIA (String + Linear Integer Arithmetic).
Generates benchmarks with a string variable constrained by a regex and modular arithmetic.
"""

import argparse
import random
import subprocess
import tempfile
import os
from pathlib import Path


def rand_digit_range() -> str:
    """
    Random digit range (re.range "a" "b") with a < b.
    Deliberately avoids always picking 0-9: generates interesting subranges.
    """
    lo = random.randint(0, 7)
    hi = random.randint(lo + 1, 9)
    return f'(re.range "{lo}" "{hi}")'


def rand_digit_class(complexity: int) -> str:
    """
    Digit character class: a single range, or a union of 2-3 independently
    chosen ranges. Higher complexity allows larger unions.
    """
    max_ranges = {1: 1, 2: 2, 3: 3}[complexity]
    n = random.choices(range(1, max_ranges + 1), weights=range(max_ranges, 0, -1))[0]
    ranges = [rand_digit_range() for _ in range(n)]
    if len(ranges) == 1:
        return ranges[0]
    return f"(re.union {' '.join(ranges)})"


def rand_digit_literal() -> str:
    """
    Digit-only literal strings with varied internal structure:
    plain integers, repeated digits, alternating patterns, random digit strings.
    """
    kind = random.random()
    if kind < 0.25:
        val = str(random.randint(1, 999999))
    elif kind < 0.45:
        # repeated single digit: 333, 7777, 00
        d = random.randint(0, 9)
        val = str(d) * random.randint(2, 5)
    elif kind < 0.65:
        # alternating two distinct digits: 1212, 5959, 0303
        a, b = random.sample("0123456789", 2)
        val = (a + b) * random.randint(1, 3)
    elif kind < 0.8:
        # ascending run: 123, 456789
        start = random.randint(0, 6)
        length = random.randint(2, 4)
        val = "".join(str((start + i) % 10) for i in range(length))
    else:
        # fully random digit string
        val = "".join(random.choices("0123456789", k=random.randint(2, 6)))
    return f'(str.to_re "{val}")'


def rand_quantifier(inner: str, complexity: int) -> str:
    """Wrap inner in a quantifier, with complexity gating loop and opt."""
    if complexity >= 3 and random.random() < 0.4:
        n = random.randint(1, 5)
        m = n + random.randint(1, 6)
        return f"((_ re.loop {n} {m}) {inner})"
    if complexity >= 2 and random.random() < 0.12:
        return f"(re.opt {inner})"
    op = "re.*" if random.random() < 0.45 else "re.+"
    return f"({op} {inner})"


def rand_infinite_atom(complexity: int) -> str:
    """
    One regex atom describing an infinite digit language.
    Three structural shapes:
      - quantified class  e.g.  (re.+ (re.range "2" "7"))
      - quantified union of class and literal
      - quantified concatenation of literal + class  (nested structure)
    """
    r = random.random()
    if r < 0.45:
        return rand_quantifier(rand_digit_class(complexity), complexity)
    elif r < 0.72:
        cls = rand_digit_class(complexity)
        lit = rand_digit_literal()
        union = f"(re.union {cls} {lit})"
        return rand_quantifier(union, complexity)
    else:
        # (re.* (re.++ "42" (re.range "0" "5")))  — infinite via outer loop
        cls = rand_digit_class(complexity)
        lit = rand_digit_literal()
        concat = f"(re.++ {lit} {rand_quantifier(cls, complexity)})"
        return rand_quantifier(concat, complexity)


def rand_prefix() -> str:
    """
    Random digit-only prefix with no fixed list.
    Structurally varied: random int, repeated, alternating, patterned.
    """
    kind = random.random()
    if kind < 0.35:
        val = str(random.randint(1, 9999999))
    elif kind < 0.55:
        d = random.randint(1, 9)
        val = str(d) * random.randint(1, 4)
    elif kind < 0.72:
        a, b = random.sample("123456789", 2)
        val = (a + b) * random.randint(1, 2)
    elif kind < 0.85:
        start = random.randint(1, 5)
        val = "".join(str(start + i) for i in range(random.randint(2, 4)))
    else:
        val = "".join(random.choices("123456789", k=1)) + \
              "".join(random.choices("0123456789", k=random.randint(1, 5)))
    return f'(str.to_re "{val}")'


def build_regex(complexity: int) -> str:
    """
    Build a digit-only regex describing an infinite language.

    Structure:
      [optional prefix]
      <one or more infinite atoms>          ← guarantees infinite language
      [optional interleaved digit literals]
      [optional bounded suffix]

    complexity: 1=simple, 2=moderate, 3=complex
    """
    parts = []

    # Optional prefix — 50% chance, fully random (not from a fixed list)
    if random.random() < 0.5:
        parts.append(rand_prefix())

    # Core: one or more infinite atoms
    n_atoms = random.randint(1, complexity + 1)
    for i in range(n_atoms):
        parts.append(rand_infinite_atom(complexity))
        # Optionally interleave a digit literal between atoms
        if complexity >= 2 and i < n_atoms - 1 and random.random() < 0.35:
            parts.append(rand_digit_literal())

    # Optional suffix
    if complexity >= 2 and random.random() < 0.4:
        r = random.random()
        if r < 0.4:
            parts.append(rand_digit_literal())
        elif r < 0.7:
            cls = rand_digit_class(complexity)
            n = random.randint(1, 4)
            m = n + random.randint(0, 4)
            parts.append(f"((_ re.loop {n} {m}) {cls})")
        else:
            parts.append(f"(re.opt {rand_digit_literal()})")

    if len(parts) == 1:
        return parts[0]
    return "(re.++ " + " ".join(parts) + ")"


# ---------------------------------------------------------------------------
# Modular arithmetic constraint
# ---------------------------------------------------------------------------

def build_mod_chain(chain_len: int, mod_range: tuple) -> str:
    lo, hi = mod_range
    expr = "(str.to_int x)"
    for m in [random.randint(lo, hi) for _ in range(chain_len)]:
        expr = f"(mod {expr} {m})"
    return expr


# ---------------------------------------------------------------------------
# Benchmark assembly
# ---------------------------------------------------------------------------

def generate_benchmark(chain_len: int, mod_range: tuple, complexity: int, max_len) -> str:
    regex = build_regex(complexity)
    mod_expr = build_mod_chain(chain_len, mod_range)
    lines = [
        "(set-logic QF_SLIA)",
        "(set-option :produce-models true)",
        "(declare-fun x () String)",
        f"(assert (str.in_re x {regex}))",
        f"(assert (= {mod_expr} 0))",
    ]
    if max_len is not None:
        lines.append(f"(assert (< (str.len x) {max_len}))")
    lines += ["(check-sat)", "(get-model)"]
    return "\n".join(lines)


# ---------------------------------------------------------------------------
# Z3 verification
# ---------------------------------------------------------------------------

def run_z3(smt2: str, timeout_ms: int) -> str:
    """Run Z3 and return 'sat', 'unsat', 'unknown', or 'timeout'."""
    with tempfile.NamedTemporaryFile(suffix=".smt2", mode="w", delete=False) as f:
        f.write(smt2)
        fname = f.name
    try:
        result = subprocess.run(
            ["z3", f"-T:{max(1, timeout_ms // 1000)}", fname],
            capture_output=True, text=True, timeout=timeout_ms / 1000 + 2
        )
        out = result.stdout.strip()
        if out.startswith("unsat"):
            return "unsat"
        elif out.startswith("sat"):
            return "sat"
        else:
            return "unknown"
    except FileNotFoundError:
        return "z3-not-found"
    except subprocess.TimeoutExpired:
        return "timeout"
    finally:
        os.unlink(fname)


def is_non_trivial(smt2: str, timeout_ms: int) -> tuple:
    """
    Non-trivial = Z3 cannot decide within timeout.
    Both quick 'sat' and quick 'unsat' count as trivial.
    """
    verdict = run_z3(smt2, timeout_ms)
    trivial = verdict in ("sat", "unsat")
    return (not trivial), verdict


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def parse_args():
    p = argparse.ArgumentParser(
        description="Generate QF_SLIA SMT2 benchmarks with regex + modular arithmetic constraints."
    )
    p.add_argument("-n", "--count", type=int, default=100,
                   help="Number of benchmarks to generate (default: 100)")
    p.add_argument("--mod-min", type=int, default=2,
                   help="Minimum modulus value (default: 2)")
    p.add_argument("--mod-max", type=int, default=300,
                   help="Maximum modulus value (default: 300)")
    p.add_argument("--chain-min", type=int, default=1,
                   help="Minimum mod chain length (default: 1)")
    p.add_argument("--chain-max", type=int, default=3,
                   help="Maximum mod chain length (default: 3)")
    p.add_argument("--complexity", type=int, default=2, choices=[1, 2, 3],
                   help="Regex complexity: 1=simple, 2=moderate, 3=complex (default: 2)")
    p.add_argument("--max-len", type=int, default=100,
                   help="Max string length constraint; 0 = no constraint (default: 100)")
    p.add_argument("--output-dir", type=str, default="benchmarks",
                   help="Directory to write .smt2 files (default: benchmarks/)")
    p.add_argument("--no-verify", action="store_true",
                   help="Disable Z3 non-triviality verification (ON by default)")
    p.add_argument("--verify-timeout", type=int, default=300,
                   help="Z3 timeout in milliseconds per candidate (default: 300). "
                        "Benchmarks decided within this timeout are considered trivial.")
    p.add_argument("--max-retries", type=int, default=100,
                   help="Max regeneration attempts per slot before keeping last candidate (default: 100)")
    p.add_argument("--seed", type=int, default=None,
                   help="Random seed for reproducibility")
    p.add_argument("--print", action="store_true", dest="print_stdout",
                   help="Also print benchmarks to stdout")
    return p.parse_args()


def main():
    args = parse_args()
    if args.seed is not None:
        random.seed(args.seed)

    mod_range = (args.mod_min, args.mod_max)
    max_len = args.max_len if args.max_len > 0 else None
    verify = not args.no_verify
    out_dir = Path(args.output_dir)
    out_dir.mkdir(parents=True, exist_ok=True)

    print(f"Generating {args.count} benchmarks → {out_dir}/")
    print(f"  mod range:         [{mod_range[0]}, {mod_range[1]}]")
    print(f"  chain length:      [{args.chain_min}, {args.chain_max}]")
    print(f"  regex complexity:  {args.complexity}")
    print(f"  max string length: {max_len if max_len else 'unconstrained'}")
    if verify:
        print(f"  verify (Z3):       yes — timeout={args.verify_timeout}ms, max_retries={args.max_retries}")
    else:
        print(f"  verify (Z3):       no")
    print()

    for idx in range(args.count):
        progress = idx / max(args.count - 1, 1)
        chain_len = args.chain_min + round(progress * (args.chain_max - args.chain_min))
        chain_len = max(args.chain_min, min(args.chain_max, chain_len))

        smt2 = None
        status_tag = "unverified"

        if not verify:
            smt2 = generate_benchmark(chain_len, mod_range, args.complexity, max_len)
        else:
            for attempt in range(1, args.max_retries + 1):
                candidate = generate_benchmark(chain_len, mod_range, args.complexity, max_len)
                ok, verdict = is_non_trivial(candidate, args.verify_timeout)
                if ok:
                    smt2 = candidate
                    status_tag = verdict
                    break
                else:
                    print(f"  [retry {attempt}/{args.max_retries}] bench {idx+1}: trivial ({verdict}), regenerating...")
                    smt2 = candidate
                    status_tag = f"trivial({verdict})-forced"

        fname = out_dir / f"bench_{idx:04d}_chain{chain_len}.smt2"
        fname.write_text(smt2)

        if args.print_stdout:
            print(f"--- {fname} [{status_tag}] ---")
            print(smt2)
            print()
        else:
            print(f"  [{idx+1:4d}/{args.count}] {fname.name}  ({status_tag})")

    print(f"\nDone. {args.count} benchmarks written to {out_dir}/")


if __name__ == "__main__":
    main()

