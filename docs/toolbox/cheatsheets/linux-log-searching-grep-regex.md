# Linux Log Searching & Regular Expressions Cheat Sheet

Quick reference guide for Linux log searching, grep, and regular expressions.

---

# 1. Which Tool Should I Use?

| Goal | Command |
|------|----------|
| Find a file | `find` |
| Search inside a file | `grep` |
| View beginning of file | `head` |
| View end of file | `tail` |
| Follow a live log | `tail -f` |
| Search compressed logs | `zgrep` |
| Count matches | `grep -c` |
| Recursive search | `grep -r` |
| Show line numbers | `grep -n` |
| Show filenames containing matches | `grep -l` |

---

# 2. grep Options

| Option | Meaning | Example |
|---------|---------|---------|
| `-E` | **Extended Regular Expressions (ERE)**. Enables `|`, `+`, `?`, `()` without escaping. | `grep -E "ERROR|WARNING"` |
| `-P` | **Perl Compatible Regular Expressions (PCRE)**. Supports advanced regex features like `\d`, `\w`, lookaheads, lookbehinds, etc. | `grep -P "\d+"` |
| `-i` | Ignore case | `grep -i error app.log` |
| `-v` | Invert match (exclude matches) | `grep -v INFO app.log` |
| `-n` | Show line numbers | `grep -n ERROR app.log` |
| `-c` | Count matching lines | `grep -c ERROR app.log` |
| `-r` | Recursive search through directories | `grep -r ERROR logs/` |
| `-l` | Show filenames only | `grep -rl ERROR .` |
| `-A N` | Show **N** lines after the match | `grep -A 5 ERROR app.log` |
| `-B N` | Show **N** lines before the match | `grep -B 5 ERROR app.log` |
| `-C N` | Show **N** lines before and after | `grep -C 5 ERROR app.log` |
| `-o` | Print only the matching text | `grep -o "[0-9]\+" app.log` |
| `-w` | Match whole words only | `grep -w ERROR app.log` |

---

# 3. Regex Flavors

| Flavor | Used By | Notes |
|---------|---------|------|
| **BRE** | `grep` | Basic Regular Expressions (default) |
| **ERE** | `grep -E` | Easier syntax (`|`, `+`, `?`, `()`) |
| **PCRE** | `grep -P` | Perl-compatible regex with advanced features |

---

# 4. Regex Operators

| Pattern | Meaning | Example |
|---------|---------|---------|
| `.` | Any single character | `a.c` |
| `*` | Zero or more of previous character | `ab*c` |
| `.*` | Zero or more of **any** character | `ERROR.*database` |
| `+` | One or more (`grep -E`) | `[0-9]+` |
| `?` | Zero or one (`grep -E`) | `colou?r` |
| `^` | Beginning of line | `^ERROR` |
| `$` | End of line | `ERROR$` |
| `[]` | Character class | `[0-9]` |
| `[^]` | Negated character class | `[^0-9]` |
| `|` | OR (`grep -E`) | `ERROR|WARNING` |
| `()` | Group (`grep -E`) | `(ERROR|WARN)` |

---

# 5. Character Classes

| Pattern | Matches |
|---------|---------|
| `[0-9]` | Digit |
| `[a-z]` | Lowercase letter |
| `[A-Z]` | Uppercase letter |
| `[A-Za-z]` | Any letter |
| `[A-Za-z0-9]` | Letter or digit |
| `[^0-9]` | Anything except digits |

---

# 6. Common Regex Patterns

| Pattern | Meaning |
|---------|---------|
| `ERROR` | Contains ERROR |
| `^ERROR` | Starts with ERROR |
| `ERROR$` | Ends with ERROR |
| `ERROR.*database` | ERROR followed later by database |
| `ERROR|WARNING` | ERROR or WARNING |
| `[0-9]+` | One or more digits |
| `[A-Za-z]+` | One or more letters |

---

# 7. Common Log Searches

## Find all ERROR messages

```bash
grep ERROR app.log
```

## Find ERROR or WARNING

```bash
grep -E "ERROR|WARNING" app.log
```

## Ignore case

```bash
grep -i error app.log
```

## Count ERROR messages

```bash
grep -c ERROR app.log
```

## Show line numbers

```bash
grep -n ERROR app.log
```

## Show context around matches

```bash
grep -C 5 ERROR app.log
```

## Exclude INFO messages

```bash
grep -v INFO app.log
```

## Search every log recursively

```bash
grep -r ERROR logs/
```

## Show filenames containing matches

```bash
grep -rl ERROR .
```

## Follow a live log

```bash
tail -f app.log
```

## Follow a live log and filter for ERROR

```bash
tail -f app.log | grep ERROR
```

---

# 8. Combining find + grep

Search every `.log` file for ERROR

```bash
find . -name "*.log" | xargs grep ERROR
```

Search recursively without find

```bash
grep -r ERROR .
```

Find all Python files

```bash
find . -name "*.py"
```

Find large log files

```bash
find . -name "*.log" -size +100M
```

---

# 9. Mental Model

```
Need to find a file?
        ↓
      find

Need to search text?
        ↓
      grep

Need OR, +, ?, ()?
        ↓
    grep -E

Need Perl regex (\d, \w, lookaheads)?
        ↓
    grep -P

Need to watch logs?
        ↓
    tail -f

Need context?
        ↓
grep -A
grep -B
grep -C
```

---

# 10. Platform Engineer Recipes

Search for errors

```bash
grep -r ERROR .
```

Find TODOs

```bash
grep -rn TODO .
```

Search every log

```bash
find . -name "*.log" | xargs grep ERROR
```

Find exceptions with surrounding lines

```bash
grep -C 10 Exception app.log
```

Find multiple log levels

```bash
grep -E "ERROR|WARNING|FATAL" app.log
```

Ignore INFO messages

```bash
grep -v INFO app.log
```

Live monitoring

```bash
tail -f app.log | grep ERROR
```

Find files containing a string

```bash
grep -rl "database" .
```

Count matching lines

```bash
grep -c ERROR app.log
```

Show only matching text

```bash
grep -o "[0-9]\+" app.log
```