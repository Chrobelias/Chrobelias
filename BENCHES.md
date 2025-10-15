
### Generate and run some benchmarks

Timeouts are hardcoded in Makefile

```
make make_bench_scripts

bash bench_PURRS.sh | tee PURRS.output
bash bench_Termination.sh | tee Termination.output
bash bench_LIA_Lin.sh | tee LIA_Lin.output
bash bench_Complexity.sh | tee complexity.output
```

Use `killall bash` in separate terminal to interrupt

Use `grep -e CHRO -e SWINE complexity.output` to see results in LaTeX format