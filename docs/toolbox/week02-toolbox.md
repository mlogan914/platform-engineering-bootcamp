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