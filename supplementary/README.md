# Supplementary Material for Submission #360

This folder contains the supplementary material for Submission #360. It is organized as follows:
- `paper-with-appendices.pdf` : A version of the paper containing appendices with proofs.
- `parsym` : A Linux x86-64 executable version of the tool described in Section 5.3 of the paper.
- `experiments` : The experiments described in Section 5.3 of the paper. 

The folders `experiments` comes with its own `README.md` file.


## Running the tool

First look at the options available, running 

`./parsym --help` 

Several options will appear, depending on what type of problem you want to solve. 
For instance, to solve a Bounded Existence problem, in `par` mode, as described in Section 5 of the paper, run: 

`./<tool> -bmin a -bmin b -par -problem e instance.smt2` 

where `[a..b]` is the range of bases you wish to check, `-par` states the mode (avoid this option to call the tool in `sym` mode), 
and `-problem e` specifies that `instance.smt2` is an instance of an existence problem (for Bounded universality problems: `-problem u`). 

