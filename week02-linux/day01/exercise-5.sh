#!/bin/bash

# ==============================
# Find every .log file underneath the project directory.
# ==============================

tldr du

# Most common
du -sh *

"
28K     exercise-1
4.0K    exercise-1.sh
24K     exercise-2
4.0K    exercise-2.sh
16K     exercise-3
4.0K    exercise-3.sh
16K     exercise-4
4.0K    exercise-4.sh
4.0K    exercise-5.sh

"

# Sort by size
du -sh * | sort -h

"
4.0K    exercise-1.sh
4.0K    exercise-2.sh
4.0K    exercise-3.sh
4.0K    exercise-4.sh
4.0K    exercise-5.sh
16K     exercise-3
16K     exercise-4
24K     exercise-2
28K     exercise-1

"

# Largest first
du -sh * | sort -hr

"
28K     exercise-1
24K     exercise-2
16K     exercise-4
16K     exercise-3
4.0K    exercise-5.sh
4.0K    exercise-4.sh
4.0K    exercise-3.sh
4.0K    exercise-2.sh
4.0K    exercise-1.sh

"