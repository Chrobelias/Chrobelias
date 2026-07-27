#!/usr/bin/env python3
"""

SMT-LIB Benchmark Generator for LIA Constraints under existence quantifier

"""

from random import randint, choice
import os
import sys

num_of_vars = 10
num_of_coeffs = 5
num_of_files = 20
vars_to_eliminate = num_of_vars // 2

max_true_integer_value = 100
min_true_integer_value = 0

def generate_gl_matrix(n, max_coeff=5):
    """Generates an n x n unimodular matrix (det = +/- 1) using LU style."""
    L = [[0]*n for _ in range(n)]
    U = [[0]*n for _ in range(n)]

    for i in range(n):
        L[i][i] = choice([1, -1])
        U[i][i] = choice([1, -1])

        for j in range(i + 1, n):
            L[j][i] = randint(-max_coeff, max_coeff)
            U[i][j] = randint(-max_coeff, max_coeff)

    A = [[0]*n for _ in range(n)]
    for i in range(n):
        for j in range(n):
            A[i][j] = sum(L[i][k] * U[k][j] for k in range(n))

    return A

def generate_smt2(n_vars, filename, is_sat=True, max_coeff=5):
    A = generate_gl_matrix(n_vars, max_coeff)
    
    var_names = [f"x{i}" for i in range(n_vars)]

    x_true = [randint(min_true_integer_value, max_true_integer_value) for _ in range(n_vars)]

    k = [sum(A[i][j] * x_true[j] for j in range(n_vars)) for i in range(n_vars)]

    if not is_sat:
        k[-1] += choice([1, -1])

    lines = []
    lines.append("(set-logic LIA)")
    lines.append("")

    vars_decl = " ".join(f"({var_names[i]} Int)" for i in range(0, vars_to_eliminate))
    for i in range(vars_to_eliminate, n_vars):
        lines.append(f"(declare_fun {var_names[i]} () Int)")

    lines.append(f"(assert (exists ({vars_decl})")
    lines.append("  (and")

    for i in range(n_vars):
        terms = []
        for j in range(n_vars):
            coeff = A[i][j]
            if coeff == 0:
                continue
            if coeff == 1:
                terms.append(var_names[j])
            elif coeff == -1:
                terms.append(f"(- {var_names[j]})")
            else:
                terms.append(f"(* {coeff} {var_names[j]})")

        if len(terms) == 1:
            left_side = terms[0]
        else:
            left_side = f"(+ {' '.join(terms)})"

        right_side = str(k[i])
        lines.append(f"    (= {left_side} {right_side})")

    lines.append("  ))")
    lines.append("")
    lines.append("(check-sat)")

    with open(filename, "w") as f:
        f.write("\n".join(lines) + "\n")

    expected = "sat" if is_sat else "unsat"
    print(f"Generated {filename} (Expected: {expected})")

def main():
    """Main function to generate all benchmark combinations."""

    output_dir = "gaussqe_benchmarks"
    os.makedirs(output_dir, exist_ok=True)

    total_benchmarks = 0

    print("Starting GAUSSQE benchmarks generation...")

    print("=" * 80)

    for i in range(num_of_files):
        generate_smt2(n_vars=num_of_vars, filename=f"{output_dir}/bench_sat_{i}.smt2", is_sat=True, max_coeff=num_of_coeffs)
        generate_smt2(n_vars=num_of_vars, filename=f"{output_dir}/bench_unsat_{i}.smt2", is_sat=False, max_coeff=num_of_coeffs)

    print("\n" + "=" * 80)
    print("Benchmark Generation Complete!")
    print("=" * 80)

if __name__ == "__main__":
    main()

