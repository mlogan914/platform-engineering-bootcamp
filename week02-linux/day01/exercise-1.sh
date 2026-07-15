#!/bin/bash

# ==============================
# Create the following directory structure completely from the command line.
# ==============================
"
project/
├── configs/
├── scripts/
├── logs/
├── data/
└── archive/

Instead of:

mkdir project
mkdir project/configs
mkdir project/scripts
mkdir project/logs
mkdir project/data
mkdir project/archive

you can create the entire structure in one command:

mkdir -p project/{configs,scripts,logs,data,archive}

-p option: means parents

It tells mkdir to:

- Create parent directories if they don't exist.
- Don't complain if a directory already exists.

It becomes:

mkdir -p project/configs \
         project/scripts \
         project/logs \
         project/data \
         project/archive

"

mkdir -p project/{configs,scripts,logs,data,archive}

tree