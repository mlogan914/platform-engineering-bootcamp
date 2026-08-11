# Stage 2 — Multiple Jobs & Job Dependencies

## Objective

Split the original CI workflow into multiple independent jobs and learn how GitHub Actions controls job execution and dependencies.

Stage 1 used a single job containing multiple steps.

Stage 2 changed the pipeline to:

```text
lint ──────┐
           │
test ──────┼──► build
           │
validate ──┘
```

The `lint`, `test`, and `validate` jobs can run independently.

The `build` job waits for all three to succeed.

---

## Jobs vs Steps

A **job** is a major unit of work in a GitHub Actions workflow.

A **step** is an individual action or command inside a job.

```yaml
jobs:

  test:                         # Job
    runs-on: ubuntu-latest

    steps:
      - name: Checkout          # Step
        uses: actions/checkout@v4

      - name: Run tests         # Step
        run: python -m pytest -v
```

Mental model:

```text
Workflow
   │
   ├── Job
   │    ├── Step
   │    ├── Step
   │    └── Step
   │
   └── Job
        ├── Step
        └── Step
```

---

## Separate CI Jobs

The workflow was divided into:

### Lint

Checks Python code quality:

```bash
ruff check .
```

### Test

Runs automated unit tests:

```bash
python -m pytest -v
```

### Validate

Performs application-level validation:

```bash
python -c "from app.validator import validate_environment; assert validate_environment('production')"

python -c "from app.validator import validate_environment; assert not validate_environment('invalid')"
```

### Build

Runs only after all validation jobs succeed.

At this stage, the build job was a placeholder:

```yaml
- name: Build ready
  run: echo "All validation jobs passed. Ready to build."
```

A real Docker build is added in Stage 4.

---

## Jobs Run on Separate Runners

Each GitHub-hosted job receives its own runner.

Conceptually:

```text
lint
  │
  └── Ubuntu Runner #1

test
  │
  └── Ubuntu Runner #2

validate
  │
  └── Ubuntu Runner #3
```

This means jobs do **not** automatically share:

- Installed dependencies
- Files generated during another job
- Environment variables
- Processes
- Virtual environments

For example, installing dependencies in `lint` does not install them for `test`.

Each job must perform the setup it requires.

Example:

```yaml
steps:
  - name: Check out repository
    uses: actions/checkout@v4

  - name: Set up Python
    uses: actions/setup-python@v5
    with:
      python-version: "3.10"

  - name: Install dependencies
    run: pip install -r requirements-dev.txt
```

This repetition is expected because each job starts in a fresh environment.

---

## Parallel Jobs

Jobs without dependencies can run in parallel.

For example:

```yaml
jobs:
  lint:
    ...

  test:
    ...

  validate:
    ...
```

GitHub does not need to wait for `lint` before starting `test`.

Conceptually:

```text
             ┌── lint
Workflow ────┼── test
             └── validate
```

This can make CI faster than placing every operation into one sequential job.

---

## Job Dependencies with `needs`

The `build` job should not run until validation succeeds.

Use:

```yaml
build:
  needs:
    - lint
    - test
    - validate
```

Equivalent compact syntax:

```yaml
needs: [lint, test, validate]
```

This creates the dependency:

```text
lint ──────┐
           │
test ──────┼──► build
           │
validate ──┘
```

`build` waits for the required jobs.

---

## Failure Behavior

An intentional validation failure was used to verify the dependency.

Expected result:

```text
lint       PASS
test       PASS
validate   FAIL
build      SKIPPED
```

Because:

```yaml
build:
  needs:
    - lint
    - test
    - validate
```

GitHub will not normally run `build` when one of its required jobs fails.

After fixing the validation:

```text
lint       PASS
test       PASS
validate   PASS
              │
              ▼
build      PASS
```

This is useful because expensive or downstream operations should generally not occur when earlier validation has failed.

---

## `uses:` vs `needs:`

These keywords operate at different levels.

### `uses:`

Used inside a **step** to execute a reusable GitHub Action.

```yaml
steps:
  - name: Checkout repository
    uses: actions/checkout@v4
```

Think:

> Use this existing action.

### `needs:`

Used at the **job level** to define job dependencies.

```yaml
build:
  needs:
    - lint
    - test
```

Think:

> This job needs these jobs to succeed first.

---

## Important Workflow Keywords

```text
Workflow
│
├── on
│
└── jobs
     │
     ├── job
     │    ├── runs-on
     │    ├── needs
     │    └── steps
     │         ├── name
     │         ├── uses
     │         ├── with
     │         └── run
     │
     └── job
```

| Keyword | Level | Purpose |
|---|---|---|
| `on` | Workflow | Defines when the workflow runs |
| `jobs` | Workflow | Defines the jobs |
| `runs-on` | Job | Selects the runner |
| `needs` | Job | Defines dependencies on other jobs |
| `steps` | Job | Defines operations inside the job |
| `name` | Step | Human-readable step name |
| `uses` | Step | Runs a reusable action |
| `with` | Step | Supplies configuration to an action |
| `run` | Step | Executes shell commands |

---

## Stage 2 Result

The original Stage 1 pipeline was approximately:

```text
CI Job
  │
  ├── Checkout
  ├── Setup Python
  ├── Install dependencies
  ├── Ruff
  └── Pytest
```

Stage 2 evolved it into:

```text
              ┌── lint ────────┐
              │                │
Workflow ─────┼── test ────────┼──► build
              │                │
              └── validate ────┘
```

### Key Concepts Learned

- A workflow can contain multiple jobs.
- A job contains multiple steps.
- Each GitHub-hosted job runs on its own runner.
- Separate jobs do not automatically share their environments.
- Independent jobs can execute in parallel.
- `needs` creates dependencies between jobs.
- A dependent job is normally skipped if a required job fails.
- `uses` executes reusable actions inside steps.
- `needs` controls relationships between jobs.

Stage 2 changed the workflow from a simple sequence of commands into a small CI pipeline with **parallel execution and dependency control**.