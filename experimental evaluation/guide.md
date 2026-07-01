This document contains a small guide on how to run experiments using GNU `parallel`.
We assume we have only access to a Bash shell (which is often the case when connecting 
remotely to a server), so we will also cover GNU `screen` to detach ourselves from 
the experiments and go on with our lives while they run. 

First, an advise: before starting with the experiments, create a `logfile` to report 
what you are doing (the commands you run, possible changes to the benchmark, etc.)
It will turn out to be helpful, especially to quickly copy-paste commands while in `screen`.

### GNU screen

GNU `screen` is a command that allows you to run multiple separate sessions within a single 
terminal. For us, its most important feature is the ability to detach from a session, 
which leaves it running in the background even after we disconnect from the "main" session.  
In the context of a remote server, this means we can close the connection to the server 
while the experiments are still running, and reconnect only at a later time (hopefully 
to find the results waiting for us).

Here is a small cheat sheet. All these commands are assumed to be typed from outside a 
`screen` session:

- `screen -S session_name` : create a new session 
- `screen -ls` : print all running sessions 
- `screen -X -S session_name -p 0 kill` : kills a session 
- `screen -R session_name` : reattach to a detached session

Once you type `screen -S session_name` (or, later, `screen -R session_name`) you 
will be catapulted in another terminal. You will need however a way to interact 
with your original terminal, for instance to signal that you want to detach from 
the current session. This is how you "control" `screen`. Everything starts with 
by typing the sequence `ctrl+a`. After this, different keys perform different actions.
For instance, `ctrl+a` followed by `?` (in short, `ctrl+a ?`) brings up the help page,  
which contains the default keybindings. 

The only keybinding we really need is `ctrl+a d` which detaches you from the session. 

So, said it more briefly, the workflow when running the experiments will look 
something like this: 

1. `screen -S benchmarking` 
2. start the process that runs the experiments 
3. `ctrl+a d` 
4. go on with your life 
5. `screen -R benchmarking` (optional)
6. check if the experiments have finished (optional) 
7. `ctrl+a d` (optional)
9. `screen -X -S benchmarking -p 0 kill` 
10. do whathever you need with the results of the experiments

### GNU parallel 

GNU `parallel` runs commands... in parallel. To start, and for simplicity, create 
a file `cpu_usage` and write on it a percentage, e.g. `50%`. This file 
will be used to tell `parallel` the percentage of available CPUs it can use to 
run the experiments. If, for instance, you are evaluating a memory-intensive 
tool, setting it to `100%` might saturate the ram, the swap, and the patience 
of the IT team that manages the server. 

You must also create a directory, lest call it `results`, to store 
the results of the computation. After this, using GNU `parallel` is very easy. 
Just write something like: 

`parallel --timeout seconds --jobs ./path-to/cpu-usage --tmpdir ./path-to/results --files "(set -x; command time --format=%e ./path-to/tool path-to/instances/{1}) 2>&1 :::: ./path-to/list-of-instances.txt`

The command is clearly self-explanatory, especially the `::::` part. For you, 
it most likely suffices to know that the command reads the list of instances from `list-of-instances.txt`
and instantiate the command `(set -x; ... {1})` by giving to the variable `{1}` the name of one instance.  
Each of the resulting commands is sent to a distinct CPU, respecting the constraints given in `cpu-usage`. 
The results are stored in `results`. A single instance is killed after `seconds` many seconds, and 
because we use `command time` in the files of the `results` folder you will also see how much time did 
a particular instance take to terminate. 

This command should be called while inside `screen`, so in particular in Step 2 of the previous enumeration.
