# Platform Engineering Fundamentals Bootcamp

## Overview

This repository documents my self-guided Platform Engineering Bootcamp focused on building strong engineering fundamentals.

The goal of this project is to understand how modern technologies work together to build, deploy, and operate cloud platforms.

Each week focuses on realistic engineering exercises that mirror the types of tasks performed by platform engineering teams. Rather than completing isolated tutorials, the emphasis is on building practical skills through hands-on projects that simulate real-world engineering work.

---

# Learning Goals

- Python automation
- Linux administration
- Git workflows
- Docker
- Terraform
- AWS platform services
- Infrastructure as Code
- Cloud-native automation
- Debugging and troubleshooting
- Building maintainable engineering tools

---

# Bootcamp Roadmap

## Week 1 – Python for Platform Engineers

**Objective**

Learn to solve platform engineering problems using Python.

### Topics

- Python fundamentals
- Functions
- File handling
- JSON
- YAML
- Logging
- argparse
- pathlib
- boto3
- Exception handling

### Project

Build a command-line utility that validates sequencing data, generates reports, and uploads files to Amazon S3.

---

## Week 2 – Linux Fundamentals

**Objective**

Become comfortable working in Linux as a platform engineer.

### Topics

- Filesystem navigation
- Permissions
- Users and groups
- Processes
- SSH
- Networking
- Logs
- System troubleshooting

### Project

Diagnose and repair common Linux system issues.

---

## Week 3 – Git & Docker

**Objective**

Learn the development workflow used by platform engineering teams.

### Git

- Branching
- Merging
- Rebasing
- Pull Requests
- Merge conflicts

### Docker

- Images
- Containers
- Dockerfiles
- Volumes
- Environment variables
- Container debugging

### Project

Containerize the Python automation project.

---

## Week 4 – CI/CD with GitHub Actions

### Objective

Automate validation, testing, packaging, and deployment workflows.

### Topics

- CI vs CD
- GitHub Actions workflow syntax
- Events and triggers
- Jobs and steps
- GitHub-hosted runners
- Environment variables
- Secrets
- Dependency installation
- Python linting and testing
- Docker image builds
- Workflow artifacts
- Branch protection and required checks
- Environments and deployment approvals
- AWS authentication using OIDC

### Project

Create a GitHub Actions pipeline that:

- Runs on pull requests and pushes
- Sets up Python
- Installs dependencies
- Runs tests
- Runs linting
- Validates the application
- Builds the Docker image
- Uploads reports as workflow artifacts
- Prevents merging when checks fail
---

## Week 5 – Terraform

**Objective**

Review Infrastructure as Code.

### Topics

- Providers
- Resources
- Variables
- Outputs
- Modules
- State
- Remote State
- Debugging Terraform

### Project

Deploy AWS infrastructure using reusable Terraform modules.

---

## Week 6 – AWS Platform Services

**Objective**

Understand/review the AWS services commonly used by platform engineering teams.

### Topics

- IAM
- S3
- EC2
- ECS
- ECR
- AWS Batch
- CloudWatch

### Project

Deploy and operate a simple cloud platform using AWS services.

---

## Week 7 – Platform Engineering Integration Project

**Objective**

Combine everything learned throughout the bootcamp.

### Final Project

Build a simplified platform that:

- Reads configuration files
- Validates sequencing data
- Uploads files to Amazon S3
- Runs inside Docker
- Uses Git for source control
- Deploys infrastructure with Terraform
- Logs application activity
- Produces execution reports

---

# Repository Structure

```text
platform-engineering-bootcamp/
│
├── README.md
│
├── week01-python/
│
├── week02-linux/
│
├── week03-git-docker/
│
├── week04-cicd/
│
├── week05-terraform/
│
├── week06-aws/
│
└── week07-platform-project/
```

---

# Development Workflow

For each assignment I will:

1. Create a feature branch.
2. Complete the exercise.
3. Commit changes with meaningful commit messages.
4. Open a pull request.
5. Review and improve the code.
6. Merge into the `main` branch.

The goal is to practice the same workflow commonly used by engineering teams.

---

# Guiding Principles

Throughout this bootcamp focus on:

- Writing readable code.
- Building maintainable solutions.
- Understanding why technologies exist.
- Solving real engineering problems.
- Developing practical troubleshooting skills.
- Learning by building instead of memorizing.

Whenever possible, each exercise should answer one question:

> **Would I realistically encounter this problem as a Platform Engineer?**

If the answer is **yes**, it belongs in this repository.