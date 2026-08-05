# Part 2 - Continuous Integration (GitHub Actions)

## Objective

Automate the same validation steps performed locally using GitHub Actions.

Instead of relying on developers to manually execute tests before committing, GitHub Actions automatically validates every change.

---

# What is Continuous Integration (CI)?

Continuous Integration (CI) is the practice of automatically validating code whenever changes are pushed to a repository.

Typical CI tasks include:

- Installing dependencies
- Running unit tests
- Running linters
- Building applications
- Validating configuration
- Producing build artifacts

The goal is to catch problems early before code is merged into the main branch.

---

# CI Workflow

```text
Developer
      │
      ▼
Write Code
      │
      ▼
Run Locally (Optional)
      │
      ├── Ruff
      └── Pytest
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
      ├── Checkout Repository
      ├── Install Python
      ├── Install Dependencies
      ├── Run Ruff
      └── Run Pytest
      │
      ▼
Pass or Fail
```

---

# Repository Structure

GitHub only recognizes workflow files located at:

```text
.github/workflows/
```

Example:

```text
platform_practice/
│
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── week03-cicd/
│   └── projects/
│       └── github-actions-python-demo/
```

> **Important**
>
> `.github/workflows` **must exist at the Git repository root**.
>
> Workflows stored inside project folders are ignored.

---

# First Workflow

File:

```text
.github/workflows/ci.yml
```

```yaml
name: Python CI

on:
  push:
    branches:
      - main
      - week3-cicd

  pull_request:
    branches:
      - main

  workflow_dispatch:

jobs:
  test:
    runs-on: ubuntu-latest

    defaults:
      run:
        working-directory: week03-cicd/projects/github-actions-python-demo

    steps:
      - name: Check out repository
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.10"

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install -r requirements-dev.txt

      - name: Run Ruff
        run: ruff check .

      - name: Run tests
        run: python -m pytest -v
```

---

# Workflow Breakdown

## High-level
```
Workflow (.github/workflows/ci.yml)
│
├── Job
│   ├── Step
│   ├── Step
│   └── Step
├── Job 2
...
```


```yaml
name: Python CI

on:
  push:
    branches:

  pull_request:
    branches:

  workflow_dispatch:

  jobs:
  ...
```

## Keys

## name

Name displayed in the GitHub Actions tab.

```yaml
name: Python CI
```

---

## on

Determines when the workflow executes.

```yaml
on:
```

Current triggers:

### Push

```yaml
push:
```

Runs whenever commits are pushed to matching branches.

---

### Pull Request

```yaml
pull_request:
```

Runs when:

- Opening a PR
- Updating a PR
- Synchronizing a PR

before code is merged.

---

### workflow_dispatch

```yaml
workflow_dispatch:
```

Allows manually running the workflow from GitHub.

---

# Jobs

A workflow contains one or more jobs.

```yaml
jobs:
```

Current workflow contains:

```yaml
test
```

Later projects will include:

- lint
- test
- build
- deploy

---

# GitHub Hosted Runner

```yaml
runs-on: ubuntu-latest
```

GitHub provisions a brand-new Ubuntu virtual machine for every workflow run.

Every execution starts with a clean environment.

Nothing from previous runs is preserved.

---

# Working Directory

```yaml
defaults:
  run:
    working-directory:
```

Specifies where shell commands execute.

For this repository:

```yaml
week03-cicd/projects/github-actions-python-demo
```

---

# Steps

Each job executes steps sequentially.

Current steps:

1. Checkout repository (clone the repository onto the GitHub runner.)
2. Install Python
3. Install dependencies
4. Run Ruff
5. Run Pytest

---

# uses vs run

## uses

Executes a reusable GitHub Action.

Example:

```yaml
uses: actions/checkout@v4
```

Think of it as importing someone else's automation.

---

## run

Executes shell commands on the runner.

Example:

```yaml
run: python -m pytest -v
```

Equivalent to typing commands in a Linux terminal.

---

# Local Commands vs CI

Commands executed locally:

```bash
ruff check .

python -m pytest -v
```

Exactly the same commands executed by GitHub Actions.

One goal of CI is:

> If it works locally, it should work in CI.

---

# GitHub Runner Lifecycle

Each workflow execution follows this process:

```text
Push
    │
    ▼
GitHub creates Ubuntu runner
    │
    ▼
Checkout repository
    │
    ▼
Install Python
    │
    ▼
Install dependencies
    │
    ▼
Run Ruff
    │
    ▼
Run Pytest
    │
    ▼
Report status
    │
    ▼
Destroy runner
```

The runner is temporary.

Nothing is preserved between workflow runs.

---

# Push vs Pull Request

Current workflow runs on:

- Pushes to `week3-cicd`
- Pushes to `main`
- Pull Requests targeting `main`

Typical development flow:

```text
Feature Branch
      │
      ▼
Push
      │
      ▼
CI Runs
      │
      ▼
Open Pull Request
      │
      ▼
CI Runs Again
      │
      ▼
Review
      │
      ▼
Merge
```

Running CI before review ensures reviewers spend time on code that already passes automated checks.

---

# Common Troubleshooting

## Workflow never appears

Verify:

```text
.github/workflows/
```

exists at the repository root.

---

## Working directory not found

Ensure:

```yaml
working-directory:
```

matches the repository layout exactly.

---

## Import errors

Prefer:

```bash
python -m pytest -v
```

instead of:

```bash
pytest -v
```

---

## Dependency installation fails

Confirm:

```text
requirements-dev.txt
```

exists in the specified working directory.

---

# Mental Model

GitHub Actions is simply another Linux machine executing your commands.

Instead of:

```text
My Laptop
```

the commands execute on:

```text
GitHub Runner
```

If you can execute:

```bash
ruff check .

python -m pytest -v
```

locally, GitHub Actions can execute the exact same commands automatically.

---

# Key Takeaways

- CI automatically validates code after pushes and pull requests.
- GitHub Actions workflows must be located in `.github/workflows/`.
- Every workflow executes on a clean, temporary runner.
- `uses:` executes reusable GitHub Actions.
- `run:` executes Linux shell commands.
- The CI pipeline should mirror the commands developers run locally.
- Pull requests typically run CI **before** approval and merge.
- Passing CI builds confidence that changes are safe to integrate.