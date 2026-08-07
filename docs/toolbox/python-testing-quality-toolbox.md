# Python Testing and Quality Toolbox

Quick reference for common Python development tools used in CI/CD pipelines.

---

<details>
<summary><strong>Development Workflow</strong></summary>

Typical local workflow:

```text
Write code
      │
      ▼
Run Ruff
      │
      ▼
Fix linting issues
      │
      ▼
Run Compileall
      │
      ▼
Fix syntax errors
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

</details>

---

<details>
<summary><strong>Ruff</strong></summary>

## Purpose

Ruff is a Python **linter**.

It checks:

- Code quality
- Style
- Common mistakes
- Potential bugs
- Some syntax-related issues

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

```text
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

</details>

---

<details>
<summary><strong>Compileall</strong></summary>

## Purpose

`compileall` attempts to compile every Python file into Python bytecode.

It verifies that Python can successfully parse every source file.

Think:

> **Can Python understand my code?**

It catches problems such as:

- Missing colons
- Invalid indentation
- Missing parentheses
- Invalid syntax
- Other parser errors

It **does not** execute your application or verify that your logic is correct.

---

## Common Commands

Compile the current project:

```bash
python -m compileall .
```

Compile a specific directory:

```bash
python -m compileall app
```

Compile a specific file:

```bash
python -m compileall app/validator.py
```

Successful output:

```text
Listing '.'...
Compiling 'app/validator.py'...
```

If a syntax error exists:

```text
SyntaxError: expected ':'
```

---

## Why use Compileall?

Unlike pytest, `compileall` checks **every Python file**, even files that your tests never import.

It is a very fast syntax validation step that provides confidence that the entire codebase is syntactically valid.


</details>

---

<details>
<summary><strong>Pytest</strong></summary>

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

```text
...

collected 3 items

tests/test_validator.py::test_valid_environments PASSED
tests/test_validator.py::test_invalid_environment PASSED
tests/test_validator.py::test_environment_is_case_insensitive PASSED

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


</details>

---

<details>
<summary><strong>Tool Comparison</strong></summary>

| Tool | Primary Question | Executes Code? |
|------|------------------|----------------|
| Ruff | Is the code written well? | No |
| Compileall | Can Python understand the code? | No |
| Pytest | Does the application behave correctly? | Yes |

</details>

---

<details>
<summary><strong>CI/CD Relationship</strong></summary>

```text
Developer
      │
      ▼
Write Code
      │
      ▼
Ruff
(Code quality)
      │
      ▼
Compileall
(Syntax validation)
      │
      ▼
Pytest
(Behavior testing)
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
      ├── Compileall
      └── Pytest
      │
      ▼
Merge if successful
```

</details>