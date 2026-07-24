#!/bin/bash

# ==============================
# Exercise 1: Make deployment scripts executable.
# ==============================

mkdir -p scripts

echo '#!/bin/bash' > scripts/deploy.sh
echo 'echo "Deploying application..."' >> scripts/deploy.sh

ls -l scripts/deploy.sh

"
-rw-rw-r-- 1 user user 44 Jul 20 15:56 scripts/deploy.sh
"

# Use symbolic permissions to give the file owner execute permission:
chmod u+x scripts/deploy.sh

ls -l scripts/deploy.sh 

"
-rwxrw-r-- 1 user user 44 Jul 20 15:56 scripts/deploy.sh
"

./scripts/deploy.sh

"
Deploying application...
"

# ==============================
# Exercise 2: Protect reports from accidental modification
# ==============================

# Protect reports from accidental modification.

" 
The goal is to make a configuration file readable and writable only by its owner

For configuration files that may contain secrets (API keys, passwords, connection strings), that's usually too permissive.

Your task

Use numeric (octal) permissions to make the file:

Owner: read + write
Group: no permissions
Others: no permissions

"
mkdir -p config

touch config/database.conf

ls -l config/database.conf

"
-rw-rw-r-- 1 user user 0 Jul 20 16:06 config/database.conf
"

chmod 600 config/database.conf

ls -la config/database.conf 

"
-rw------- 1 user user 0 Jul 20 16:06 config/database.conf
"

# ==============================
# Exercise 3: Share a directory with another engineering team
# ==============================

mkdir -p shared

ls -ld shared

groups

"
mlogan adm cdrom sudo dip plugdev lpadmin lxd sambashare docker
"

# Change the directory's group
sudo chgrp docker shared

ls -ld shared

"
drwxrwxr-x 2 mlogan docker 4096 Jul 20 17:35 shared
"

# Give the group write access
# Make the directory accessible to the owner and group only

chmod 770 shared

ls -ld shared

# ==============================
# Exercise 4: Secure application configuration files
# ==============================

"
Scenario

You've deployed an application, and its configuration file contains sensitive information such as:

Database credentials
API keys
Service tokens

Currently, the file is readable by everyone:
-rw-r--r--  app.conf
"

# Create a configuration file
mkdir -p config

cat > config/app.conf <<EOF
DB_HOST=db.internal
DB_USER=platform
DB_PASSWORD=SuperSecretPassword
API_KEY=abc123xyz
EOF

# Check the current permissions
ls -l config/app.conf

# Secure permissions
" 
Note: The owner should be able to read and write the file. Execute is 
unnecessary because a configuration file is data, not a program.
"
chmod 600 config/app.conf

# ==============================
# Extra Practice: Change file ownership 
# ==============================

# Share a directory with another engineering team.

"
Imagine your deployment process created a file owned by the wrong user:

-rw-r--r-- 1 root root 245 Jul 20 app.log

Your application runs as the user appuser, so it needs to own the log file.
"

mkdir -p logs

touch logs/app.log

# First, verify the current owner:
ls -l logs/app.log

sudo chown root logs/app.log

"
ls -la logs/app.log
-rw-rw-r-- 1 root user 0 Jul 20 16:53 logs/app.log
"

sudo chown mlogan logs/app.log
"
-rw-rw-r-- 1 mlogan mlogan 0 Jul 20 16:53 logs/app.log
"