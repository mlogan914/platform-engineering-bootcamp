# Project 3 - GitHub Actions CI/CD
## Part 1 - Project Setup

## Objective

Create a simple Python project that will later be automated using GitHub Actions.

The focus of this project is learning CI/CD, not Python.

---

# Repository Structure

```text
week03-cicd/
│
├── .venv/
├── .gitignore
└── projects/
    └── github-actions-python-demo/
        ├── app/
        │   ├── __init__.py
        │   └── validator.py
        ├── tests/
        │   └── test_validator.py
        ├── requirements.txt
        ├── requirements-dev.txt
        └── README.md
```

---

# Step 1 - Create a Feature Branch

Always work on a feature branch.

```bash
git switch main
git pull origin main
git switch -c week3-cicd
```

Verify:

```bash
git branch --show-current
```

Expected:

```text
week3-cicd
```

---

# Step 2 - Create the Project

```bash
mkdir -p projects/github-actions-python-demo/{app,tests}

touch projects/github-actions-python-demo/app/__init__.py

touch projects/github-actions-python-demo/app/validator.py

touch projects/github-actions-python-demo/tests/test_validator.py

touch projects/github-actions-python-demo/requirements.txt

touch projects/github-actions-python-demo/requirements-dev.txt

touch projects/github-actions-python-demo/README.md
```

Verify:

```bash
find projects/github-actions-python-demo -maxdepth 3 -type f | sort
```

Expected:

```text
projects/github-actions-python-demo/app/__init__.py
projects/github-actions-python-demo/app/validator.py
projects/github-actions-python-demo/tests/test_validator.py
projects/github-actions-python-demo/README.md
projects/github-actions-python-demo/requirements-dev.txt
projects/github-actions-python-demo/requirements.txt
```

---

# Step 3 - Create a Virtual Environment

From the repository root:

```bash
python3 -m venv .venv
```

Activate:

```bash
source .venv/bin/activate
```

Verify:

```bash
which python
python --version
```

Expected:

```text
Python 3.10.x
```

---

# Step 4 - Create a .gitignore

```gitignore
.venv/
__pycache__/
*.py[cod]
.pytest_cache/
.coverage
htmlcov/
reports/
```

Purpose:

Ignore generated files that should never be committed.

---

# Step 5 - Development Dependencies

`requirements.txt`

(Currently empty)

```text

```

`requirements-dev.txt`

```text
pytest
ruff
```

Install:

```bash
python -m pip install --upgrade pip

pip install -r projects/github-actions-python-demo/requirements-dev.txt
```

Verify:

```bash
pytest --version

ruff --version
```

---

# Step 6 - Create the Application

File:

```text
app/validator.py
```

```python
"""Simple configuration validation functions."""


def validate_environment(environment: str) -> bool:
    """Return True when the environment is supported."""

    allowed_environments = {
        "development",
        "staging",
        "production",
    }

    return environment.lower() in allowed_environments
```

---

# Step 7 - Manual Testing

Move into the project.

```bash
cd projects/github-actions-python-demo
```

Valid input:

```bash
python -c "from app.validator import validate_environment; print(validate_environment('staging'))"
```

Expected:

```text
True
```

Invalid input:

```bash
python -c "from app.validator import validate_environment; print(validate_environment('test'))"
```

Expected:

```text
False
```

Case-insensitive validation:

```bash
python -c "from app.validator import validate_environment; print(validate_environment('PRODUCTION'))"
```

Expected:

```text
True
```

---

# Step 8 - Unit Tests

File:

```text
tests/test_validator.py
```

```python
"""Tests for environment validation."""

from app.validator import validate_environment


def test_valid_environments():
    assert validate_environment("development")
    assert validate_environment("staging")
    assert validate_environment("production")


def test_invalid_environment():
    assert not validate_environment("test")


def test_environment_is_case_insensitive():
    assert validate_environment("PRODUCTION")
```

---

# Step 9 - Run Tests

Recommended:

```bash
python -m pytest -v
```

Expected:

```text
3 passed
```

## Why `python -m pytest`?

Initially,

```bash
pytest -v
```

produced:

```text
ModuleNotFoundError: No module named 'app'
```

Running pytest through the active Python interpreter correctly resolved the project imports.

For this project, prefer:

```bash
python -m pytest -v
```

---

# Step 10 - Run Ruff

```bash
ruff check .
```

Expected:

```text
All checks passed!
```

---

# Current Project Status

Completed:

- Create feature branch
- Create project structure
- Create virtual environment
- Configure `.gitignore`
- Install development dependencies
- Create application
- Verify application manually
- Create unit tests
- Execute unit tests
- Execute linting

Current workflow:

```text
Write code
      │
      ▼
Run unit tests

python -m pytest -v

      │
      ▼
Run linting

ruff check .

      │
      ▼
Everything passes
```

---

# Next Steps (Coming Soon)

The remaining stages of the project will introduce GitHub Actions incrementally.

## Part 2 - Continuous Integration

- Create `.github/workflows/ci.yml`
- Learn GitHub Actions workflow syntax
- Configure workflow triggers (`push`, `pull_request`, `workflow_dispatch`)
- Use GitHub-hosted runners
- Install dependencies automatically
- Execute Ruff automatically
- Execute Pytest automatically
- Observe passing and failing workflows

## Part 3 - Multi-Job Workflows

- Split the workflow into separate jobs:
  - Lint
  - Test
  - Validate
  - Build
- Learn job dependencies with `needs`

## Part 4 - Docker

- Add a Dockerfile
- Build the Docker image in CI
- Optionally run the container in CI

## Part 5 - Pull Requests

- Create a feature branch
- Introduce intentional failures
- Observe failed checks
- Fix the code
- Re-run the workflow
- Merge successfully

## Part 6 - Branch Protection

- Configure required status checks
- Require pull requests before merging
- Prevent merging when CI fails

## Part 7 - Deployment

- Create a separate deployment workflow
- Trigger deployments after merging to `main`
- Use GitHub Environments
- Add deployment approvals

## Part 8 - AWS

- Configure OIDC authentication
- Assume an IAM role
- Deploy to AWS without long-lived credentials
- Upload an artifact to S3
- Optionally publish a Docker image to ECR

---

# End Goal

By the end of this project, the repository will simulate a production-ready CI/CD pipeline used by Platform Engineering teams.