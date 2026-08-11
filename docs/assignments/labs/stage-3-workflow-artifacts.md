# Stage 3 — Workflow Artifacts

## Objective

Learn how GitHub Actions can preserve files generated during a workflow.

GitHub-hosted runners are temporary. Files created during a job normally disappear after the runner is destroyed.

**Workflow artifacts** allow selected files or directories to be uploaded to GitHub and retained after the workflow finishes.

---

## Artifact Flow

```text
GitHub Actions Runner
        │
        ▼
Run CI jobs
        │
        ▼
Generate file
        │
        ▼
Upload artifact
        │
        ▼
Runner is destroyed
        │
        ▼
Artifact remains available in GitHub
```

Common artifacts include:

- Test reports
- Coverage reports
- Build logs
- Compiled applications
- Generated documentation
- Validation reports

---

## Generate a Build Report

The `build` job depends on the validation jobs:

```yaml
build:
  needs:
    - lint
    - test
    - validate
```

Therefore, the build job only proceeds normally if all three required jobs succeed.

Generate a simple report:

```yaml
- name: Create build report
  run: |
    mkdir -p reports

    echo "Python CI Report" > reports/build-report.txt
    echo "Workflow completed successfully." >> reports/build-report.txt
    echo "Lint: PASS" >> reports/build-report.txt
    echo "Tests: PASS" >> reports/build-report.txt
    echo "Validation: PASS" >> reports/build-report.txt
```

This creates:

```text
reports/build-report.txt
```

Example contents:

```text
Python CI Report
Workflow completed successfully.
Lint: PASS
Tests: PASS
Validation: PASS
```

---

## `>` vs `>>`

Shell redirection was used to create the report.

Create or overwrite a file:

```bash
echo "Python CI Report" > report.txt
```

Append to an existing file:

```bash
echo "Tests: PASS" >> report.txt
```

### Mental Model

```text
>     create/overwrite
>>    append
```

---

## Upload the Artifact

Use GitHub's artifact action:

```yaml
- name: Upload build report
  uses: actions/upload-artifact@v4
  with:
    name: build-report
    path: week03-cicd/projects/github-actions-python-demo/reports/build-report.txt
```

### `name`

```yaml
name: build-report
```

Determines the artifact name displayed in GitHub.

### `path`

```yaml
path: week03-cicd/projects/github-actions-python-demo/reports/build-report.txt
```

Specifies the file that GitHub should upload.

---

## Important: `working-directory` and `uses`

The job uses:

```yaml
defaults:
  run:
    working-directory: week03-cicd/projects/github-actions-python-demo
```

This affects `run:` commands.

For example:

```yaml
run: |
  mkdir -p reports
  echo "report" > reports/build-report.txt
```

executes from:

```text
week03-cicd/projects/github-actions-python-demo/
```

Therefore the actual file becomes:

```text
week03-cicd/projects/github-actions-python-demo/reports/build-report.txt
```

However:

> `defaults.run.working-directory` applies to `run:` steps, not `uses:` actions.

Therefore:

```yaml
uses: actions/upload-artifact@v4
```

must receive the appropriate path relative to the checked-out repository workspace:

```yaml
path: week03-cicd/projects/github-actions-python-demo/reports/build-report.txt
```

---

## Troubleshooting: No Files Found

Encountered:

```text
Warning: No files were found with the provided path.
No artifacts will be uploaded.
```

### Debugging Artifact Paths

If unsure whether a file exists before uploading:

```yaml
- name: Verify report
  run: |
    pwd
    ls -la reports
    cat reports/build-report.txt
```

Useful commands:

```bash
pwd
ls -la
ls -la reports
cat reports/build-report.txt
```

---

## Complete Build Job

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

    - name: Build ready
      run: echo "All validation jobs passed. Ready to build."

    - name: Create build report
      run: |
        mkdir -p reports

        echo "Python CI Report" > reports/build-report.txt
        echo "Workflow completed successfully." >> reports/build-report.txt
        echo "Lint: PASS" >> reports/build-report.txt
        echo "Tests: PASS" >> reports/build-report.txt
        echo "Validation: PASS" >> reports/build-report.txt

    - name: Upload build report
      uses: actions/upload-artifact@v4
      with:
        name: build-report
        path: week03-cicd/projects/github-actions-python-demo/reports/build-report.txt
```

---

## Key Concepts Learned

### Workflow Artifact

A file or directory generated during CI and uploaded to GitHub so it remains available after the runner is destroyed.

### `actions/upload-artifact`

Reusable GitHub Action for uploading workflow files:

```yaml
uses: actions/upload-artifact@v4
```

### `with`

Provides configuration to an action:

```yaml
with:
  name: build-report
  path: path/to/file
```

### Runner Files Are Temporary

Files created during a job exist on the GitHub-hosted runner.

```text
Runner
  │
  ├── repository
  ├── reports/
  └── build-report.txt
        │
        ▼
upload-artifact
        │
        ▼
GitHub artifact storage
```

Without the upload step, those files disappear when the runner is destroyed.

---

## Stage 3 Result

The CI pipeline now performs:

```text
lint ─────────┐
              │
test ─────────┼──► build
              │       │
validate ─────┘       ▼
                 Create Report
                       │
                       ▼
                 Upload Artifact
                       │
                       ▼
                Stored in GitHub
```

Stage 3 introduced the concept of **persisting CI outputs** rather than only reporting whether a workflow passed or failed.