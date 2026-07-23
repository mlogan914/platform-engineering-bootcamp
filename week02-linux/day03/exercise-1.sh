#!/bin/bash

# ==============================
# Generate SSH keys
# ==============================

# Check if you already have SSH keys

ls -la ~/.ssh

# Create new key (no overwrite)
ssh-keygen -t ed25519 -C "platform-bootcamp" -f ~/.ssh/platform_bootcamp_ed25519

# Verify the files
ls -l ~/.ssh/platform_bootcamp_ed25519*

"
-rw------- 1 mlogan mlogan 411 Jul 23 12:22 /home/mlogan/.ssh/platform_bootcamp_ed25519
-rw-r--r-- 1 mlogan mlogan  99 Jul 23 12:22 /home/mlogan/.ssh/platform_bootcamp_ed25519.pub
"

# Display puiblic key
cat ~/.ssh/platform_bootcamp_ed25519.pub