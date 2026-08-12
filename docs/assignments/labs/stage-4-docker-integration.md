# Stage 4 — Docker Integration

## Objective

Integrate Docker into the GitHub Actions CI pipeline.

The goal was to verify automatically that:

1. The application can be packaged into a Docker image.
2. The resulting Docker image can successfully run as a container.
3. Docker validation only occurs after the earlier CI checks pass.

---

## Pipeline Before Stage 4

After Stage 2, the workflow had three validation jobs followed by a placeholder build job:

```text
lint ──────┐
           │
test ──────┼──► build
           │
validate ──┘
```

The `build` job originally contained a placeholder:

```yaml
- name: Build ready
  run: echo "All validation jobs passed. Ready to build."
```

Stage 4 replaced this placeholder with an actual Docker build and container execution.

---

## Dockerfile

The Python project contains a `Dockerfile` that defines how the application image is created.

Example:

```dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
COPY requirements-dev.txt .

RUN pip install --no-cache-dir -r requirements-dev.txt

COPY app ./app
COPY tests ./tests

CMD ["python", "-c", "from app.validator import validate_environment; print(validate_environment('production'))"]
```

---

## Dockerfile Breakdown

### Base Image

```dockerfile
FROM python:3.10-slim
```

Start with an existing lightweight image containing Python 3.10.

---

### Working Directory

```dockerfile
WORKDIR /app
```

Sets `/app` as the working directory **inside the Docker image/container filesystem**.

Subsequent commands operate relative to `/app`.

---

### Copy Dependencies

```dockerfile
COPY requirements.txt .
COPY requirements-dev.txt .
```

The `.` means:

> Copy the files into the current working directory inside the image.

Because:

```dockerfile
WORKDIR /app
```

was previously set, the files become:

```text
/app/requirements.txt
/app/requirements-dev.txt
```

---

### Install Dependencies

```dockerfile
RUN pip install --no-cache-dir -r requirements-dev.txt
```

Installs the Python packages required by the project.

---

### Copy Application Code

```dockerfile
COPY app ./app
COPY tests ./tests
```

For example:

```dockerfile
COPY app ./app
```

means:

> Copy the local `app/` directory into an `app/` directory under the current image working directory.

With:

```dockerfile
WORKDIR /app
```

the resulting structure inside the image is approximately:

```text
/app/
├── app/
│   ├── __init__.py
│   └── validator.py
├── tests/
├── requirements.txt
└── requirements-dev.txt
```

The first `app` is the container working directory:

```text
/app
```

The second is the Python package copied from the project:

```text
/app/app
```

---

## Container Startup Command

```dockerfile
CMD ["python", "-c", "from app.validator import validate_environment; print(validate_environment('production'))"]
```

`CMD` defines the default command executed when a container starts from the image.

For this exercise, the container runs the validator and prints the result.

Expected:

```text
True
```

---

# Local Docker Validation

Before adding Docker to CI, the image can be tested locally.

From the Python project directory:

```bash
docker build -t github-actions-python-demo .
```

### Breakdown

```text
docker build
```

Build a Docker image.

```text
-t github-actions-python-demo
```

Assign the image a name/tag.

```text
.
```

Use the current directory as the Docker **build context**.

Docker can therefore access files in the current project directory when processing instructions such as:

```dockerfile
COPY app ./app
```

---

## Run the Image Locally

```bash
docker run --rm github-actions-python-demo
```

### `docker run`

Creates and starts a container from the image.

### `--rm`

Automatically removes the container after it exits.

### `github-actions-python-demo`

The image used to create the container.

Expected:

```text
True
```

This confirms that the image does more than merely build — a container created from it can actually start and execute the application.

---

# Add Docker to GitHub Actions

The existing `build` job was updated to perform the Docker validation automatically.

```yaml
build:
  needs:
    - lint
    - test
    - validate

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

    - name: Build Docker image
      run: docker build -t github-actions-python-demo:${{ github.sha }} .

    - name: Run Docker image
      run: docker run --rm github-actions-python-demo:${{ github.sha }}
```

---

# Build the Docker Image in CI

```yaml
- name: Build Docker image
  run: docker build -t github-actions-python-demo:${{ github.sha }} .
```

This tells the GitHub-hosted runner to build the Docker image.

Because the job has:

```yaml
defaults:
  run:
    working-directory: week03-cicd/projects/github-actions-python-demo
```

the final:

```text
.
```

refers to the Python project directory.

Therefore Docker finds the project's:

```text
Dockerfile
app/
tests/
requirements.txt
requirements-dev.txt
```

---

# Tagging with the Git Commit SHA

Instead of only using:

```bash
docker build -t github-actions-python-demo .
```

the CI workflow uses:

```bash
docker build -t github-actions-python-demo:${{ github.sha }} .
```

`${{ github.sha }}` is a GitHub Actions context value containing the commit SHA associated with the workflow run.

Conceptually:

```text
Git commit
    │
    ▼
abc123...
    │
    ▼
Docker image
    │
    ▼
github-actions-python-demo:abc123...
```

This associates the image produced during CI with the exact version of the source code that produced it.

---

# Run the Docker Image in CI

Building successfully does not necessarily prove that the resulting container can start correctly.

Therefore another step was added:

```yaml
- name: Run Docker image
  run: docker run --rm github-actions-python-demo:${{ github.sha }}
```

The workflow now verifies:

```text
Can Docker build the image?
           │
           ▼
          YES
           │
           ▼
Can a container start from it?
           │
           ▼
          YES
```

If the container command exits successfully, the step passes.

If the container fails to start or the application exits with an error, the CI step fails.

---

# Why No Docker Installation Step?

The workflow uses:

```yaml
runs-on: ubuntu-latest
```

The GitHub-hosted Ubuntu runner already provides Docker tooling.

Therefore, for this basic exercise, we can directly execute:

```bash
docker build
docker run
```

without manually installing Docker first.

---

# Job Dependencies Still Apply

The Docker job retains:

```yaml
needs:
  - lint
  - test
  - validate
```

Therefore Docker validation happens downstream of the earlier checks.

```text
lint ─────────┐
              │
test ─────────┼──► Docker Build
              │         │
validate ─────┘         ▼
                     Docker Run
```

If an upstream job fails:

```text
lint       PASS
test       FAIL
validate   PASS

             ↓

build      SKIPPED
```

There is no reason to package code into a Docker image if required CI validation has already failed.

---

# Image vs Container

An important distinction reinforced during this stage:

### Docker Image

A packaged, read-only template containing:

- Application code
- Runtime
- Dependencies
- Files
- Configuration/instructions

Think:

```text
Image = packaged environment/template
```

### Docker Container

A running instance created from an image.

```text
Dockerfile
    │
    ▼
docker build
    │
    ▼
Docker Image
    │
    ▼
docker run
    │
    ▼
Container
```

Therefore:

```bash
docker build
```

creates an **image**.

```bash
docker run
```

creates and runs a **container from that image**.

---

# Stage 4 Result

The CI pipeline now performs:

```text
              ┌── lint ────────┐
              │                │
Workflow ─────┼── test ────────┼──► Docker Build
              │                │         │
              └── validate ────┘         ▼
                                      Docker Run
                                          │
                                          ▼
                                    CI Successful
```

The GitHub Actions workflow completed successfully with both:

```yaml
- name: Build Docker image
  run: docker build -t github-actions-python-demo:${{ github.sha }} .

- name: Run Docker image
  run: docker run --rm github-actions-python-demo:${{ github.sha }}
```

---

## Key Concepts Learned

### `docker build`

Creates a Docker image from a Dockerfile:

```bash
docker build -t image-name .
```

### `docker run`

Creates and starts a container from an image:

```bash
docker run --rm image-name
```

### Docker Build Context

The final `.` in:

```bash
docker build -t image-name .
```

specifies the current directory as the build context.

Docker uses files from this context for instructions such as `COPY`.

### `COPY`

```dockerfile
COPY app ./app
```

Copies the local `app/` directory into an `app/` directory inside the image, relative to the current `WORKDIR`.

### `WORKDIR`

```dockerfile
WORKDIR /app
```

Sets the current working directory inside the Docker image/container filesystem.

### `${{ github.sha }}`

GitHub Actions context value representing the commit SHA associated with the workflow.

Useful for connecting a generated image to a specific source-code revision.

### CI Docker Validation

A stronger CI check performs both:

```text
Build image
    +
Run container
```

rather than checking only whether the Dockerfile builds.

---

# Stage 4 Complete

The pipeline has progressed from source-code validation to application packaging:

```text
Source Code
    │
    ├── Ruff
    ├── Pytest
    └── Application Validation
             │
             ▼
        Docker Build
             │
             ▼
         Docker Image
             │
             ▼
         Docker Run
             │
             ▼
      Working Container
```

Stage 4 demonstrated how Docker can become part of CI so that every validated code revision can also be verified as a buildable and runnable container image.