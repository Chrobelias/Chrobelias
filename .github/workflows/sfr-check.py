#!/usr/bin/env python3
"""Run benchmarks with one or two Chrobelias binaries and compare them.

    sfr-check.py --flags "-q" --label q --out DIR \
        [--bin base=PATH] --bin head=PATH FILE...

Every file is one task, and each task runs all binaries on that file back to
back, so they see the same load. A file is solved when the answer is sat or
unsat, agrees with the file's :status, and the model check didn't fail.

With two binaries, the files where they differ are run again one at a time,
because unknowns and timeouts depend on the load, and the second run decides.

Writes DIR/results-LABEL.tsv, DIR/summary-LABEL.md (a markdown table and the
files that changed, also printed to stdout), DIR/comment-LABEL.md (the table
and the number of changed files, for the PR comment) and DIR/result-LABEL.json ({"regressed": ...}). A
regression is fewer solved files, or a wrong answer or failed model check
that the base didn't have.
"""

import argparse
import json
import os
import re
import signal
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

STATUS = re.compile(rb":status\s+(sat|unsat|unknown)")


def expected_status(path):
    m = STATUS.search(Path(path).read_bytes())
    return m.group(1).decode() if m else "none"


def run(binary, flags, path, timeout):
    start = time.monotonic()
    proc = subprocess.Popen(
        [binary, *flags, path, "--check-model"],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        start_new_session=True,  # so that a timeout also kills z3 and friends
    )
    try:
        out, err = proc.communicate(timeout=timeout)
        lines = out.decode(errors="replace").splitlines()
        first = lines[0] if lines else ""
        actual = "error"
        for verdict in ("unsat", "sat", "unknown"):
            if first.startswith(verdict):
                actual = verdict
                break
    except subprocess.TimeoutExpired:
        os.killpg(proc.pid, signal.SIGKILL)
        out, err = proc.communicate()
        actual = "timeout"
    err = err.decode(errors="replace")
    if "model check has failed" in err:
        model = "bad"
    elif "correctness of model is unknown" in err:
        model = "unknown"
    else:
        model = "ok"
    return {"actual": actual, "model": model, "seconds": time.monotonic() - start}


def classify(r, expected):
    a = r["actual"]
    r["wrong"] = a in ("sat", "unsat") and expected in ("sat", "unsat") and a != expected
    r["solved"] = a in ("sat", "unsat") and not r["wrong"] and r["model"] != "bad"
    return r


def run_file(bins, flags, path, timeout):
    expected = expected_status(path)
    return path, expected, {
        name: classify(run(binary, flags, path, timeout), expected)
        for name, binary in bins
    }


def counts(results, name):
    rs = [by[name] for _, _, by in results]
    return {
        "solved": sum(r["solved"] for r in rs),
        "sat": sum(r["actual"] == "sat" for r in rs),
        "unsat": sum(r["actual"] == "unsat" for r in rs),
        "unknown": sum(r["actual"] == "unknown" for r in rs),
        "timeout": sum(r["actual"] == "timeout" for r in rs),
        "error": sum(r["actual"] == "error" for r in rs),
        "wrong": sum(r["wrong"] for r in rs),
        "bad model": sum(r["model"] == "bad" for r in rs),
        "time on solved, s": round(sum(r["seconds"] for r in rs if r["solved"]), 1),
    }


def describe(r):
    s = r["actual"]
    if r["wrong"]:
        s += " (wrong)"
    if r["model"] == "bad":
        s += " (bad model)"
    return s


def file_list(title, rows):
    if not rows:
        return []
    items = [f"- `{Path(p).name}`: {b} → {h}" for p, b, h in rows]
    out = [f"**{title} ({len(rows)})**", ""]
    if len(items) <= 30:
        return out + items + [""]
    return (
        out
        + items[:30]
        + ["", "<details><summary>All of them</summary>", ""]
        + items[30:]
        + ["", "</details>", ""]
    )


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--flags", default="")
    ap.add_argument("--label", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--bin", action="append", required=True, help="NAME=PATH")
    ap.add_argument("--timeout", type=float, default=10)
    ap.add_argument("--jobs", type=int, default=os.cpu_count())
    ap.add_argument("files", nargs="+")
    args = ap.parse_args()

    bins = [tuple(b.split("=", 1)) for b in args.bin]
    flags = args.flags.split()
    out = Path(args.out)
    out.mkdir(parents=True, exist_ok=True)

    start = time.monotonic()
    with ThreadPoolExecutor(args.jobs) as pool:
        results = list(
            pool.map(lambda p: run_file(bins, flags, p, args.timeout), args.files)
        )
    print(f"ran {len(results)} files in {time.monotonic() - start:.0f} s", file=sys.stderr)

    names = [n for n, _ in bins]
    rechecked = 0
    if len(bins) == 2:
        base, head = names

        def differs(by):
            return any(by[base][k] != by[head][k] for k in ("solved", "wrong"))

        for i, (path, expected, by) in enumerate(results):
            if differs(by) or (by[head]["model"] == "bad") != (by[base]["model"] == "bad"):
                results[i] = run_file(bins, flags, path, args.timeout)
                rechecked += 1
        print(f"re-ran {rechecked} differing files one at a time", file=sys.stderr)

    with open(out / f"results-{args.label}.tsv", "w") as f:
        for path, expected, by in results:
            for name, r in by.items():
                f.write(
                    f"{name}\t{path}\t{expected}\t{r['actual']}\t{r['model']}\t{r['seconds']:.2f}\n"
                )

    c = {n: counts(results, n) for n in names}
    md = [f"### stringfuzzregex `{args.flags or '(no flags)'}`", ""]
    md += ["| | " + " | ".join(names) + (" | Δ |" if len(names) == 2 else " |")]
    md += ["|---" * (len(names) + 1 + (len(names) == 2)) + "|"]
    for key in c[names[0]]:
        row = [str(c[n][key]) for n in names]
        if len(names) == 2:
            d = c[names[1]][key] - c[names[0]][key]
            row.append(f"{d:+.1f}" if isinstance(d, float) else f"{d:+d}")
        md.append(f"| {key} | " + " | ".join(row) + " |")
    md += ["", f"{len(results)} files, {args.timeout:g} s timeout.", ""]

    regressed = False
    comment = list(md)
    if len(names) == 2:
        base, head = names
        lost = [(p, describe(b[base]), describe(b[head])) for p, _, b in results
                if b[base]["solved"] and not b[head]["solved"]]
        won = [(p, describe(b[base]), describe(b[head])) for p, _, b in results
               if b[head]["solved"] and not b[base]["solved"]]
        broken = [(p, describe(b[base]), describe(b[head])) for p, _, b in results
                  if (b[head]["wrong"] and not b[base]["wrong"])
                  or (b[head]["model"] == "bad" and b[base]["model"] != "bad")]
        regressed = c[head]["solved"] < c[base]["solved"] or bool(broken)
        if rechecked:
            md += [f"The {rechecked} files that differed were run again one at a time; "
                   "the lists use the second run.", ""]
        lists = [
            ("New wrong answers or failed model checks", broken),
            ("No longer solved", lost),
            ("Newly solved", won),
        ]
        for title, rows in lists:
            md += file_list(title, rows)
        # The comment only counts the files; the lists are in the CI log and
        # the job summary.
        comment += [f"- {title}: {len(rows)}" for title, rows in lists] + [""]

    (out / f"summary-{args.label}.md").write_text("\n".join(md))
    (out / f"comment-{args.label}.md").write_text("\n".join(comment))
    (out / f"result-{args.label}.json").write_text(
        json.dumps({"label": args.label, "regressed": regressed, "counts": c})
    )
    print("\n".join(md))


if __name__ == "__main__":
    main()
