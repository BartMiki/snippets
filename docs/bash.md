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

### 4) Explore/display CSV/TSV file in bash

Display data separated in columns, use arrows to move around the file. Press `q` to exit

```bash
cat <tsv file> | column -t -s $'\t' | less -S  # For TSV files

cat <csv file> | column -t -s ',' | less -S  # For CSV files
```

Useful for quick validation of the data. You can use `head` to limit number of rows. 
Does not work if the string values contains separator as part of value
for example the literal `"apple, banana, orange"` would be split into three columns as it contains comma (even if quoted).

### 5) Display process that binds to a specific port

Reference: [StackExchange](https://unix.stackexchange.com/a/106562)

```
sudo ss -lptn 'sport = :<port>'
```
### 6) Get directory/file name from a path

Reference: [StackOverflow](https://stackoverflow.com/a/1371283/12396982)

```
dirname=$(pwd)              # Assign current directory to variable dirname
shopt -s extglob            # enable +(...) glob syntax
dirname=${dirname%%+(/)}    # trim however many trailing slashes exist
dirname=${dirname##*/}      # remove everything before the last / that still remains
echo "$dirname"
```

### 7) Execute bash inside the Docker container

```
docker exec -it <container-id / name> bash
```
