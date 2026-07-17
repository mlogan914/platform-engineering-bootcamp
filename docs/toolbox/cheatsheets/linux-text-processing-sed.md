# Linux Text Processing using `sed` Cheat Sheet

`sed` (Stream Editor) is used to search, replace, insert, delete, and modify text without opening a text editor.

---

# Basic Syntax

```bash
sed 'command' file
```

---

# Common Options

| Option | Description |
|---------|-------------|
| `-i` | Edit the file in place |
| `-n` | Suppress automatic output |
| `-e` | Execute multiple commands |
| `-f` | Read commands from a file |

---

# Search & Replace

Replace the **first** occurrence on each line:

```bash
sed 's/old/new/' file.txt
```

---

Replace **all** occurrences on each line:

```bash
sed 's/old/new/g' file.txt
```

---

Edit the file in place:

```bash
sed -i 's/old/new/g' file.txt
```

---

Create a backup before editing:

```bash
sed -i.bak 's/old/new/g' file.txt
```

Produces:

```text
file.txt
file.txt.bak
```

---

# Replace Specific Text

Replace:

```text
environment: dev
```

with

```text
environment: production
```

```bash
sed -i 's/environment: dev/environment: production/' config.yml
```

---

Replace a bucket name:

```bash
sed -i 's/temp-bucket/platform-data-prod/' config.yml
```
---
# Replace and Create a New File
```bash
sed \
    -e 's/environment: dev/environment: production/' \
    -e 's/log_level: DEBUG/log_level: INFO/' \
    -e 's/debug: true/debug: false/' \
    -e 's/log_level: DEBUG/log_level: INFO/'\
    -e 's/database: old-db/database: platform-db/' \
    config.yml > config-prod.yml
```

# Replace in Multiple Files
```bash
sed -i 's/log_level: DEBUG/log_level: INFO/' \
    config-dev.yml \
    config-test.yml \
    config-prod.yml
```
---

# Print Specific Lines

Print line 5:

```bash
sed -n '5p' file.txt
```

Print lines 5–10:

```bash
sed -n '5,10p' file.txt
```

---

# Delete Lines

Delete line 3:

```bash
sed '3d' file.txt
```

Delete blank lines:

```bash
sed '/^$/d' file.txt
```

---

# Insert Text

Insert before line 5:

```bash
sed '5i\
New Line
' file.txt
```

---

Append after line 5:

```bash
sed '5a\
New Line
' file.txt
```

---

# Replace Multiple Files

```bash
sed -i 's/DEBUG/INFO/g' *.yml
```
---

# Common Regular Expressions

| Pattern | Meaning |
|---------|---------|
| `.` | Any character |
| `*` | Zero or more |
| `.*` | Any number of characters |
| `^` | Beginning of line |
| `$` | End of line |
| `[0-9]` | Any digit |
| `[A-Z]` | Uppercase letter |

Example:

```bash
sed 's/^/# /' notes.txt
```

Adds `# ` to the beginning of every line.

---

# Verify Changes

Display the file:

```bash
cat file.txt
```

Search for the updated value:

```bash
grep "production" config.yml
```

Compare files:

```bash
diff config.yml config-prod.yml
```

---

# Platform Engineering Examples

Update environment:

```bash
sed -i 's/dev/prod/' config.yml
```

Disable debugging:

```bash
sed -i 's/debug: true/debug: false/' config.yml
```

Update image tag:

```bash
sed -i 's/v1.0/v1.1/' deployment.yaml
```

Change log level:

```bash
sed -i 's/DEBUG/INFO/g' *.yml
```

---

# Tips

- Always test without `-i` first.
- Use `-i.bak` when editing important files.
- `sed` uses regular expressions for pattern matching.
- Pair `find`, `grep`, and `sed` for powerful automation workflows.

---

# Common Mistakes

❌ Forgetting `-i`

The file is **not** modified.

```bash
sed 's/dev/prod/' config.yml
```

---

❌ Forgetting the `g` flag

Only the first match on each line is replaced.

```bash
sed 's/DEBUG/INFO/'
```

---

❌ Editing the wrong file

Verify with:

```bash
pwd
ls
```

before using `-i`.

---

# Remember

- `grep` → **Find** text
- `sed` → **Modify** text
- `awk` → **Process** text