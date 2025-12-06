
### Generate and run LoAT benchmarks

Timeouts and opponents are hardcoded in Makefile

```
make make_bench_scripts

bash bench_PURRS.sh | tee PURRS.output
bash bench_Termination.sh | tee Termination.output
bash bench_LIA_Lin.sh | tee LIA_Lin.output
bash bench_Complexity.sh | tee complexity.output
```

### Generate and run chrobelias benchmarks

```
make gen-chrobelias

bash bench-chrobelias-str-ln.sh | tee Chro_str_ln.output
bash bench-chrobelias-str-reln.sh | tee Chro_str_REln.output
bash bench-chrobelias-str-reln-huge.sh | tee Chro_str_RElnHuge.output
bash bench-chrobelias-str-reln-very-huge.sh | tee Chro_str_RElnVeryHuge.output
```

Use `killall bash` in separate terminal to interrupt

Use `grep -e CHRO -e SWINE complexity.output` to see results in LaTeX format