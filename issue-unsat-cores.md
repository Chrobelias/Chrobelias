# Expose unsat cores in the solver interface

Issue draft for [formalsec/smtml](https://github.com/formalsec/smtml).

---

`Mappings_intf.S.Solver` has

```ocaml
val check : ?ctx:term Symbol.Map.t -> solver -> assumptions:term list
  -> [ `Sat | `Unsat | `Unknown ]
```

but no way to ask which assumptions caused `` `Unsat ``, although the
underlying solvers can report exactly that (Z3: `Z3.Solver.get_unsat_core`,
cvc5: `Solver.getUnsatCore`, Bitwuzla: `get_unsat_core`).

Without it a client has to minimize by deletion: re-run `check` once per
assumption with that assumption dropped. In Chrobelias we extract a core from
~450 assumptions inside an inner solving loop; deletion costs ~450 `check`
calls per extraction, and because every non-literal assumption gets
re-internalized by Z3 on each call, profiling showed >80% of total solver
runtime inside `smt::context::internalize_proxies`. With a native core the
same extraction is a single `check` plus a few probes.

Proposed addition:

```ocaml
(** [get_unsat_core solver] returns the subset of the assumptions passed to
    the last [check] that the solver used to derive unsatisfiability.
    Meaningful only when the last [check] returned [`Unsat]. *)
val get_unsat_core : solver -> term list
```

For backends without core support the function can raise or return all
assumptions (both are sound over-approximations of a core, though returning
everything silently is easy to misread as a real core, so raising seems
better).

For now we work around this by translating our formulas to the Z3 OCaml
bindings directly and querying the core there (`lib/Overapprox.ml`,
`check_length_core_exn`), which defeats the point of going through smtml —
we'd be happy to drop that code.
