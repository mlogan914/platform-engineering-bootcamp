# Linux Disk Space Troubleshooting

## 1. Check Filesystem Usage

View disk utilization:

```bash
df -h
```

Example:

```text
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda3        49G   49G     0 100% /
```

| Column         | Meaning                                    | Your Output           |
| -------------- | ------------------------------------------ | --------------------- |
| **Filesystem** | Disk partition/device                      | `/dev/sda3`           |
| **Size**       | Total capacity                             | `49G`                 |
| **Used**       | Space currently in use                     | `49G`                 |
| **Avail**      | Free space available                       | `0`                   |
| **Use%**       | Percentage of space used                   | `100%`                |
| **Mounted on** | Directory where the filesystem is attached | `/` (root filesystem) |

Focus on:

- `Use%`
- `Avail`
- Mounted filesystem (`/` is usually the root filesystem)

---

## 2. Identify Large Directories

Start at the filesystem root:

```bash
sudo du -xh / --max-depth=1 | sort -h
```

Or inspect a specific directory:

```bash
sudo du -xh /var --max-depth=1 | sort -h
```

Useful locations:

- `/var`
- `/home`
- `/opt`
- `/usr`

---

## 3. Inspect Docker Usage

If Docker is installed:

```bash
docker system df
```

Example:

```text
TYPE            TOTAL     ACTIVE    SIZE      RECLAIMABLE

Images          28        5         12.82GB   12.8GB (99%)
Containers      7         1         43MB
Volumes         ...
```

Look for:

- Large image cache
- Unused containers
- Unused volumes

---

## 4. Clean Up Docker

Remove unused Docker resources:

```bash
docker system prune
```

Or remove everything unused (including images):

```bash
docker system prune -a
```

Example:

```text
Total reclaimed space: 12.86GB
```

---

## 5. Verify Recovery

Run:

```bash
df -h
```

Example:

```text
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda3        49G   34G   13G  74% /
```

Confirm:

- Free space increased
- Filesystem no longer full

---

## Common Commands

Check filesystem usage:

```bash
df -h
```

Find large directories:

```bash
du -xh --max-depth=1
```

Sort largest first:

```bash
sort -h
```

Docker usage:

```bash
docker system df
```

Docker cleanup:

```bash
docker system prune
```

---

## Platform Engineering Troubleshooting Workflow

```text
Disk Full
    │
    ▼
df -h
    │
    ▼
Identify affected filesystem
    │
    ▼
du -xh
    │
    ▼
Find largest directories
    │
    ▼
Investigate application caches
(Docker, logs, temp files)
    │
    ▼
Clean up safely
    │
    ▼
Verify with df -h
```

---

## Lessons Learned

- Always identify **what** is consuming disk space before deleting files.
- Docker images are a common source of disk usage in development environments.
- Verify available space after cleanup.
- Prefer targeted cleanup over deleting files manually.