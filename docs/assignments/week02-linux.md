
# Week 2 – Linux for Platform Engineers

## Objective

Become comfortable administering and troubleshooting Linux systems used by platform engineering teams.

This week focuses on solving realistic engineering problems commonly encountered by Platform Engineers.

---

<details>
<summary><strong>Day 1 – Filesystem & Navigation</strong></summary>

## Learning Objectives

- Understand the Linux filesystem hierarchy
- Navigate efficiently using the command line
- Create, move, copy, and remove files and directories
- Locate files and analyze disk usage

---

## Topics

- Filesystem hierarchy
- Absolute vs relative paths
- `pwd`
- `ls`
- `cd`
- `mkdir`
- `cp`
- `mv`
- `rm`
- `find`
- `locate`
- `tree`
- `du`
- `df`

---

## Platform Engineering Perspective

Platform engineers constantly work with configuration files, deployment scripts, logs, and infrastructure code.

Understanding where files live and how to efficiently navigate a Linux system is one of the most frequently used skills in engineering.

---

## Exercises

## Progress
- [x] Exercise 1
- [x] Exercise 2
- [x] Exercise 3
- [x] Exercise 4
- [x] Exercise 5
- [ ] Bonus Exercise 6

### Exercise 1

Create the following directory structure completely from the command line.

```text
project/
├── configs/
├── scripts/
├── logs/
├── data/
└── archive/
```

---

### Exercise 2

Copy configuration files into multiple environment folders.

---

### Exercise 3

Move completed log files into an archive directory.

---

### Exercise 4

Find every `.log` file underneath the project directory.

---

### Exercise 5

Determine which directory is consuming the most disk space.

---

## Assignment

A sequencing server has become cluttered.

Organize the filesystem into a clean project structure while preserving all data.

## Bonus Exercise – grep

### Scenario

You have an application log called `app.log`.

```text
2026-07-14 08:15:22 INFO Application started
2026-07-14 08:15:25 INFO User logged in
2026-07-14 08:16:01 WARNING Low disk space
2026-07-14 08:16:45 ERROR Failed to connect to database
2026-07-14 08:17:02 INFO Retrying connection
2026-07-14 08:17:05 ERROR Connection timeout
2026-07-14 08:18:10 INFO Upload complete
```

### Tasks

1. Display every line containing `ERROR`.

2. Display every line containing either `ERROR` or `WARNING`.

3. Count how many `INFO` messages exist.

4. Show line numbers for every `ERROR`.

5. Search for `error` regardless of capitalization.

6. Display every line that **does not** contain `INFO`.

7. Save all `ERROR` messages to a new file named `errors.log`.

---

<details>
<summary><strong>Solutions</strong></summary>

```bash
grep "ERROR" app.log

grep -E "ERROR|WARNING" app.log

grep -c "INFO" app.log

grep -n "ERROR" app.log

grep -i "error" app.log

grep -v "INFO" app.log

grep "ERROR" app.log > errors.log
```

### Challenge

Using only one command, display all `ERROR` or `WARNING` messages **with line numbers**.

<details>
<summary>Answer</summary>

```bash
grep -En "ERROR|WARNING" app.log
```

</details>

</details>
</details>

---

<details>
<summary><strong> Day 2 – Linux Permissions</strong></summary>

## Learning Objectives

- Understand Linux permissions
- Manage ownership
- Secure application files
- Troubleshoot permission problems

---

## Topics

- `chmod`
- `chown`
- `chgrp`
- rwx permissions
- Octal permissions
- Symbolic permissions
- `umask`

---

## Platform Engineering Perspective

Incorrect permissions are one of the most common causes of deployment failures.

Platform engineers constantly troubleshoot:

- SSH permission errors
- Configuration access issues
- Script execution failures
- Shared storage permissions

---

## Exercises

### Exercise 1

Make deployment scripts executable.

---

### Exercise 2

Protect reports from accidental modification.

---

### Exercise 3

Share a directory with another engineering team.

---

### Exercise 4

Secure application configuration files.

---

## Assignment

A bioinformatics team cannot access sequencing data.

Determine why and repair the permissions.

</details>

---
<details>
<summary><strong> Day 3 – Users, Groups & SSH</strong></summary>

## Learning Objectives

- Understand Linux users
- Manage groups
- Configure SSH access
- Transfer files securely

---

## Topics

- users
- groups
- sudo
- id
- whoami
- passwd
- ssh
- ssh-keygen
- scp
- rsync

---

## Platform Engineering Perspective

Most platform engineers spend a significant amount of time:

- Connecting to remote Linux servers
- Managing SSH keys
- Creating user accounts
- Configuring access permissions

---

## Exercises

### Exercise 1

Generate SSH keys.

---

### Exercise 2

Configure passwordless SSH authentication.

---

### Exercise 3

Transfer files between servers.

---

### Exercise 4

Determine which user owns running processes.

---

## Assignment

Provision a new engineer.

Configure:

- user account
- SSH access
- proper group membership
- shared project access

</details>

---
<details>
<summary><strong> Day 4 – Processes & Networking</strong></summary>

## Learning Objectives

- Monitor running processes
- Manage background jobs
- Diagnose networking problems

---

## Topics

### Processes

- `ps`
- `top`
- `htop`
- `jobs`
- `bg`
- `fg`
- `kill`
- `killall`
- `nice`

### Networking

- `ping`
- `curl`
- `wget`
- `netstat`
- `ss`
- `ip`
- `hostname`
- `dig`
- `nslookup`

---

## Platform Engineering Perspective

When applications stop responding, platform engineers need to quickly determine whether the problem is:

- application
- network
- DNS
- server resources

---

## Exercises

### Exercise 1

Kill a runaway process.

---

### Exercise 2

Download software using the command line.

---

### Exercise 3

Determine which process owns a network port.

---

### Exercise 4

Verify internet connectivity.

---

### Exercise 5

Investigate DNS failures.

---

## Assignment

A sequencing pipeline has stopped responding.

Determine whether the problem is:

- Process
- Network
- DNS
- Permissions

Repair the issue.

</details>

---

<details>
<summary><strong> Day 5 – Logs & Troubleshooting</strong></summary>

## Learning Objectives

- Read application logs
- Search large log files
- Filter useful information
- Perform basic Linux troubleshooting

---

## Topics

- `cat`
- `less`
- `head`
- `tail`
- `tail -f`
- `grep`
- `wc`
- `cut`
- `awk`
- `sed`
- `journalctl`

---

## Platform Engineering Perspective

Logs are often the first place engineers investigate when:

- CI/CD pipelines fail
- Containers crash
- Infrastructure deployments fail
- Applications become unavailable

Learning to efficiently search logs is a critical engineering skill.

---

## Exercises

### Exercise 1

Follow a live log file.

---

### Exercise 2

Search for application errors.

---

### Exercise 3

Count failed requests.

---

### Exercise 4

Extract timestamps from log files.

---

### Exercise 5

Filter warning messages.

</details>

---
<details>
<summary><strong> Week 2 Final Project</strong></summary>

## Scenario

A sequencing upload pipeline has stopped working.

You have been asked to diagnose the Linux server.

The server contains:

```text
server/
├── configs/
├── logs/
├── uploads/
├── scripts/
└── users/
```

---

## Your Tasks

Determine:

- Why uploads stopped
- Whether disk space has been exhausted
- Whether permissions are incorrect
- Whether configuration is missing
- Whether a process crashed
- Whether networking failed
- Whether the correct user owns the files

Repair every issue.

Produce a troubleshooting report describing:

- Problems discovered
- Commands used
- Repairs performed
- Final system status

---

# Week 2 Toolbox

Continue building your personal Platform Engineering Toolbox.

Create:

```
docs/week02-linux-toolbox.md
```

For every command include:

- Purpose
- Syntax
- Common options
- Real-world examples
- Troubleshooting notes

By the end of Week 2 you should have a Linux reference guide that you can use throughout the remainder of the bootcamp.

</details>