#!/usr/bin/env python3
"""

SMT-LIB Benchmark Generator for LIA Constraints under existence quantifier

"""

from random import randint, choice, seed
import argparse
from time import time
import os

def generate_gl_matrix(n, min_coeff, max_coeff):
    """Generates an n x n unimodular matrix (det = +/- 1) using LU style."""
    L = [[0]*n for _ in range(n)]
    U = [[0]*n for _ in range(n)]

    for i in range(n):
        L[i][i] = choice([1, -1])
        U[i][i] = choice([1, -1])

        for j in range(i + 1, n):
            L[j][i] = randint(min_coeff, max_coeff)
            U[i][j] = randint(min_coeff, max_coeff)

    A = [[0]*n for _ in range(n)]
    for i in range(n):
        for j in range(n):
            A[i][j] = sum(L[i][k] * U[k][j] for k in range(n))

    return A

def generate_left_side(terms):
    if len(terms) == 1:
        return str(terms[0])
    first_term = terms[0]
    right_term = generate_left_side(terms[1:])
    return f"(+ {first_term} {right_term})"


def generate_smt2(args, filename, is_sat):
    A = generate_gl_matrix(args.vars, args.min, args.max)

    var_names = [f"x{i}" for i in range(args.vars)]

    x_true = [randint(args.min, args.max) for _ in range(args.vars)]

    k = [sum(A[i][j] * x_true[j] for j in range(args.vars)) for i in range(args.vars)]

    lines = []
    lines.append("(set-info :smt-lib-version 2.6)")
    lines.append("(set-logic LIA)")
    lines.append("")

    vars_decl = " ".join(f"({var_names[i]} Int)" for i in range(0, args.bounds))
    for i in range(args.bounds, args.vars):
        lines.append(f"(declare-fun {var_names[i]} () Int)")

    lines.append(f"(assert (exists ({vars_decl})")
    lines.append("  (and")

    for i in range(args.vars):
        terms = []
        for j in range(args.vars):
            coeff = A[i][j]
            if coeff == 0:
                continue
            if coeff == 1:
                terms.append(var_names[j])
            elif coeff < 0:
                terms.append(f"(* (- {-coeff}) {var_names[j]})")
            else:
                terms.append(f"(* {coeff} {var_names[j]})")


        left_side = generate_left_side(terms)
        right_side = f"{k[i]}" if k[i] >= 0 else f"(- {- k[i]})"

        lines.append(f"    (= {left_side} {right_side})")

    if not is_sat:
        lines.append(f"    (= {var_names[0]} 0)")
        lines.append(f"    (= {var_names[0]} 1)")

    lines.append("  )))")
    lines.append("")
    lines.append("(check-sat)")

    with open(filename, "w") as f:
        f.write("\n".join(lines) + "\n")

    expected = "sat" if is_sat else "unsat"
    print(f"Generated {filename} (Expected: {expected})")

def main():
    """Main function to generate all benchmark combinations."""
    parser = argparse.ArgumentParser()

    parser.add_argument("--vars", type=int, required=True, help="Number of vars")
    parser.add_argument("-n", "--num", type=int, required=True, help="Number of file generated")
    parser.add_argument("-b", "--bounds", type=int, required=True, help="Number of bound variables")
    parser.add_argument("--max", type=int, required=True, help="Max value possible for integers")
    parser.add_argument("--min", type=int, required=True, help="Min value possible for integers")
    parser.add_argument("--seed", type=str, required=False, default=int(time() * 1000), help="seed")

    args = parser.parse_args()
    seed(args.seed)

    output_dir = "gaussqe_benchmarks"
    os.makedirs(output_dir, exist_ok=True)

    print("Starting GAUSSQE benchmarks generation...")
    print("=" * 80)

    for i in range(args.num):
        generate_smt2(args, f"{output_dir}/bench_sat_{i}.smt2", True)
        generate_smt2(args, f"{output_dir}/bench_unsat_{i}.smt2", False)

    print("\n" + "=" * 80)
    print("Benchmark Generation Complete!")
    print(f"Seed: {args.seed}")
    print("=" * 80)

if __name__ == "__main__":
    main()
