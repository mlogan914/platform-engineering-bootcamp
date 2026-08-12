# Stage 6 — Branch Protection & Repository Rulesets

## Objective

Protect the `main` branch using a GitHub repository ruleset.

The goal was to enforce the development workflow established in the previous stages:

```text
Feature Branch
      │
      ▼
Pull Request
      │
      ▼
GitHub Actions CI
      │
      ▼
Required Checks Pass
      │
      ▼
Merge into main
```

Before this stage, GitHub Actions could detect failing code, but CI alone did not necessarily prevent that code from being merged or pushed directly to `main`.

Stage 6 added **enforcement**.

---

# CI vs Repository Rules

These are separate concepts.

## GitHub Actions / CI

CI answers:

> Does this code pass our automated validation?

For this project:

```text
lint
test
validate
build
```

Each check reports success or failure.

Example:

```text
lint       PASS
test       FAIL
validate   PASS
build      SKIPPED
```

CI identifies the problem.

---

## Repository Ruleset

The ruleset answers:

> What is GitHub allowed to do based on those results?

For example:

```text
test fails
    │
    ▼
CI reports failure
    │
    ▼
Required status check fails
    │
    ▼
Ruleset blocks merge
```

Mental model:

```text
GitHub Actions = Validation

Repository Ruleset = Enforcement
```

---

# Configure the Ruleset

In the GitHub repository:

```text
Settings
   ↓
Rules
   ↓
Rulesets
   ↓
New branch ruleset
```

Create a ruleset protecting:

```text
main
```

Set the ruleset to:

```text
Active
```

---

# Require Pull Requests

Enable:

```text
Require a pull request before merging
```

This establishes the expected workflow:

```text
Feature Branch
      │
      ▼
Pull Request
      │
      ▼
main
```

Instead of developers making ordinary direct changes to `main`, changes should go through a Pull Request.

---

# Require CI Checks

Enable:

```text
Require status checks to pass
```

The CI checks for this project were configured as required checks:

```text
lint
test
validate
build
```

On the Pull Request, GitHub displayed them as checks associated with the Python CI workflow:

```text
Python CI / lint
Python CI / test
Python CI / validate
Python CI / build
```

The ruleset now requires the configured CI checks before the Pull Request can be merged.

---

# Test the Ruleset

Create a test branch from `main`.

```bash
git switch main
git pull origin main
git switch -c test-branch-protection
```

Push the branch:

```bash
git push -u origin test-branch-protection
```

`-u` establishes the upstream tracking relationship.

After this, future pushes can simply use:

```bash
git push
```

---

# Intentionally Break a Test

Modify an existing test so that it intentionally fails.

For example, change a valid assertion such as:

```python
assert not validate_environment("test")
```

to:

```python
assert validate_environment("test")
```

Commit the change:

```bash
git add .
git commit -m "Introduce failing test for branch protection"
git push
```

---

# Open a Pull Request

Create a Pull Request:

```text
test-branch-protection
        ↓
       main
```

The `pull_request` trigger causes the CI workflow to execute.

Conceptually:

```text
Pull Request
     │
     ├── lint
     ├── test
     ├── validate
     └── build
```

---

# Observe the Failure

The intentionally broken test produced:

```text
lint       PASS
test       FAIL
validate   PASS
build      SKIPPED
```

The `build` job was skipped because it depends on:

```yaml
needs:
  - lint
  - test
  - validate
```

Therefore:

```text
lint ──────┐
           │
test ──X───┼──► build
           │       X
validate ──┘    SKIPPED
```

Because `test` failed, the downstream `build` job did not run.

---

# Merge Was Blocked

The Pull Request showed the checks as required.

Because the required checks were not all successful:

```text
test     FAIL
build    SKIPPED
```

GitHub disabled the normal merge operation.

This proved that the repository ruleset was enforcing the CI requirements.

```text
CI failure
    │
    ▼
Required check unsuccessful
    │
    ▼
Ruleset
    │
    ▼
Merge blocked
```

---

# Fix the Failure

Restore the correct test:

```python
assert not validate_environment("test")
```

Then commit and push the fix:

```bash
git add .
git commit -m "Fix failing test"
git push
```

There is no need to create another Pull Request.

The existing PR automatically receives the new commit.

```text
Existing PR
    │
    ▼
New commit pushed
    │
    ▼
PR updates
    │
    ▼
CI runs again
```

---

# Successful CI

After fixing the test, the expected result is:

```text
lint       PASS
test       PASS
validate   PASS
              │
              ▼
build      PASS
```

All required checks are now successful.

The Pull Request satisfies the CI portion of the ruleset and can proceed to merge if all other configured rules are also satisfied.

---

# Push vs Pull Request vs Merge

An important distinction from this exercise:

## `git push`

```bash
git push
```

uploads commits to the remote version of the **current branch**.

For example:

```text
Local:
test-branch-protection
        │
        │ git push
        ▼
GitHub:
test-branch-protection
```

A failing CI check does not normally prevent you from continuing to push commits to your feature branch.

That is useful because feature branches are where work-in-progress code lives.

---

## Pull Request

A Pull Request proposes:

> Merge the changes from this branch into another branch.

For example:

```text
test-branch-protection
        │
        │ Pull Request
        ▼
       main
```

CI can automatically validate that proposed change.

---

## Merge

The merge actually incorporates the feature branch changes into `main`.

```text
Feature Branch
      │
      ▼
Pull Request
      │
      ▼
CI PASS
      │
      ▼
Merge
      │
      ▼
main
```

The repository ruleset controls whether that merge is permitted.

---

# Why CI Alone Is Not Enough

Without repository protection, a workflow could theoretically look like:

```text
Commit pushed to main
        │
        ▼
GitHub Actions
        │
        ▼
TEST FAILED
```

CI detected the problem, but the commit may already be on `main`.

The preferred protected workflow is:

```text
Feature Branch
      │
      ▼
Push
      │
      ▼
Pull Request
      │
      ▼
CI
      │
   PASS?
   /   \
 NO     YES
 │       │
 ▼       ▼
BLOCK   MERGE
          │
          ▼
         main
```

This shifts validation **before** the change reaches the protected branch.

---

# Required Checks Waiting for Status

During the exercise, the Pull Request initially displayed messages similar to:

```text
Checks pending

build      Expected — Waiting for status to be reported
lint       Expected — Waiting for status to be reported
test       Expected — Waiting for status to be reported
validate   Expected — Waiting for status to be reported
```

This means the ruleset expects those checks but GitHub has not yet received their results for the current commit.

Once the workflow runs, those expected statuses are replaced by actual results:

```text
lint       Successful
test       Failing
validate   Successful
build      Skipped
```

This is useful when troubleshooting repository rules:

```text
"Waiting for status to be reported"
```

means the ruleset expects a check, but the corresponding workflow/check has not reported a result yet.

---

# Relationship to `needs`

Stage 6 also demonstrated why job dependencies matter.

The workflow contains:

```yaml
build:
  needs:
    - lint
    - test
    - validate
```

Therefore:

```text
lint ─────────┐
              │
test ─────────┼──► build
              │
validate ─────┘
```

If `test` fails:

```text
test ❌
  │
  ▼
build skipped
```

This prevents downstream work such as Docker builds from occurring when earlier validation has already failed.

---

# Complete Development Flow

The project now implements:

```text
Developer
    │
    ▼
Feature Branch
    │
    ▼
git push
    │
    ▼
Pull Request → main
    │
    ▼
GitHub Actions
    │
    ├── lint
    ├── test
    ├── validate
    └── build
          │
          ▼
     Docker Build
          │
          ▼
      Docker Run
    │
    ▼
Required Checks
    │
    ├── FAIL → Merge Blocked
    │
    └── PASS
          │
          ▼
        Merge
          │
          ▼
         main
```

---

# Key Concepts Learned

### Repository Ruleset

Defines and enforces policies for branches such as `main`.

### Require Pull Request

Requires changes to go through the Pull Request workflow before merging into the protected branch.

### Required Status Checks

Makes CI checks mandatory rather than merely informational.

### Feature Branches

Can continue receiving commits even when CI is failing.

```bash
git push
```

is still used while fixing the branch.

### Pull Requests Update Automatically

Pushing additional commits to a branch with an existing Pull Request automatically updates that PR and triggers applicable CI workflows again.

### CI vs Enforcement

```text
GitHub Actions
      │
      ▼
PASS / FAIL
      │
      ▼
Repository Ruleset
      │
      ▼
ALLOW / BLOCK
```

---

# Stage 6 Result

Before Stage 6:

```text
CI detects problems
```

After Stage 6:

```text
CI detects problems
        +
GitHub enforces the result
```

The protected development workflow is now:

```text
Feature Branch
      ↓
Pull Request
      ↓
Required CI
      ↓
lint + test + validate + build
      ↓
All Pass
      ↓
Merge Allowed
      ↓
main
```

Stage 6 demonstrated how GitHub repository rules turn a CI pipeline into an **enforced software development policy**.