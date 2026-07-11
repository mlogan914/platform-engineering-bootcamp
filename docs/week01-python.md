<details open>
<summary><strong>Week 1 – Python for Platform Engineers</strong></summary>

## Goal

By the end of this week, you should be comfortable writing small automation scripts that interact with files, configuration, the operating system, and AWS.

> **Objective:** Learn to solve platform engineering problems with Python.

---

<details>
<summary><strong>Day 1 – Python Refresher</strong></summary>

## Learning Objectives

- Variables
- Lists
- Dictionaries
- Functions
- Imports
- Loops
- Virtual environments
- pip

## Progress
- [x] Environment Setup
- [x] Assignment 1
- [x] Assignment 2
- [x] Stretch Goal

---

## Environment Setup

Create a project called:

```text
platform_python_week1
```

Create a virtual environment:

```bash
python -m venv .venv
```

Activate the environment.

Install PyYAML:

```bash
pip install pyyaml
```

---

## Assignment 1 – Sequencing Run Inventory

Create:

```text
inventory.py
```

Pretend you're supporting a sequencing platform.

Create a collection of sequencing runs.

Each run should contain:

- Run ID
- Project Name
- Status
- Number of Samples

Store each run as a dictionary.

Store all runs inside a list.

### Print

- Total number of runs
- Total number of samples
- Only completed runs
- Average samples per run

---

## Assignment 2 – Refactor into Functions

Move your logic into functions.

Suggested functions:

```python
load_runs()

count_samples()

completed_runs()

average_samples()
```

---

## Stretch Goal

Sort sequencing runs by sample count.

</details>

---

<details>
<summary><strong>Day 2 – Working with Files</strong></summary>

## Learning Objectives

### Modules

```python
pathlib
json
csv
yaml
```

Topics:

- Reading files
- Writing files
- Traversing directories

## Progress
- [x] Assignment 1
- [x] Assignment 2
- [x] Assignment 3
- [x] Stretch Goal

---

## Assignment 1 – Create Sample Data

Create a folder:

```text
incoming_data
```

Inside it create fake FASTQ files.

Example:

```text
Patient001_L001_R1.fastq.gz
Patient001_L001_R2.fastq.gz
Patient002_L001_R1.fastq.gz
Patient002_L001_R2.fastq.gz
```

The files can be empty.

---

## Assignment 2 – Scan a Directory

Create:

```text
scan_fastqs.py
```

Use:

```python
from pathlib import Path
```

Your script should:

- Find every FASTQ file
- Count them
- Print filenames
- Count unique patients
- Count R1 files
- Count R2 files

---

## Assignment 3 – Produce JSON Output

Generate:

```text
summary.json
```

Include:

- Total files
- Total patients
- List of filenames

Hint:

```python
import json

json.dump(...)
```

---

## Stretch Goal

Generate:

```text
summary.yaml
```

Module:

```python
import yaml

yaml.dump(...)
```

</details>

---

<details>
<summary><strong>Day 3 – Building Automation</strong></summary>

## Learning Objectives

### Modules

```python
argparse
logging
subprocess
```

## Progress
- [X] Assignment 1
- [X] Assignment 2
- [X] Assignment 3
- [X] Assignment 4
- [X] Stretch Goal

---

## Assignment 1 – Command Line Utility

Create:

```text
pipeline_launcher.py
```

Accept two command line arguments:

```text
--project
```

```text
--input-folder
```

Hint:

```python
import argparse

ArgumentParser(...)
```

---

## Assignment 2 – Validate User Input

Verify:

- Folder exists
- Project name isn't empty

Hint:

```python
Path.exists()
```

Display useful error messages.

---

## Assignment 3 – Logging

Create:

```text
pipeline.log
```

Log:

- Start time
- User inputs
- Success
- Errors

Module:

```python
logging
```

---

## Assignment 4 – Launch a Process

Pretend you're launching a Nextflow workflow.

Instead, execute:

```bash
echo
```

using:

```python
subprocess.run(...)
```

Display:

```text
Launching workflow...
```

---

## Stretch Goal

- Catch exceptions
- Log failures
- Exit gracefully

</details>

---

<details>
<summary><strong>Day 4 – AWS with Python</strong></summary>

## Learning Objectives

### Modules

```python
boto3
pathlib
```

## Progress
- [X] Assignment 1
- [X] Assignment 2
- [X] Assignment 3
- [X] Assignment 4
- [X] Stretch Goal

Install:

```bash
pip install boto3
```

---

## Assignment 1 – AWS Credentials

Verify that your script can connect to AWS using your configured credentials.

---

## Assignment 2 – Upload to S3

Create:

```text
upload.py
```

Research:

```python
boto3.client()

upload_file()
```

Upload one file.

---

## Assignment 3 – List Objects

List every object inside an S3 bucket.

Research:

```python
list_objects_v2()
```

---

## Assignment 4 – Download an Object

Research:

```python
download_file()
```

Download one object.

---

## Stretch Goal

Create:

```python
upload_folder()
```

Upload every file inside a directory.

</details>

---

<details>
<summary><strong>Day 5 – Mini Project</strong></summary>

# Bioinformatics Upload Utility

Pretend scientists need to upload sequencing runs to AWS.

Create a command-line utility.

Suggested project structure:

```text
main.py
config.yaml
uploader.py
validator.py
logger.py
utils.py
```

---

## Requirements

Your application should:

- Read configuration from YAML
- Validate folders
- Count sequencing files
- Produce a JSON summary
- Upload every file to S3
- Log every action
- Handle missing folders gracefully
- Print a final summary report

---

## Suggested Python Modules

```python
pathlib
json
yaml
logging
argparse
boto3
datetime
os
sys
```

</details>

---

# Bonus Challenges

Choose one or two if you finish early.

- Display upload progress
- Skip duplicate uploads
- Retry failed uploads
- Display upload statistics
- Make the project installable and runnable by another engineer

---

# Weekly Success Criteria

By the end of the week you should be comfortable:

- Organizing Python into multiple modules
- Reading and writing JSON
- Reading and writing YAML
- Traversing directories with `pathlib`
- Building CLI applications with `argparse`
- Creating structured logs with `logging`
- Handling exceptions
- Uploading and downloading files from S3 using `boto3`
- Writing maintainable automation scripts

</details>