# Python Testing and Quality Toolbox

Quick reference for common Python development tools used in CI/CD pipelines.

---

# Development Workflow

Typical local workflow:

```text
Write code
      │
      ▼
Run Ruff
      │
      ▼
Fix style issues
      │
      ▼
Run Pytest
      │
      ▼
Verify application works
      │
      ▼
Commit
      │
      ▼
Push
      │
      ▼
GitHub Actions runs the same commands
```

---

# Pytest

## Purpose

Pytest is a Python **testing framework**.

It executes test files and verifies that the application behaves as expected.

Think:

> **Does my code work correctly?**

---

## Common Commands

Run all tests:

```bash
python -m pytest -v
```

Run a specific test file:

```bash
python -m pytest tests/test_validator.py
```

Run a specific test:

```bash
python -m pytest tests/test_validator.py::test_valid_environments
```

Output example:

```bash

...

collected 3 items                                                                               

tests/test_validator.py::test_valid_environments PASSED                                   [ 33%]
tests/test_validator.py::test_invalid_environment PASSED                                  [ 66%]
tests/test_validator.py::test_environment_is_case_insensitive PASSED                      [100%]

======================================= 3 passed in 0.01s =======================================
```
---

## Why `python -m pytest`?

Sometimes running:

```bash
pytest
```

can produce import errors depending on the project structure.

Using:

```bash
python -m pytest
```

runs pytest through the active Python interpreter and is generally more reliable.

---

## Test Anatomy

Example:

```python
def test_invalid_environment():
    assert not validate_environment("test")
```

The test:

1. Calls the function.
2. Compares the result.
3. Reports PASS or FAIL.

---

# Ruff

## Purpose

Ruff is a Python **linter**.

It checks:

- Code quality
- Style
- Common mistakes
- Potential bugs

Think:

> **Is my code written well?**

It does **not** verify that the program behaves correctly.

---

## Common Commands

Check the project:

```bash
ruff check .
```

Format code:

```bash
ruff format .
```

Check a specific file:

```bash
ruff check app/validator.py
```

Output example:

```bash
All checks passed!
```

---

## Where should I run Ruff?

Run Ruff from the project root.

Example:

```text
github-actions-python-demo/
│
├── app/
├── tests/
└── README.md
```

```bash
cd github-actions-python-demo

ruff check .
```

The `.` means:

> Check the current directory recursively.

---

# Pytest vs Ruff

| Pytest | Ruff |
|---------|------|
| Tests application behavior | Checks code quality |
| Executes test files | Analyzes source code |
| Finds bugs | Finds style and quality issues |
| Uses `assert` | Uses linting rules |

---

# Local Development Workflow

Every code change should follow this process:

```bash
ruff check .

python -m pytest -v
```

If both succeed:

```bash
git add .
git commit -m "..."
git push
```

GitHub Actions will later execute the same commands automatically.

---

# Mental Model

| Tool | Purpose |
|------|---------|
| `python` | Run the application |
| `pytest` | Verify the application works correctly |
| `ruff` | Verify the source code follows quality rules |
| `git` | Version control |
| GitHub Actions | Automate the entire workflow |

---

# CI/CD Relationship

```text
Developer
      │
      ▼
Write Code
      │
      ▼
Run Ruff
      │
      ▼
Run Pytest
      │
      ▼
Commit
      │
      ▼
Push
      │
      ▼
GitHub Actions
      │
      ├── Ruff
      └── Pytest
      │
      ▼
Merge if successful
```