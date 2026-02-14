#!/usr/bin/env python3
"""
SMT-LIB Benchmark Generator for String Constraints

Generates SMT-LIB benchmarks with weight-based parametrization.
Constraint weights: mixed=2, len=1, to_int=1.
Optionally adds regex membership constraints; generated regexes always contain re.+ or re.*.
"""

import argparse
import os
import random
import subprocess
import tempfile
import time
from itertools import product
from typing import List, Tuple, Optional


LOGIC = "QF_SLIA"
DEFAULT_SOLVER = "z3"

COEFF_MIN = -10
COEFF_MAX = 10
CONST_MIN = 0
CONST_MAX = 100

DEFAULT_TIMEOUT_MS = 5000
DEFAULT_QUICK_TIMEOUT_MS = 100
DEFAULT_REGEX_VERIFY_TIMEOUT_MS = 5000

REGEX_DEFAULT_MAX_DEPTH = 4
SUBPROCESS_TIMEOUT_BUFFER_SEC = 5.0


def get_variable_names(num_vars: int) -> List[str]:
    """Get list of variable names."""
    return [(chr(ord("x") + i) if i < 3 else chr(ord("a") + i - 3)) for i in range(num_vars)]


def generate_variable_declarations(num_vars: int) -> List[str]:
    """Generate variable declarations."""
    var_names = get_variable_names(num_vars)
    return [f"(declare-const {var} String)" for var in var_names]


def generate_random_digit_regex(max_depth: int = REGEX_DEFAULT_MAX_DEPTH) -> str:
    """
    Generate a random SMT-LIB regex involving digits 0-9, with maximum depth `max_depth`,
    guaranteed to contain at least one quantifier (re.+ or re.*).
    """

    def build_regex(depth: int) -> tuple[str, bool]:
        """Returns (regex_string, has_quantifier)."""
        if depth == 0:
            choice = random.choice(["digit", "long", "long", "long", "long", "range"])
            if choice == "digit":
                d = str(random.randint(0, 9))
                return f'(str.to_re "{d}")', False
            if choice == "long":
                d = str(random.randint(100, 999)) if random.randint(0, 1) == 0 else str(random.randint(10, 99))
                return f'(str.to_re "{d}")', False

            mini = random.randint(0, 7)
            maxi = random.randint(mini + 2, 9)
            return f'(re.range "{mini}" "{maxi}")', False

        options: List[tuple[str, float]] = [("leaf", 2.0), ("plus", 1.0), ("star", 1.0)]
        if depth >= 2:
            options.append(("concat", 2.0))
            options.append(("union", 2.0))

        total_weight = sum(w for _, w in options)
        r = random.uniform(0.0, total_weight)
        cumulative = 0.0
        chosen = "leaf"
        for name, weight in options:
            cumulative += weight
            if r <= cumulative:
                chosen = name
                break

        if chosen == "leaf":
            return build_regex(0)

        if chosen == "plus":
            sub, _ = build_regex(depth - 1)
            return f"(re.+ {sub})", True

        if chosen == "star":
            sub, _ = build_regex(depth - 1)
            return f"(re.* {sub})", True

        if chosen == "concat":
            d1 = random.randint(0, depth - 1)
            d2 = depth - 1 - d1
            left, has_q1 = build_regex(d1)
            right, has_q2 = build_regex(d2)
            return f"(re.++ {left} {right})", has_q1 or has_q2

        if chosen == "union":
            d1 = random.randint(0, depth - 1)
            d2 = depth - 1 - d1
            left, has_q1 = build_regex(d1)
            right, has_q2 = build_regex(d2)
            return f"(re.union {left} {right})", has_q1 or has_q2

        raise RuntimeError("Unreachable")

    for _ in range(100):
        regex_str, has_quant = build_regex(max(0, max_depth))
        if has_quant:
            return regex_str

    d = random.randint(0, 9)
    return random.choice(
        [
            f'(re.+ (str.to_re "{d}"))',
            f'(re.* (str.to_re "{d}"))',
            f'(re.+ (re.range "0" "9"))',
            f'(re.* (re.range "0" "9"))',
        ]
    )


def generate_regex_constraints(num_vars: int, regex_count: int, regex_max_depth: int = REGEX_DEFAULT_MAX_DEPTH) -> List[str]:
    """
    Generate regex constraints for variables using digits 0-9.
    Produces at most `regex_count` constraints; each generated regex contains re.+ or re.*.
    """
    var_names = get_variable_names(num_vars)
    if regex_count <= 0:
        return []

    selected_vars = random.sample(var_names, k=min(regex_count, len(var_names)))
    constraints = []
    for var in selected_vars:
        regex_pattern = generate_random_digit_regex(regex_max_depth)
        constraints.append(f"(assert (str.in_re {var} {regex_pattern}))")
    return constraints


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


def generate_str_len_constraint(num_vars: int) -> str:
    """Generate a single linear constraint using str.len with random coefficients and constants."""
    var_names = get_variable_names(num_vars)

    coeffs = [random.randint(COEFF_MIN, COEFF_MAX) for _ in range(num_vars)]
    constant = random.randint(CONST_MIN, CONST_MAX)
    op = random.choice(["<", ">", "<=", ">=", "="])

    terms: List[str] = []
    for coeff, var in zip(coeffs, var_names):
        t = format_coefficient_term(coeff, f"(str.len {var})")
        if t:
            terms.append(t)

    if not terms:
        return generate_str_len_constraint(num_vars)

    left_side = terms[0] if len(terms) == 1 else "(+ " + " ".join(terms) + ")"
    return f"(assert ({op} {left_side} {constant}))"


def generate_str_to_int_constraint(num_vars: int) -> str:
    """Generate a single linear constraint using str.to_int with random coefficients and constants."""
    var_names = get_variable_names(num_vars)

    coeffs = [random.randint(COEFF_MIN, COEFF_MAX) for _ in range(num_vars)]
    constant = random.randint(CONST_MIN, CONST_MAX)
    op = random.choice(["<", ">", "<=", ">=", "="])

    terms: List[str] = []
    for coeff, var in zip(coeffs, var_names):
        t = format_coefficient_term(coeff, f"(str.to_int {var})")
        if t:
            terms.append(t)

    if not terms:
        return generate_str_to_int_constraint(num_vars)

    left_side = terms[0] if len(terms) == 1 else "(+ " + " ".join(terms) + ")"
    return f"(assert ({op} {left_side} {constant}))"


def generate_mixed_constraint(num_vars: int) -> str:
    """Generate a single linear constraint mixing both str.len and str.to_int."""
    var_names = get_variable_names(num_vars)

    len_coeffs = [(random.randint(COEFF_MIN, COEFF_MAX) if random.randint(1, 6) <= 2 else 0) for _ in range(num_vars)]
    int_coeffs = [(random.randint(COEFF_MIN, COEFF_MAX) if random.randint(1, 6) <= 2 else 0) for _ in range(num_vars)]

    if not any(c != 0 for c in len_coeffs) or not any(c != 0 for c in int_coeffs):
        return generate_mixed_constraint(num_vars)

    constant = random.randint(CONST_MIN, CONST_MAX)
    op = random.choice(["<", ">", "<=", ">=", "="])

    terms: List[str] = []
    for coeff, var in zip(len_coeffs, var_names):
        t = format_coefficient_term(coeff, f"(str.len {var})")
        if t:
            terms.append(t)

    for coeff, var in zip(int_coeffs, var_names):
        t = format_coefficient_term(coeff, f"(str.to_int {var})")
        if t:
            terms.append(t)

    if not terms:
        return generate_mixed_constraint(num_vars)

    left_side = terms[0] if len(terms) == 1 else "(+ " + " ".join(terms) + ")"
    return f"(assert ({op} {left_side} {constant}))"


def generate_constraints_by_weight(num_vars: int, target_weight: int) -> List[str]:
    """
    Generate constraints to reach the target weight.
    Mixed constraints have weight 2, str.len and str.to_int have weight 1.
    """
    constraints: List[str] = []
    remaining_weight = target_weight

    while remaining_weight > 0:
        if remaining_weight >= 2:
            kind = random.choice(["len", "to_int", "mixed"])
        else:
            kind = random.choice(["len", "to_int"])

        if kind == "mixed":
            constraints.append(generate_mixed_constraint(num_vars))
            remaining_weight -= 2
        elif kind == "len":
            constraints.append(generate_str_len_constraint(num_vars))
            remaining_weight -= 1
        else:
            constraints.append(generate_str_to_int_constraint(num_vars))
            remaining_weight -= 1

    if not any("str.len" in c for c in constraints) or not any("str.to_int" in c for c in constraints):
        return generate_constraints_by_weight(num_vars, target_weight)

    return constraints


def verify_regex_constraints_satisfiable(
    num_vars: int,
    regex_constraints: List[str],
    timeout_ms: int = DEFAULT_REGEX_VERIFY_TIMEOUT_MS,
    solver: str = DEFAULT_SOLVER,
) -> bool:
    """Verify that the regex constraints themselves are satisfiable."""
    lines: List[str] = []
    lines.append(f"(set-logic {LOGIC})")
    lines.append("")
    lines.extend(generate_variable_declarations(num_vars))
    lines.append("")

    for var in get_variable_names(num_vars):
        lines.append(f"(assert (>= (str.to_int {var}) 0))")
    lines.append("")

    lines.extend(regex_constraints)
    lines.append("")
    lines.append("(check-sat)")

    result, _ = check_benchmark_with_z3("\n".join(lines), timeout_ms=timeout_ms, solver=solver)
    return result == "sat"


def generate_benchmark(
    num_vars: int,
    weight: int,
    no_regex: bool = False,
    solver: str = DEFAULT_SOLVER,
    regex_verify_timeout_ms: int = DEFAULT_REGEX_VERIFY_TIMEOUT_MS,
    regex_max_depth: int = REGEX_DEFAULT_MAX_DEPTH,
) -> Tuple[str, bool]:
    """
    Generate a complete SMT-LIB benchmark.

    Returns:
        (benchmark_content, regex_satisfiable)
    """
    lines: List[str] = []
    lines.append(f"(set-logic {LOGIC})")
    lines.append("")
    lines.extend(generate_variable_declarations(num_vars))
    lines.append("")

    for var in get_variable_names(num_vars):
        lines.append(f"(assert (>= (str.to_int {var}) 0))")
    lines.append("")

    regex_count = num_vars
    regex_satisfiable = True

    if not no_regex:
        regex_constraints = generate_regex_constraints(num_vars, regex_count, regex_max_depth=regex_max_depth)
        if regex_constraints:
            regex_satisfiable = verify_regex_constraints_satisfiable(
                num_vars,
                regex_constraints,
                timeout_ms=regex_verify_timeout_ms,
                solver=solver,
            )
            lines.extend(regex_constraints)
            lines.append("")

    constraints = generate_constraints_by_weight(num_vars, weight)
    if constraints:
        lines.extend(constraints)
        lines.append("")

    lines.append("(check-sat)")
    return "\n".join(lines), regex_satisfiable


def check_benchmark_with_z3(
    benchmark_content: str,
    timeout_ms: int = DEFAULT_TIMEOUT_MS,
    solver: str = DEFAULT_SOLVER,
) -> Tuple[Optional[str], Optional[int]]:
    """
    Check a benchmark with a solver.

    Solver invocation is: `<solver> <file.smt2>`.

    Returns:
        (result, time_ms): result in {'sat','unsat','unknown'} or None on error,
                           time_ms is wall-clock time measured here (best-effort).
    """
    tmp_filename: Optional[str] = None
    start = time.perf_counter()
    try:
        with tempfile.NamedTemporaryFile(mode="w", suffix=".smt2", delete=False) as tmp_file:
            tmp_filename = tmp_file.name
            tmp_file.write(benchmark_content)

        try:
            completed = subprocess.run(
                [solver, tmp_filename],
                capture_output=True,
                text=True,
                timeout=(timeout_ms / 1000.0) + SUBPROCESS_TIMEOUT_BUFFER_SEC,
            )
        except subprocess.TimeoutExpired:
            return "unknown", int((time.perf_counter() - start) * 1000)

        output = completed.stdout.strip().lower()
        elapsed_ms = int((time.perf_counter() - start) * 1000)

        if "unsat" in output:
            return "unsat", elapsed_ms
        if "sat" in output and "unsat" not in output:
            return "sat", elapsed_ms
        if "unknown" in output or "timeout" in output:
            return "unknown", elapsed_ms

        return None, elapsed_ms

    except Exception as e:
        print(f"Error checking benchmark: {e}")
        return None, None
    finally:
        if tmp_filename and os.path.exists(tmp_filename):
            try:
                os.unlink(tmp_filename)
            except OSError:
                pass


def is_trivial_benchmark(
    benchmark_content: str,
    quick_timeout_ms: int = DEFAULT_QUICK_TIMEOUT_MS,
    solver: str = DEFAULT_SOLVER,
) -> bool:
    """
    A benchmark is considered trivial if the solver can solve it within quick_timeout_ms.
    Keep benchmarks that return unknown within the quick timeout.
    """
    result, _ = check_benchmark_with_z3(benchmark_content, timeout_ms=quick_timeout_ms, solver=solver)
    return result != "unknown"


def try_generate_nontrivial_benchmark(
    num_vars: int,
    weight: int,
    max_attempts: int = 100,
    quick_timeout_ms: int = DEFAULT_QUICK_TIMEOUT_MS,
    no_regex: bool = False,
    solver: str = DEFAULT_SOLVER,
    regex_verify_timeout_ms: int = DEFAULT_REGEX_VERIFY_TIMEOUT_MS,
    regex_max_depth: int = REGEX_DEFAULT_MAX_DEPTH,
) -> Tuple[str, bool, int, int]:
    """
    Try to generate a non-trivial benchmark with the given parameters.

    Returns:
        (benchmark_content, is_nontrivial, attempts_made, regex_unsat_count)
    """
    last_benchmark: Optional[str] = None
    regex_unsat_count = 0

    for attempt in range(1, max_attempts + 1):
        benchmark_content, regex_satisfiable = generate_benchmark(
            num_vars,
            weight,
            no_regex=no_regex,
            solver=solver,
            regex_verify_timeout_ms=regex_verify_timeout_ms,
            regex_max_depth=regex_max_depth,
        )

        if not regex_satisfiable:
            regex_unsat_count += 1
            continue

        last_benchmark = benchmark_content

        if not is_trivial_benchmark(benchmark_content, quick_timeout_ms=quick_timeout_ms, solver=solver):
            return benchmark_content, True, attempt, regex_unsat_count

    if last_benchmark is None:
        benchmark_content, _ = generate_benchmark(
            num_vars,
            weight,
            no_regex=no_regex,
            solver=solver,
            regex_verify_timeout_ms=regex_verify_timeout_ms,
            regex_max_depth=regex_max_depth,
        )
        last_benchmark = benchmark_content

    return last_benchmark, False, max_attempts, regex_unsat_count


def main():
    """Main function to generate all benchmark combinations."""
    parser = argparse.ArgumentParser(
        description="Generate SMT-LIB benchmarks for QF_SLIA string/arith constraints, with optional regex membership constraints."
    )

    parser.add_argument(
        "--solver",
        default=DEFAULT_SOLVER,
        help="Solver executable to run as: <solver> <file.smt2> (default: z3).",
    )
    parser.add_argument(
        "--timeout-ms",
        type=int,
        default=DEFAULT_TIMEOUT_MS,
        help=f"Per-invocation solver timeout used by checks (ms). Applies to 'sat/unsat/unknown' probing (default: {DEFAULT_TIMEOUT_MS}).",
    )
    parser.add_argument(
        "--quick-timeout-ms",
        type=int,
        default=DEFAULT_QUICK_TIMEOUT_MS,
        help=f"Timeout for triviality filtering (ms). Benchmarks solved within this are discarded as trivial (default: {DEFAULT_QUICK_TIMEOUT_MS}).",
    )
    parser.add_argument(
        "--regex-verify-timeout-ms",
        type=int,
        default=DEFAULT_REGEX_VERIFY_TIMEOUT_MS,
        help=f"Timeout for regex satisfiability pre-check (ms). Only used when regex generation is enabled (default: {DEFAULT_REGEX_VERIFY_TIMEOUT_MS}).",
    )

    regex_group = parser.add_mutually_exclusive_group()
    regex_group.add_argument(
        "--regex",
        dest="enable_regex",
        action="store_true",
        help="Enable generation of regex membership constraints (default: disabled).",
    )
    regex_group.add_argument(
        "--no-regex",
        dest="enable_regex",
        action="store_false",
        help="Disable generation of regex membership constraints (default).",
    )
    parser.set_defaults(enable_regex=False)

    parser.add_argument(
        "--regex-max-depth",
        type=int,
        default=REGEX_DEFAULT_MAX_DEPTH,
        help=f"Maximum depth of generated regex AST. Higher values yield larger regexes (default: {REGEX_DEFAULT_MAX_DEPTH}).",
    )

    args = parser.parse_args()

    num_vars_options = [2, 3, 4, 5]
    weight_options = range(2, 7)
    benchmarks_per_config = 5

    max_attempts_per_benchmark = 100
    output_dir = "smt_benchmarks"
    os.makedirs(output_dir, exist_ok=True)

    total_benchmarks = 0
    total_nontrivial = 0
    total_trivial = 0
    total_attempts = 0
    total_regex_unsat = 0

    print("Starting benchmark generation...")
    print(f"Solver: {args.solver} (invoked as: {args.solver} <file.smt2>)")
    print(f"Probe timeout: {args.timeout_ms}ms")
    print(f"Triviality timeout: {args.quick_timeout_ms}ms")
    print(f"Regex enabled: {args.enable_regex}")
    if args.enable_regex:
        print(f"Regex verify timeout: {args.regex_verify_timeout_ms}ms")
        print(f"Regex max depth: {max(0, args.regex_max_depth)}")
        print("Regex requirement: contains re.+ or re.*")
    print(f"Benchmarks per configuration: {benchmarks_per_config}")
    print(f"Max attempts per benchmark: {max_attempts_per_benchmark}")
    print(f"Coefficient range: [{COEFF_MIN}, {COEFF_MAX}]")
    print(f"Constant range: [{CONST_MIN}, {CONST_MAX}]")
    print("Constraint weights: mixed=2, len=1, to_int=1")
    print("=" * 80)

    for num_vars, weight in product(num_vars_options, weight_options):
        print(f"\n--- Variables: {num_vars}, Weight: {weight} ---")

        for benchmark_idx in range(benchmarks_per_config):
            total_benchmarks += 1

            filename = f"benchmark_v{num_vars}_w{weight:02d}_n{benchmark_idx + 1:02d}.smt2"
            filepath = os.path.join(output_dir, filename)

            print(f"[{total_benchmarks:4d}] {filename}...", end=" ", flush=True)

            benchmark_content, is_nontrivial, attempts, regex_unsat = try_generate_nontrivial_benchmark(
                num_vars,
                weight,
                max_attempts=max_attempts_per_benchmark,
                quick_timeout_ms=args.quick_timeout_ms,
                no_regex=not args.enable_regex,
                solver=args.solver,
                regex_verify_timeout_ms=args.regex_verify_timeout_ms,
                regex_max_depth=max(0, args.regex_max_depth),
            )

            total_attempts += attempts
            total_regex_unsat += regex_unsat

            with open(filepath, "w") as f:
                f.write(benchmark_content)

            if is_nontrivial:
                total_nontrivial += 1
                status = f"✓ ({attempts} att)"
            else:
                total_trivial += 1
                status = f"✗ ({attempts} att)"

            if regex_unsat > 0:
                status += f" [skip: {regex_unsat} unsat-re]"

            print(status)

    print("\n" + "=" * 80)
    print("Benchmark Generation Complete!")
    print("=" * 80)
    print(f"Total benchmarks generated:   {total_benchmarks}")
    print(f"Non-trivial benchmarks:       {total_nontrivial} ({100 * total_nontrivial / total_benchmarks:.1f}%)")
    print(f"Trivial benchmarks:           {total_trivial} ({100 * total_trivial / total_benchmarks:.1f}%)")
    print(f"Total attempts made:          {total_attempts}")
    print(f"Regex unsat attempts skipped: {total_regex_unsat}")
    print(f"Average attempts/benchmark:   {total_attempts / total_benchmarks:.1f}")
    print(f"\nAll benchmarks saved to:      '{output_dir}/'")
    print("\nParameters:")
    print(f"  - Logic: {LOGIC}")
    print(f"  - Solver: {args.solver}")
    print(f"  - Variables: {num_vars_options}")
    print(f"  - Weights: {list(weight_options)}")
    print(f"  - Benchmarks per config: {benchmarks_per_config}")
    print(f"  - Coefficient range: [{COEFF_MIN}, {COEFF_MAX}]")
    print(f"  - Constant range: [{CONST_MIN}, {CONST_MAX}]")
    print(f"  - Probe timeout: {args.timeout_ms}ms")
    print(f"  - Triviality timeout: {args.quick_timeout_ms}ms")
    print(f"  - Regex enabled: {args.enable_regex}")
    if args.enable_regex:
        print(f"  - Regex max depth: {max(0, args.regex_max_depth)}")
        print(f"  - Regex verify timeout: {args.regex_verify_timeout_ms}ms")


if __name__ == "__main__":
    main()

