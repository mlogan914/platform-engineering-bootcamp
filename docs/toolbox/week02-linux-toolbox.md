# Linux Toolbox (Week 2)

A quick-reference guide for common Linux concepts and commands.

---
<details>
<summary><strong>Day 1 – Filesystem & Navigation</strong></summary>

<details>
<summary><strong>Linux File Hierarchy</strong></summary>

```mermaid
flowchart LR

    ROOT["Linux Root (/)"]

    ROOT --> SYSTEM["System"]
    ROOT --> USERS["Users"]
    ROOT --> STORAGE["Storage"]
    ROOT --> RUNTIME["Kernel & Runtime"]

    SYSTEM --> BIN["/bin<br/>Essential commands"]
    SYSTEM --> SBIN["/sbin<br/>System binaries"]
    SYSTEM --> ETC["/etc<br/>Configuration"]
    SYSTEM --> LIB["/lib<br/>Shared libraries"]
    SYSTEM --> BOOT["/boot<br/>Boot files"]
    SYSTEM --> OPT["/opt<br/>Optional software"]
    SYSTEM --> USR["/usr<br/>Applications"]

    USERS --> HOME["/home<br/>User directories"]

    STORAGE --> MEDIA["/media<br/>Removable media"]
    STORAGE --> MNT["/mnt<br/>Temporary mounts"]
    STORAGE --> TMP["/tmp<br/>Temporary files"]

    RUNTIME --> DEV["/dev<br/>Devices"]
    RUNTIME --> PROC["/proc<br/>Process information"]
    RUNTIME --> SRV["/srv<br/>Service data"]
```

---

## Common Directories

| Directory | Purpose |
|-----------|---------|
| `/` | Root of the Linux filesystem |
| `/bin` | Essential user commands |
| `/boot` | Boot loader files |
| `/dev` | Device files |
| `/etc` | System configuration |
| `/home` | User home directories |
| `/lib` | Shared libraries |
| `/media` | Removable media |
| `/mnt` | Temporary mount points |
| `/opt` | Optional software |
| `/proc` | Process and kernel information |
| `/sbin` | System administration commands |
| `/srv` | Service data |
| `/tmp` | Temporary files |
| `/usr` | User applications and utilities |

---
</details>

<details>
<summary><strong>Absolute vs Relative Paths</strong></summary>

## Absolute Path

**Definition**

Starts at the root directory (`/`) and always points to the same location.

**Example**

```bash
cat /home/user/projects/linux/notes.txt
```

**Use When**

- Shell scripts
- Cron jobs
- System configuration
- Accuracy is critical

---

## Relative Path

**Definition**

Starts from the current working directory.

**Example**

Current directory:

```bash
/home/user
```

Command:

```bash
cd projects/linux
```

Moves to:

```bash
/home/user/projects/linux
```

---

## Special Path Symbols

| Symbol | Meaning |
|--------|---------|
| `.` | Current directory |
| `..` | Parent directory |
| `~` | Current user's home directory |

**Examples**

```bash
./script.sh
```

```bash
cd ../../backup
```

```bash
cd ~
```

```bash
~/platform_practice
```

---

## When to Use

### Absolute Paths

✅ Best for:

- Shell scripts
- Cron jobs
- System services
- Configuration files

### Relative Paths

✅ Best for:

- Interactive terminal use
- Project navigation
- Quick file operations

---

## Common Mistakes

- Forgetting your current working directory
- Using relative paths inside automation scripts
- Mixing Windows (`\`) and Linux (`/`) path separators
- Forgetting that `~` only represents the current user's home directory

---

## Quick Tips

- Use `pwd` to display your current directory.
- Use `~` instead of typing your full home directory.
- Prefer absolute paths in automation.
- Prefer relative paths while navigating projects.

---
</details>

<details>
<summary><strong>Linux Tips & Shortcuts</strong></summary>

<details>
<summary><strong>Getting Help</strong></summary>

### Manual Pages

Displays the complete documentation for a command.

```bash
man <command>
```

Example:

```bash
man find
```

---

### Quick Help

Displays the available options for a command.

```bash
<command> --help
```

Example:

```bash
find --help
```

---

### TLDR

Provides short, practical examples for common commands.

```bash
tldr <command>
```

Example:

```bash
tldr find
```

Install:

```bash
sudo apt install tldr
```

---
</details>

<details>
<summary><strong>Wildcards</strong></summary>

| Wildcard | Meaning |
|----------|---------|
| `*` | Matches everything |
| `?` | Matches a single character |
| `*.log` | Every `.log` file |
| `*.txt` | Every `.txt` file |

Example:

```bash
mv *.log archive/
```

---
</details>

<details>
<summary><strong>Brace Expansion</strong></summary>

Create multiple directories:

```bash
mkdir -p project/{configs,scripts,logs,data,archive}
```

Create multiple files:

```bash
touch {app,upload,error,debug}.log
```

Numbered files:

```bash
touch server{1..5}.log
```

Works with:

- mkdir
- touch
- cp
- mv
- rm

---
</details>

<details>
<summary><strong>Directory Shortcuts</strong></summary>

| Symbol | Meaning |
|---------|---------|
| `.` | Current directory |
| `..` | Parent directory |
| `~` | Home directory |

Examples:

```bash
cd ..
```

```bash
cd ~
```

```bash
./script.sh
```

---
</details>

<details>
<summary><strong>Copying Files</strong></summary>

Copy a file:

```bash
cp file.txt backup/
```

Copy a directory:

```bash
cp -r project backup/
```

Copy a directory while preserving permissions and timestamps:

```bash
cp -a project backup/
```

Copy only the contents of a directory:

```bash
cp -a source/. destination/
```

---
</details>

<details>
<summary><strong>Moving Files</strong></summary>

Move one file:

```bash
mv file.txt archive/
```

Move multiple files:

```bash
mv *.log archive/
```

Rename a file:

```bash
mv old.txt new.txt
```

---
</details>

<details>
<summary><strong>Creating Files</strong></summary>

Create an empty file:

```bash
touch notes.txt
```

Create multiple files:

```bash
touch {dev,test,prod}.yaml
```

---
</details>

<details>
<summary><strong>Finding Files</strong></summary>

Find every log file:

```bash
find . -name "*.log"
```

Find directories only:

```bash
find . -type d
```

Find files only:

```bash
find . -type f
```

Search from the current directory:

```bash
find .
```

---
</details>

<details>
<summary><strong>Disk Usage</strong></summary>

Show directory sizes:

```bash
du -sh *
```

Largest first:

```bash
du -sh * | sort -hr
```

Smallest first:

```bash
du -sh * | sort -h
```

Check filesystem usage:

```bash
df -h
```

Remember:

- **df** = Disk Free (filesystem usage)
- **du** = Disk Usage (directory/file usage)

---
</details>

<details>
<summary><strong>Verify Your Work</strong></summary>

Common verification commands:

```bash
pwd
```

Current directory.

```bash
ls
```

List files.

```bash
ls -l
```

Detailed listing.

```bash
tree
```

Display directory structure.

---
</details>

<details>
<summary><strong>Common Mistakes</strong></summary>

### `*` expands before the command runs.

Example:

```bash
cp -r * backup/
```

If `backup` is inside the current directory, you'll try to copy `backup` into itself.

---

Use quotes when variables or filenames may contain spaces.

```bash
cp "$file" backup/
```

---

Prefer absolute paths in scripts.

Prefer relative paths while navigating manually.

---

Always verify your results after moving or copying files.

Useful commands:

```bash
tree
ls
pwd
```

---
</details>

# My Workflow

When I don't know a command:

1. Try it.
2. Read `--help`.
3. Check `tldr`.
4. Read the `man` page if needed.
5. Add anything useful to this toolbox.

</details>
</details>

<details>
<summary><strong>Day 2: Linux Permissions</strong></summary>

# File Permission Types

| Permission | Symbol | Value | Meaning |
|------------|--------|------:|---------|
| Read | `r` | 4 | View file contents or list directory contents |
| Write | `w` | 2 | Modify a file or create/delete files in a directory |
| Execute | `x` | 1 | Execute a file or traverse a directory |

Permissions are assigned to three categories:

| Category | Meaning |
|----------|---------|
| User (u) | File owner |
| Group (g) | Users belonging to the file's group |
| Others (o) | Everyone else |

---

# Reading Permissions

Example:

```text
-rwxr-x---
```

Break it into groups of three:

```text
- rwx r-x ---
  │   │   │
  │   │   └── Others
  │   └────── Group
  └────────── Owner
```

Meaning:

| Category | Permissions |
|----------|-------------|
| Owner | Read, Write, Execute |
| Group | Read, Execute |
| Others | No permissions |

---

# Octal Permissions

| Number | Binary | Permission |
|--------:|--------|------------|
| 0 | --- | No permissions |
| 1 | --x | Execute |
| 2 | -w- | Write |
| 3 | -wx | Write + Execute |
| 4 | r-- | Read |
| 5 | r-x | Read + Execute |
| 6 | rw- | Read + Write |
| 7 | rwx | Read + Write + Execute |

Examples:

| Permission | Octal |
|------------|:-----:|
| `rw-------` | `600` |
| `rwx------` | `700` |
| `rw-r--r--` | `644` |
| `rwxr-xr-x` | `755` |
| `rwxrwx---` | `770` |

---

<details>
<summary><strong>chmod</strong></summary>

Change file or directory permissions.

## Syntax

```bash
chmod [permissions] file
```

## Numeric Examples

```bash
chmod 600 config/app.conf
chmod 644 config.yml
chmod 700 deploy.sh
chmod 755 install.sh
chmod 770 shared
```

## Symbolic Examples

```bash
chmod +x deploy.sh
chmod u+x deploy.sh
chmod g+w shared
chmod o-r secret.txt
chmod a+r file.txt
```

---

# Common Permissions

## 600

```text
-rw-------
```

Use for:

- Configuration files
- API keys
- Database credentials
- SSH private keys
- Secrets

Owner can:

- Read
- Write

No one else has access.

---

## 644

```text
-rw-r--r--
```

Use for:

- Source code
- Documentation
- Public configuration files

Everyone can read.

Only the owner can modify.

---

## 700

```text
-rwx------
```

Use for:

- Private scripts
- Personal directories

Owner can execute.

No one else has access.

---

## 755

```text
-rwxr-xr-x
```

Use for:

- Executable programs
- Shell scripts
- Utilities

Everyone can execute.

Only owner can modify.

---

## 770

```text
drwxrwx---
```

Use for:

- Shared engineering directories
- Team project folders
- Deployment directories

Owner and group have full access.

Others have none.

</details>

---

# Directories vs Files

Execute permission behaves differently for directories.

## Files

Execute means:

> Run the file as a program.

Example:

```bash
./deploy.sh
```

---

## Directories

Execute means:

> Traverse (enter) the directory.

Without execute permission:

- Cannot `cd` into the directory
- Cannot access files inside it

Even if read permission exists.

---

<details>
<summary><strong>chown</strong></summary>

Change file ownership.

## Syntax

```bash
sudo chown owner file
```

Examples:

```bash
sudo chown root app.log
sudo chown mlogan app.log
```

Change owner and group simultaneously:

```bash
sudo chown mlogan:docker shared
```

## Notes

Changing ownership generally requires:

```bash
sudo
```

Only the root user can transfer ownership.

</details>

---

<details>
<summary><strong>chgrp</strong></summary>

Change a file or directory group.

## Syntax

```bash
sudo chgrp group_name directory
```

Example:

```bash
sudo chgrp docker shared
```

Verify:

```bash
ls -ld shared
```

</details>

---

<details>
<summary><strong>groups</strong></summary>

Display the groups the current user belongs to.

```bash
groups
```

Example:

```text
mlogan adm sudo docker
```

Useful when determining whether a user should already have access to a shared resource.

</details>

---

<details>
<summary><strong>ls -ld</strong></summary>

Display information about the directory itself.

```bash
ls -ld shared
```

Example:

```text
drwxrwx--- 2 mlogan docker ...
```

Without `-d`:

```bash
ls -l shared
```

Displays the **contents** of the directory instead.

</details>

---

# Principle of Least Privilege

Only grant the permissions that are required.

Examples:

✅ Configuration file

```bash
chmod 600 app.conf
```

❌

```bash
chmod 700 app.conf
```

While `700` technically works, execute permission is unnecessary because configuration files are **data**, not programs.

---

# Troubleshooting Permission Issues

Check permissions:

```bash
ls -l file
```

Check directory permissions:

```bash
ls -ld directory
```

Check owner and group:

```bash
ls -l
```

Check current user:

```bash
whoami
```

Check current user's groups:

```bash
groups
```

</details>