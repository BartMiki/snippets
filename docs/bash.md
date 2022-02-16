# Bash snippets

Useful bash commands for different use cases. I highly recommend [Explain Shell](https://explainshell.com/) for explenation of the commands

### 1) Start the process as a daemon and redirect stdout and stderr to a file

```bash
# Default
nohup <command> > logs.out 2>&1 &

# More compact method
nohup <command> &> logs.out &
```

You can use either: `<cmd> > <file> 2>&1` or `<cmd> &> <file>` as in bash they are equivalent. 
Useful for executing long running commands over SSH on remote machines.


### 2) Start the process as a daemon and return the process PID

```bash
nohup <command> &
PID=$!
echo $PID
```

Useful if you want to track the status of a given process or to kill it later.

### 3) List or kill all processes matching a pattern

```bash
pgrep -f <command>  # List a PIDs of processes that maches <command>
pgrep -fa <command>  # List PIDs and commands of processes that maches <command>

pkill -f <command>  # Send SIGTERM to all processes matching <command>
```

The option `-f` is useful as you match entire command (program and it's arguments) that was executed.
Use `pgrep` before `pkill` to check what processes you will terminate (like using `ls` before `rm`).