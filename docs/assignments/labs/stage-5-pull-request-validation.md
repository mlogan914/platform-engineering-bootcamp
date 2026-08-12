# Stage 5 — Pull Request Validation

## Objective

Understand how Continuous Integration integrates with the Pull Request workflow.

The goal is to ensure proposed changes are automatically validated **before they are merged into `main`**.

---

## Pull Request CI Flow

```text
Create Feature Branch
        │
        ▼
Make Changes
        │
        ▼
Push Branch
        │
        ▼
Open Pull Request → main
        │
        ▼
GitHub Actions Runs
        │
        ├── Lint
        ├── Test
        ├── Validate
        └── Docker Build / Run
        │
        ▼
Pass or Fail
```

---

## Workflow Trigger

The CI workflow can run when a Pull Request targets `main`:

```yaml
on:
  pull_request:
    branches:
      - main
```

This means:

> Run this workflow when changes are proposed for `main`.

---

## Failed Pull Request

If one of the CI jobs fails:

```text
lint       PASS
test       FAIL
validate   PASS
build      SKIPPED
```

GitHub displays the failed check on the Pull Request.

The developer can then:

```text
Inspect failed job
      │
      ▼
Read workflow logs
      │
      ▼
Fix code
      │
      ▼
Commit
      │
      ▼
Push to same branch
      │
      ▼
Pull Request updates
      │
      ▼
CI runs again
```

A new Pull Request does **not** need to be created after every fix. New commits pushed to the PR branch update the existing PR.

---

## Successful Pull Request

Once all required CI jobs succeed:

```text
lint       PASS
test       PASS
validate   PASS
              │
              ▼
build      PASS
```

The Pull Request shows successful checks.

---

## CI vs Merge Enforcement

An important distinction:

### CI

GitHub Actions determines:

> Did the proposed change pass validation?

```text
Code
 ↓
CI
 ↓
PASS / FAIL
```

### Repository Rules

Repository rules determine:

> Is the developer allowed to merge when validation fails?

```text
CI FAIL
   │
   ▼
Repository Rule
   │
   ▼
Merge Blocked
```

A failed CI check and a rule that **requires** the check to pass are separate concepts.

This leads into Stage 6 — Branch Protection / Repository Rules.

---

## Stage 5 Result

The development workflow is now:

```text
Feature Branch
      │
      ▼
Pull Request
      │
      ▼
CI Validation
      │
      ├── Ruff
      ├── Pytest
      ├── Application Validation
      └── Docker Validation
      │
      ▼
All Checks Pass
      │
      ▼
Ready to Merge
```

## Key Concepts Learned

- Pull Requests can automatically trigger GitHub Actions.
- CI validates proposed changes before they enter `main`.
- Failed jobs are visible directly on the Pull Request.
- Workflow logs can be used to diagnose failures.
- Pushing additional commits updates the existing Pull Request.
- CI determines whether code passes validation.
- Repository rules determine whether passing CI is **required** before merging.

Stage 5 connects the CI pipeline to the normal Git development workflow.