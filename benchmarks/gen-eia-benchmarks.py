#!/usr/bin/env python3
"""
SMT-LIB Benchmark Generator for EIA Constraints

Generates SMT-LIB benchmarks with one variable in exponents and double exponents.
The constraints are divisibilities and inequalities.
"""

import argparse
import os
import random
from itertools import product
from typing import List, Optional
import enum

class MODE(enum.Enum):
    STANDARD = "standard"
    BIG = "big"

LOGIC = "ALL"
COEFF_MIN = -10
COEFF_MAX = 10
CONST_MIN = 0
CONST_MAX = 100

DEFAULT_TIMEOUT_MS = 5000

DEFAULT_MODE = MODE.STANDARD

SUBPROCESS_TIMEOUT_BUFFER_SEC = 5.0

def mode_type(s: str) -> MODE:
    try:
        return MODE[s.upper()]
    except KeyError:
        raise argparse.ArgumentTypeError(f"Invalid mode: {s}. Choose from {[m.name.lower() for m in MODE]}")


def generate_variable_declarations(vars: List[str]) -> List[str]:
    """Generate variable declarations."""
    return [f"(declare-const {var} Int)" for var in vars]

def format_coefficient_term(coeff: int, term: str) -> Optional[str]:
    """Format a term with its coefficient properly."""
    if coeff == 0:
        return None
    if coeff == 1:
        return term
    if coeff == -1:
        return f"(- {term})"
    if coeff > 0:
        return f"(* {coeff} {term})"
    return f"(* (- {abs(coeff)}) {term})"

def generate_eia_mod_constraint(var: str, min_mod: int, max_mod: int, with_double: bool) -> str:
    """Generate a divisibility constraint with (exp 2 _) and if <with_double>, then with exp (2 exp (_)).
    Modulus is at most <max_mod>."""

    lin_coeffs = [(random.randint(COEFF_MIN, COEFF_MAX)) for _ in range(3)]
    exp_coeffs = [(random.randint(0, COEFF_MAX) if random.randint(1, 6) <= 2 else 0) for _ in range(2)]
    dexp_coeffs = [(random.randint(0, COEFF_MAX) if random.randint(1, 6) <= 2 else 0) for _ in range(2)]

    if not any(c != 0 for c in lin_coeffs) or not any(c != 0 for c in exp_coeffs) or not any(c != 0 for c in dexp_coeffs):
        return generate_eia_mod_constraint(var, min_mod, max_mod, with_double)

    modulus = random.randint(min_mod, max_mod)
    rem = random.randint(0, modulus)

    dexp_term = f"(exp 2 (exp 2 (+ {dexp_coeffs[0]} (* {dexp_coeffs[1]} {var}))))"
    exp_term = f"(exp 2 (+ {exp_coeffs[0]} (* {exp_coeffs[1]} {var})))"
    trivial_terms = [var, exp_term, dexp_term] if with_double else [var, exp_term, var]
    
    terms: List[str] = []
    for coeff, var in zip(lin_coeffs, trivial_terms):
        t = format_coefficient_term(coeff, f"{var}")
        if t:
            terms.append(t)

    exp_term = terms[0] if len(terms) == 1 else "(+ " + " ".join(terms) + ")"
    return f"(assert (= (mod {exp_term} {modulus}) {rem}))"

def generate_benchmark(
    min_mod: int,
    max_mod: int,
    with_dexp: bool,
    mode: MODE = DEFAULT_MODE,
    get_model: bool = False
) -> str:
    """
    Generate a complete EIA benchmark.
    """
    lines: List[str] = []
    var = "x"
    lines.append(f"(set-logic {LOGIC})")
    lines.append("")
    lines.extend(generate_variable_declarations({var}))
    lines.append("")

    lower_bound = 1000 if mode == MODE.BIG else 0 
    lines.append(f"(assert (>= {var} {lower_bound}))")

    lines.append(generate_eia_mod_constraint(var, min_mod, max_mod, with_dexp))

    lines.append("(check-sat)")
    if get_model: lines.append("(get-model)")
    return "\n".join(lines)

def main():
    """Main function to generate all benchmark combinations."""
    parser = argparse.ArgumentParser(
        description="Generate SMT-LIB benchmarks for Sierpiński-style EIA constraints."
    )
    parser.add_argument(
        "--mode",
        type=mode_type,
        default=MODE.STANDARD,
        help="Modes: [standard; big] (default: standard).",
    )

    parser.add_argument(
        "--get-model",
        action="store_true",
        default=False,
        help="Produce model (default: disabled).",
    )

    args = parser.parse_args()

    max_mod = 100
    mod_step = 10
    benchmarks_per_config = 5

    output_dir = "sier_benchmarks"
    os.makedirs(output_dir, exist_ok=True)

    total_benchmarks = 0

    print("Starting Sierpiński benchmarks generation...")
    print(f"Mode: {args.mode.name.lower()}")
    print(f"Maximal mod: {max_mod}")
    print(f"With step: {mod_step}")
    print(f"Benchmarks per configuration: {benchmarks_per_config} and {benchmarks_per_config} with double exp")
    print(f"Coefficient range: [{COEFF_MIN}, {COEFF_MAX}]")
    print(f"Constant range: [{CONST_MIN}, {CONST_MAX}]")
    print(f"With (get-model): {args.get_model}")

    print("=" * 80)

    for min_mod1, with_dexp in product(range(5, max_mod, mod_step), [False, True]):
        max_mod1 = min_mod1 + mod_step
        print(f"\n--- Mod: in [{min_mod1},{max_mod1}], With double exp: {with_dexp} ---")
        dstr = "double" if with_dexp else "single"

        for benchmark_idx in range(benchmarks_per_config):
            total_benchmarks += 1

            filename = f"sier_{max_mod1}_{dstr}_n{benchmark_idx + 1:02d}.smt2"
            filepath = os.path.join(output_dir, filename)

            print(f"[{total_benchmarks:4d}] {filename}...", end="\n", flush=True)
            benchmark = generate_benchmark(
                min_mod1,
                max_mod1,
                with_dexp,
                mode=args.mode,
                get_model=args.get_model
            )
            with open(filepath, "w") as f:
                f.write(benchmark)

    print("\n" + "=" * 80)
    print("Benchmark Generation Complete!")
    print("=" * 80)
    print(f"Total benchmarks generated:   {total_benchmarks}")
    print(f"\nAll benchmarks saved to:      '{output_dir}/'")
    print("\nParameters:")
    print(f"  - Logic: {LOGIC}")
    print(f"  - Benchmarks per config: {benchmarks_per_config}")
    print(f"  - Maximal mod: {max_mod}")
    print(f"  - With step: {mod_step}")
    print(f"  - Coefficient range: [{COEFF_MIN}, {COEFF_MAX}]")
    print(f"  - Constant range: [{CONST_MIN}, {CONST_MAX}]")
    print(f"  - Mode: {args.mode.name.lower()}")
    print(f"  - With (get-model): {args.get_model}")

if __name__ == "__main__":
    main()

