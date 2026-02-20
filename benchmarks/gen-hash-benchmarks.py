#!/usr/bin/env python3
"""
SMT2 Benchmark Generator for QF_SLIA (String + Linear Integer Arithmetic).
Generates benchmarks with a string variable constrained by a regex and modular arithmetic.
"""

import argparse
import random
import subprocess
import sys
import tempfile
import os
from pathlib import Path


# ---------------------------------------------------------------------------
# Regex building blocks
# ---------------------------------------------------------------------------

DIGIT_RANGE = '(re.range "0" "9")'

# Only digit subranges — keeps str.to_int valid
DIGIT_SUBRANGES = [
    '(re.range "0" "4")',
    '(re.range "5" "9")',
    '(re.range "1" "9")',  # no leading zero range
    '(re.range "0" "9")',
]

# Digit-only literal prefixes
PREFIXES = [
    '"1"', '"12"', '"99"', '"100"', '"42"', '"7"', '"555"',
    '"1234"', '"9"', '"11"', '"200"', '"37"', '"8"', '"999"',
]


def rand_digit_literal() -> str:
    """Return a random all-digit literal for str.to_re."""
    length = random.randint(1, 4)
    # Avoid leading zeros in the overall number by not generating "000..." prefixes;
    # the prefix is prepended so a "0" prefix is fine as an interior segment.
    val = "".join(random.choices("0123456789", k=length))
    return f'(str.to_re "{val}")'


def rand_digit_class(complexity: int) -> str:
    """Return a digit-only character class."""
    if complexity >= 2 and random.random() < 0.4:
        # union of two digit subranges for variety
        a, b = random.sample(DIGIT_SUBRANGES, 2)
        return f"(re.union {a} {b})"
    return random.choice(DIGIT_SUBRANGES)


def rand_quantifier(inner: str, complexity: int) -> str:
    """Wrap inner regex in a quantifier."""
    if complexity >= 3 and random.random() < 0.4:
        n = random.randint(1, 4)
        m = n + random.randint(1, 5)
        return f"((_ re.loop {n} {m}) {inner})"
    ops = ["re.*", "re.+"]
    if complexity >= 2:
        ops += ["re.opt"]
    op = random.choices(ops, weights=[3, 3, 1][:len(ops)])[0]
    return f"({op} {inner})"


def build_regex(complexity: int) -> str:
    """
    Build a digit-only regex describing an infinite language.
    All strings it matches are valid inputs to str.to_int.
    complexity: 1=simple, 2=moderate, 3=complex.
    """
    parts = []

    # Fixed digit prefix — anchors the value range and avoids trivial empty matches
    parts.append(f"(str.to_re {random.choice(PREFIXES)})")

    # One or more quantified digit groups — this is where infinity comes from
    mid_count = random.randint(1, complexity + 1)
    for _ in range(mid_count):
        cls = rand_digit_class(complexity)
        quantified = rand_quantifier(cls, complexity)
        parts.append(quantified)

        # Optionally splice in a fixed digit segment for structural variety
        if complexity >= 2 and random.random() < 0.3:
            parts.append(rand_digit_literal())

    # At complexity 3, sometimes add a bounded suffix block
    if complexity == 3 and random.random() < 0.5:
        cls = rand_digit_class(complexity)
        n = random.randint(1, 3)
        m = n + random.randint(1, 3)
        parts.append(f"((_ re.loop {n} {m}) {cls})")

    return "(re.++ " + " ".join(parts) + ")"


# ---------------------------------------------------------------------------
# Modular arithmetic constraint builder
# ---------------------------------------------------------------------------

def build_mod_chain(chain_len: int, mod_range: tuple[int, int]) -> str:
    """
    Build a chained mod expression of `chain_len` levels.
    e.g. chain_len=2 -> (mod (mod (str.to_int x) M1) M2)
    """
    lo, hi = mod_range
    expr = "(str.to_int x)"
    moduli = [random.randint(lo, hi) for _ in range(chain_len)]
    for m in moduli:
        expr = f"(mod {expr} {m})"
    return expr


# ---------------------------------------------------------------------------
# Benchmark generator
# ---------------------------------------------------------------------------

def generate_benchmark(
    chain_len: int,
    mod_range: tuple[int, int],
    complexity: int,
    max_len: int | None,
) -> str:
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
            ["z3", f"-T:{timeout_ms}", fname],
            capture_output=True, text=True, timeout=timeout_ms / 1000
        )
        output = result.stdout.strip()
        if output.startswith("unsat"):
            return "unsat"
        elif output.startswith("sat"):
            return "sat"
        else:
            return "unknown"
    except FileNotFoundError:
        return "z3-not-found"
    except subprocess.TimeoutExpired:
        return "timeout"
    finally:
        os.unlink(fname)


def is_non_trivial(smt2: str, timeout_ms: int) -> tuple[bool, str]:
    """
    A benchmark is non-trivial if Z3 cannot decide it quickly.
    - 'unsat' quickly -> trivially unsatisfiable, reject.
    - 'sat'   quickly -> trivially satisfiable, reject.
    - 'unknown'/'timeout' -> genuinely hard, keep it.
    """
    verdict = run_z3(smt2, timeout_ms)
    if verdict in ("unsat", "sat"):
        return False, verdict
    return True, verdict


# ---------------------------------------------------------------------------
# CLI
# ---------------------------------------------------------------------------

def parse_args():
    p = argparse.ArgumentParser(
        description="Generate QF_SLIA SMT2 benchmarks with regex + modular arithmetic constraints."
    )
    p.add_argument(
        "-n", "--count", type=int, default=100,
        help="Number of benchmarks to generate (default: 100)"
    )
    p.add_argument(
        "--mod-min", type=int, default=2,
        help="Minimum modulus value (default: 2)"
    )
    p.add_argument(
        "--mod-max", type=int, default=1000,
        help="Maximum modulus value (default: 1000)"
    )
    p.add_argument(
        "--chain-min", type=int, default=1,
        help="Minimum mod chain length (default: 1)"
    )
    p.add_argument(
        "--chain-max", type=int, default=3,
        help="Maximum mod chain length (default: 3)"
    )
    p.add_argument(
        "--complexity", type=int, default=2, choices=[1, 2, 3],
        help="Regex complexity: 1=simple, 2=moderate, 3=complex (default: 2)"
    )
    p.add_argument(
        "--max-len", type=int, default=100,
        help="Max string length constraint; 0 = no constraint (default: 100)"
    )
    p.add_argument(
        "--output-dir", type=str, default="benchmarks",
        help="Directory to write .smt2 files (default: benchmarks/)"
    )
    p.add_argument(
        "--no-verify", action="store_true",
        help="Disable Z3 non-triviality verification (verification is ON by default)"
    )
    p.add_argument(
        "--verify-timeout", type=int, default=300,
        help="Z3 timeout in milliseconds per candidate (default: 300). "
             "Benchmarks decided within this timeout (sat or unsat) are considered trivial and retried."
    )
    p.add_argument(
        "--max-retries", type=int, default=100,
        help="Max regeneration attempts per benchmark slot before giving up and keeping the last candidate (default: 100)"
    )
    p.add_argument(
        "--seed", type=int, default=None,
        help="Random seed for reproducibility"
    )
    p.add_argument(
        "--print", action="store_true", dest="print_stdout",
        help="Also print benchmarks to stdout"
    )
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
    print(f"  verify (Z3):       {'yes — timeout=' + str(args.verify_timeout) + 's, max_retries=' + str(args.max_retries) if verify else 'no'}")
    print()

    for idx in range(args.count):
        # Gradually increase chain length across the suite
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
                    status_tag = verdict  # 'unknown' or 'timeout'
                    break
                else:
                    print(f"  [retry {attempt}/{args.max_retries}] bench {idx+1}: trivial ({verdict}), regenerating...")
                    smt2 = candidate     # keep last candidate as fallback
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
