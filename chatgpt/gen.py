#!/usr/bin/env python3

import random
import os
from z3 import *

random.seed(0)

OUTPUT_DIR = "benchmarks"

# ------------------------------------------------------------
# Templates for int.v predicates
# ------------------------------------------------------------

TEMPLATES = [
    ("successor",
     lambda v: ([1], [0], 1),
     "valuation of {}+1"),

    ("difference",
     lambda v: ([1,-1], [0,1], 0),
     "valuation of {}-{}"),

    ("sum",
     lambda v: ([1,1], [0,1], 0),
     "valuation of {}+{}"),

    ("double_plus",
     lambda v: ([2,1], [0,1], 0),
     "valuation of 2*{}+{}"),

    ("double_minus",
     lambda v: ([2,-1], [0,1], 0),
     "valuation of 2*{}-{}"),

    ("distance1",
     lambda v: ([1], [0], -1),
     "valuation of {}-1"),

    ("distance2",
     lambda v: ([1], [0], 2),
     "valuation of {}+2"),
]

# ------------------------------------------------------------

def affine_string(coeffs, vars, const):

    terms=[]

    for c,x in zip(coeffs,vars):
        if c==1:
            terms.append(x)
        elif c==0: terms
        elif c<= -1:
            terms.append(f"(* (- {-c}) {x})")
        else:
            terms.append(f"(* {c} {x})")

    if const!=0:
        terms.append(str(const))

    if len(terms)==1:
        return terms[0]

    return "(+ " + " ".join(terms) + ")"


def z3_affine(coeffs, vars, const):
    s=const
    for c,x in zip(coeffs,vars):
        s+=c*x
    return s


def budget(coeffs,const):
    return sum(abs(c) for c in coeffs)+abs(const)


os.makedirs(OUTPUT_DIR,exist_ok=True)

instance=0

for nvars in [2,3,4]:

    varnames=[f"x{i}" for i in range(nvars)]

    for nvals in [2,3]:

        dirname=f"{OUTPUT_DIR}/{nvars}vars_{nvals}vals"
        os.makedirs(dirname,exist_ok=True)
        valnames=[f"u{i}" for i in range(nvals)]

        for k in range(10):

            vars=[Int(v) for v in varnames]

            model=[random.randint(-3,3) for _ in vars]

            solver=Solver()

            for x,val in zip(vars,model):
                solver.add(x==val)

            constraints=[]
            used_budget=0

            # --------------------------------------------------
            # produce 2-4 satisfiable LIA constraints
            # --------------------------------------------------

            nl=random.randint(1,2)

            while len(constraints)<nl:

                coeffs=[random.randint(-3,3) for _ in vars]

                if all(c==0 for c in coeffs):
                    continue

                lhs=sum(c*v for c,v in zip(coeffs,model))

                typ=random.choice(["=","<=","<="])

                if typ=="=":
                    rhs=lhs
                else:
                    rhs=lhs+random.randint(0,3)

                b=budget(coeffs,rhs)

                if used_budget+b>nvars*nl*10:
                    continue

                used_budget+=b

                constraints.append((coeffs,typ,rhs))

            # --------------------------------------------------
            # valuation predicates
            # --------------------------------------------------

            vals=[]

            for i in range(nvals):

                while True:

                    name,shape,comment=random.choice(TEMPLATES)

                    coeffs,idx,const=shape(vars)

                    idx=[j%nvars for j in idx]

                    c=[coeffs[j] for j in range(len(coeffs))]
                    v=[varnames[j] for j in idx]

                    if used_budget+budget(c,const)>nvars*nl*10 + nvals*5:
                        continue

                    used_budget+=budget(c,const)

                    vals.append((c,v,const,comment.format(*v),f"u{i}"))

                    break

            # --------------------------------------------------
            # produce 1-3 satisfiable LIA constraints over valuations
            # --------------------------------------------------

            nvl=random.randint(1,2)
            vals_constraints=[]

            while len(vals_constraints)<nvl:

                val_vars=[Int(v) for v in valnames]

                coeffs=[random.randint(-2,2) for _ in val_vars]

                if all(c==0 for c in coeffs):
                    continue

                lhs=sum(c*v for c,v in zip(coeffs,model))

                typ=random.choice(["=","<=","<="])

                if typ=="=":
                    rhs=lhs
                else:
                    rhs=lhs+random.randint(0,3)

                b=budget(coeffs,rhs)

                if used_budget+b>nvars*nl*10 + nvals*(1+nvl)*5:
                    continue

                used_budget+=b

                vals_constraints.append((coeffs,typ,rhs))

            # --------------------------------------------------
            # write file
            # --------------------------------------------------

            fname=f"{dirname}/bench_{k:02d}.smt2"

            with open(fname,"w") as f:

                f.write("(set-logic QF_SLIA)\n\n")

                for v in varnames:
                    f.write(f"(declare-fun {v} () Int)\n")

                for i in range(nvals):
                    f.write(f"(declare-fun u{i} () Int)\n")

                f.write("\n")

                for coeffs,typ,rhs in constraints:

                    expr=affine_string(coeffs,varnames,0)

                    if typ=="=":
                        f.write(f"(assert (= {expr} {rhs}))\n")
                    else:
                        f.write(f"(assert (<= {expr} {rhs}))\n")

                f.write("\n")

                for coeffs,v,const,comment,u in vals:

                    f.write(f"; {u} is the {comment}.\n")

                    expr=affine_string(coeffs,v,const)

                    f.write(f"(assert (int.v {expr} {u}))\n\n")

                for coeffs,typ,rhs in vals_constraints:

                    expr=affine_string(coeffs,valnames,0)

                    if typ=="=":
                        f.write(f"(assert (= {expr} {rhs}))\n")
                    else:
                        f.write(f"(assert (<= {expr} {rhs}))\n")


                f.write("(check-sat)\n")