# ==============================
# Assignment - Processes
# ==============================

# ==============================
# Exercise 1 – Inspect Running Processes
# ==============================
"
Objective

Find information about running processes.

Tasks
1. Display every running process.
2. Display only processes for your current user.
3. Find the PID of your current shell (bash or zsh).
4. Find the PID of the VS Code server (if running); otherwise, find bash.
"

# 1. Display every running process.
ps -ef

# 2. Display only processes for your current user.
ps -u mlogan

# 3. Find the PID of your current shell (bash or zsh).
ps
"
PID TTY          TIME CMD
32460 pts/4    00:00:00 bash
32556 pts/4    00:00:00 ps
"

# Find the PID of the VS Code server (if running).

ps -ef | grep "vscode-server"

ps -ef | grep 'bash'

"

mlogan      2842    2752  0 Jul23 pts/0    00:00:00 bash
"

# ==============================
# Exercise 2 – Monitor the System
# ==============================
"
Objective

Observe processes in real time.

Tasks
1. Launch top.
2. Identify:
- CPU usage
- Memory usage
- Highest CPU process
3. Quit top.
4. If installed, compare with htop.
"
# -p (Monitor a Specific Process by PID)
top -p 2655


# -b (Batch Mode for Logging or Scripts)

```bash
top -b
```

# -1 (Show CPU Usage Per Core)
top -1

# k (Kill a Process)

"
The k key in the interactive top interface allows terminating a running process by specifying its PID.

Steps:

- Press k while top is running
- Enter the PID of the process to terminate
- Press Enter to confirm
"
# 1. Launch top.
top

"
Tasks: 291 total,   1 running, 290 sleeping,   0 stopped,   0 zombie
%Cpu(s):  1.6 us,  0.8 sy,  0.0 ni, 96.9 id,  0.0 wa,  0.0 hi,  0.8 si,  0.0 st
MiB Mem :   3916.7 total,    387.5 free,   1570.0 used,   1959.2 buff/cache
MiB Swap:   2048.0 total,   1945.5 free,    102.5 used.   2019.3 avail Mem 

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND                                 
   3146 mlogan    20   0 1724212 154308  53272 S   0.7   3.8   1:08.05 MainThread                              
  32359 mlogan    20   0   17588   8452   5808 S   0.7   0.2   0:05.57 sshd                                    
     16 root      20   0       0      0      0 S   0.3   0.0   0:08.97 ksoftirqd/0                             
   2655 mlogan    20   0  153544   3132   2624 S   0.3   0.1   2:38.39 VBoxClient                              
   3223 mlogan    20   0 1692256  86520  49308 S   0.3   2.2  60:34.02 MainThread         
...

"
# 3. Quit top.
q

# 4. If installed, compare with htop (more visually appealing).
htop

# ==============================
# Exercise 3 – Background Jobs
# ==============================

# Start a command that runs for a while.
sleep 300

# Suspend it
"Ctrl + z"

# View your jobs.
jobs

"
[1]   Stopped                 top -b
[2]-  Stopped                 sleep 300
[3]+  Stopped                 sleep 300
"
# Resume it in the background.
sleep 300

bg %2

# Bring it back to the foreground.
fg %2

# Stop it.
"Ctrl + z"

# ==============================
# Exercise 4 – Kill a Process
# ==============================
"
Objective

Terminate a running process.

Tasks
1. Start:
sleep 300
2. Find its PID.
3. Terminate it using its PID.
4. Verify it is no longer running.
"
# Start a process in the background
sleep 300 &

"
[8] 39841
"

# Find its PID.
jobs -l

"
[8]   39841 Running                 sleep 300 &
"

# Terminate it using its PID.
kill 39841

"
[8]   Terminated              sleep 300
"
# Verify it is no longer running.

# kill by job number (examples)
kill %8
fg %8
bg %8

# ==============================
# Exercise 5 – Process Priority
# ==============================

"
Objective

Start a low-priority process.

nice is a Linux command that starts a process with a specified niceness value, 
which influences the process's CPU scheduling priority.

- A lower niceness → higher priority (the process gets more CPU time).
- A higher niceness → lower priority (the process is "nicer" to other processes 
and gives them more CPU time).

Niceness range:
-20   Highest priority
  0   Default priority
 19   Lowest priority
> Only the root user can assign negative niceness values (increase priority).

Tasks
1. Start:
nice -n 10 sleep 300
2. View it with ps.
3. Observe the NI (nice) column.
"
# Start a low-priority process.
nice -n 10 sleep 300 &

# View it with ps
ps -o pid,ni,comm -p 41233

"
PID  NI COMMAND
41233  10 sleep
"