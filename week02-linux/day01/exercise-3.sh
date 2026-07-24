#!/bin/bash

# ==============================
# Move completed log files into an archive directory.
# ==============================

"
Assume your porject looks like:

project/
├── logs/
│   ├── app.log
│   ├── upload.log
│   ├── error.log
│   └── debug.log
└── archive/

From the project directory, move all log files into the archive:
"

mkdir -p project/{logs/archive}

cd project/logs

touch {app,upload,error,debug}.log

mv *.log ../archive