# Week 3 Project - CI/CD with GitHub Actions

## Objective

Build a production-style CI/CD pipeline using GitHub Actions.

The goal is to understand how modern engineering teams automatically validate, test, package, and prepare applications for deployment.

By the end of this project, I should be comfortable reading, modifying, and creating GitHub Actions workflows commonly found in Platform Engineering repositories.

---

# Project Overview

Create a small Python application and automate its validation using GitHub Actions.

The application itself should remain simple—the focus is learning CI/CD.

Suggested project structure:

```text
github-actions-python-demo/
├── app/
│   ├── __init__.py
│   └── validator.py
├── tests/
│   └── test_validator.py
├── reports/
├── .github/
│   └── workflows/
│       ├── ci.yml
│       └── deploy.yml
├── Dockerfile
├── requirements.txt
├── requirements-dev.txt
└── README.md
```

---

# Learning Objectives

- Understand CI vs CD
- Read and write GitHub Actions workflows
- Configure workflow triggers
- Understand jobs and steps
- Use GitHub-hosted runners
- Install project dependencies
- Execute automated tests
- Perform linting
- Build Docker images
- Upload workflow artifacts
- Configure branch protection
- Use GitHub Environments
- Authenticate to AWS using OIDC

---

# Stage 1 — Basic Continuous Integration

## Goal

Create the first GitHub Actions workflow.

### Requirements

Trigger on:

- Pushes to `main`
- Pull requests targeting `main`
- Manual execution (`workflow_dispatch`)

Pipeline should:

- Checkout repository
- Setup Python
- Install dependencies
- Run linting
- Run unit tests

### Deliverable

A passing GitHub Actions workflow.

---

# Stage 2 — Multiple Jobs

Split the workflow into multiple jobs.

Suggested jobs:

- lint
- test
- validate

Create a final build job that depends on all previous jobs.

Example flow:

```text
lint
      \
test -----> build
      /
validate
```

### Goal

Understand job dependencies (`needs`).

---

# Stage 3 — Workflow Artifacts

Generate reports such as:

- Test results
- Coverage report

Upload them as GitHub Actions artifacts.

### Goal

Learn how CI pipelines preserve build outputs and reports.

---

# Stage 4 — Docker Integration

Add a Dockerfile.

Pipeline should:

- Build the Docker image
- Verify the image builds successfully

Stretch Goal:

Run the container inside CI.

---

# Stage 5 — Pull Request Validation

Create a feature branch.

Intentionally break the project.

Examples:

- Break a unit test
- Introduce a linting error

Open a Pull Request.

Observe:

- Workflow failure
- Failed checks
- Fix the issue
- Workflow succeeds

### Goal

Experience a realistic Pull Request review workflow.

---

# Stage 6 — Branch Protection

Configure GitHub repository rules.

Require:

- Passing CI
- Pull Requests before merging

Verify:

Broken code cannot be merged into `main`.

---

# Stage 7 — Deployment Workflow

Create a second workflow.

Trigger only after merging into `main`.

Concept:

```text
Feature Branch
      │
      ▼
Pull Request
      │
      ▼
CI Pipeline
      │
      ▼
Merge
      │
      ▼
Deployment Workflow
```

The deployment can initially be a placeholder.

Goal is understanding workflow separation.

---

# Stage 8 — GitHub Environments

Create environments such as:

- Development
- Staging
- Production

Experiment with:

- Deployment approvals
- Environment secrets

---

# Stage 9 — AWS Authentication (OIDC)

Authenticate GitHub Actions to AWS without storing AWS access keys.

Pipeline should:

- Assume an IAM Role
- Receive temporary credentials
- Execute a simple AWS command

Suggested first deployment:

- Upload a file to S3

Later possibilities:

- Push Docker image to ECR
- Deploy to ECS
- Deploy Lambda

---

# Final Architecture

```text
Developer
      │
      ▼
Feature Branch
      │
      ▼
Pull Request
      │
      ▼
GitHub Actions
      │
      ├── Checkout
      ├── Setup Python
      ├── Install Dependencies
      ├── Lint
      ├── Test
      ├── Validate
      ├── Build Docker Image
      └── Upload Artifacts
      │
      ▼
Required Checks Pass
      │
      ▼
Merge into main
      │
      ▼
Deployment Workflow
      │
      ▼
GitHub Environment
      │
      ▼
AWS (OIDC)
```

---

# Stretch Goals

- Cache Python dependencies
- Build Docker images using Buildx
- Push Docker images to GitHub Container Registry (GHCR)
- Add a workflow badge to the README
- Run matrix builds against multiple Python versions
- Run security scanning (Bandit or Trivy)
- Add code coverage reporting
- Automatically create GitHub Releases

---

# Success Criteria

By the end of this project I should be able to:

- Build GitHub Actions workflows from scratch
- Understand jobs, steps, runners, and triggers
- Debug failing CI pipelines
- Build Docker images in CI
- Upload workflow artifacts
- Configure repository protections
- Understand deployment workflows
- Authenticate to AWS using OIDC
- Explain the complete CI/CD lifecycle during an interview