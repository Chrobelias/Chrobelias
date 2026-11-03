# Reference run of Chrobelias 1.2.3

Chrobelias 1.2.3 (`release/chro`, sha256 3eda39f7…) with `-q` on all benchmark
sets, on the paper's machine (Intel Core i7-6700) with the paper's settings
(60 s, one core, 8 GB per run), 26–27 Oct 2026; see `environment.txt`.
StrRElnc was run in the layout split by the number of variables
(`REln-1/long`, ...), as in the paper's tables. One line per instance:
label, suite, file, verdict, stage, wall time (s), CPU time (s), memory (KB),
exit code. Summaries: `python3 scripts/stages_table.py reference-1.2.3` and
`python3 scripts/make_tables.py tables reference-1.2.3`.
